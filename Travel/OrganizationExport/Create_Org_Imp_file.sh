#! /bin/bash
# SCANIA-202 automation script
################################
base_location='/data/mexib/data/scania/'
#base_location='/opt/mexib/xib/local/user/sagara/'
SCANIA_LOG='/data/mexib/data/scania/scania_org_exp_log.txt'
# OrganisationExport_yyyymmdd.xml file copy Location
timonMon=$(date +"%Y-%m-%d %H:%M:%S")
echo "Organization Export process started at $timonMon	$'\r'" > $SCANIA_LOG
#
loc0=$base_location'diff'
loc1=$base_location'result/input'
loc2=$base_location'file/in'
#
#echo "Location 0 "$loc0
#echo "Location 1 "$loc1
#echo "Location 2 "$loc2
#
tosgr=$(date +"%Y%m%d")
#tmp_file=$(ls 182*)
#mv $tmp_file "OrganisationExport_"$tosgr".xml"
#ORG="OrganisationExport_"$tosgr".xml"
#echo "Set OrganisationExport_yyyymmdd.xml file name"
#read ORG
##### Remove previous files #####
cd $base_location
rm Org_Import_and_Attest.zip AuthorizationDiffImport* attest_scania_* OrganisationImport_*
####
if [ -e OrganisationExport_* ]
then
echo "@Application Support Team : Please make sure that the Organization Import is completed by 18:00 CET Monday.	$'\r'" >> $SCANIA_LOG
echo "Previous week PERS and ANST import will automatically start at 19:00 CET	$'\r'" >> $SCANIA_LOG
echo "If you fail to complete due to any reason by 19:00 CET please inform the Integration support team in advance.	$'\r'" >> $SCANIA_LOG
echo "Organization Export file processing Debug	$'\r'" >> $SCANIA_LOG
echo "=========================================	$'\r'" >> $SCANIA_LOG
echo "Base Location is $base_location 	$'\r'">> $SCANIA_LOG
ORG=$(ls OrganisationExport*)
echo "Detected OrganisationExport File Name: $ORG	$'\r'" >> $SCANIA_LOG
org_file=$base_location''$ORG
#echo "OrganisationExport File location "$org_file 	$'\r'>> $SCANIA_LOG
#if [ -e $org_file ]
#then
#---------------TRUE PART-------------------
cp $ORG $loc1
echo "ORG file copied to $loc1 	$'\r'">> $SCANIA_LOG
sleep 2
cp $ORG $loc2
echo "ORG file copied to $loc2	$'\r'" >> $SCANIA_LOG
sleep 2
#
echo "Check source file Exsistance	$'\r'"  >> $SCANIA_LOG
cd $loc1
#pwd
ls -ltr $loc1 | tail -3
cd $loc2
#pwd
ls -ltr $loc2 | tail -3
#
# Check File existance
#pwd
loc3=$base_location'file/out/'
cd $loc3
#pwd
#
#Get the date
prsdt=$(date +"%Y%m%d")
echo "Check date $prsdt and Expected files 	$'\r'" >> $SCANIA_LOG
#
#files to check
#AuthorizationDiffImport_yyyymmdd
#AuthorizationMaster
#OrganisationImport_yyyymmdd
#
AuthDif=$loc3'AuthorizationDiffImport_'$prsdt
OrgImp=$loc3'OrganisationImport_'$prsdt
Mst=$loc3'AuthorizationMaster'
#
echo $AuthDif >> $SCANIA_LOG
echo $OrgImp >> $SCANIA_LOG
echo $Mst >> $SCANIA_LOG
echo "Wait for 5 minutes till process complete 	$'\r'">> $SCANIA_LOG
sleep 300
###########################################################
if [ -e $AuthDif ]
  then
    if [ -e $Mst ]
      then
        if [ -e $OrgImp ]
          then
#--------------Ready to backup-------------
     	    echo "All the Expected relevant output files found - Processing completed	$'\r'" >> $SCANIA_LOG
##############
#Backup all three files
echo "Start final output file backup	$'\r'" >> $SCANIA_LOG
bkp=$base_location'result/output/'$prsdt
echo "Backup Location: $bkp	$'\r'" >> $SCANIA_LOG
mkdir $bkp
ls -ltr $bkp
#pwd
sleep 2
cp * $bkp
#
#Set the "AuthorizationMaster" file
echo "Set the AuthorizationMaster file	$'\r'" >> $SCANIA_LOG
echo "DIFF File sent Location: $loc0 	$'\r'">> $SCANIA_LOG
cp $Mst $loc0
#
#Take OrgImport and Attest file out
echo "Take OrganizationImport and Attest files to send Support team	$'\r'" >> $SCANIA_LOG
cp $OrgImp $base_location
cp $AuthDif $base_location
#
cd $base_location
att=$base_location'attest_scania_'$prsdt
cp $AuthDif $att
sleep 5
rm $ORG
#
rm $AuthDif
rm $OrgImp
rm $Mst
#
##############
          else
            echo ""$OrgImp" File NOT Found	$'\r'"	 >> $SCANIA_LOG
        fi
      else
         echo ""$Mst" File NOT Found	$'\r'"  >> $SCANIA_LOG
     fi
	else
	   echo ""$AuthDif" File NOT Found	$'\r'" >> $SCANIA_LOG
fi
#else
#    echo "Org file incorrect "$org_file >> $SCANIA_LOG
#fi
#################################################################
## Send Attest SCANIA file to MEXIB80 server to import on Next day
scp attest_scania_* mexib@10.26.16.80:/data/mexib/data/ftp/mecp_import/
echo "Send Attest SCANIA file to MEXIB80 server to import on Next day.	$'\r'" >> $SCANIA_LOG
echo "Attest file will be moving from /data/mexib/data/ftp/mecp_import/ to /data/mexib/data/ftp/mecp_import/in/ at 03:00 CET	$'\r'" >> $SCANIA_LOG
echo "Diffed attest records will receive after processing the attest file	$'\r'" >> $SCANIA_LOG
##Zip Files to attach
cd $base_location
zip -9 Org_Import_and_Attest.zip attest_scania_* OrganisationImport_*
#################################################################
#mail -s "SCANIA OrganisationExport complted at $timonMon" travel.2ndline.int@ebuilder.com < $SCANIA_LOG
#mail -s "SCANIA OrganisationExport complted at $timonMon " sagara.jayathilaka@ebuilder.com < $SCANIA_LOG
mutt -a "Org_Import_and_Attest.zip" -s "SCANIA OrganisationExport complted at $timonMon CET" -- travel.2ndline@ebuilder.com,travel.2ndline.int@ebuilder.com,anna.soderbarj@ebuilder.com < $SCANIA_LOG
#mutt -a "Org_Import_and_Attest.zip" -s "SCANIA OrganisationExport complted at $timonMon CET" -- sagara.jayathilaka@ebuilder.com < $SCANIA_LOG
sleep 10
#--------------ELSE PART-------------
else
    echo "Org file incorrect "$org_file 	$'\r'>> $SCANIA_LOG
mail -s "SCANIA OrganisationExport FAILED at $timonMon" travel.2ndline.int@ebuilder.com < $SCANIA_LOG
#mail -s "SCANIA OrganisationExport FAILED at $timonMon " sagara.jayathilaka@ebuilder.com < $SCANIA_LOG
fi
#