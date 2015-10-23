#! /bin/bash
# SCANIA-202 automation script

base_location='/data/mexib/data/scania/'
#base_location='/opt/mexib/xib/local/user/sagara/'
echo "Base Location is " $base_location

# OrganisationExport_yyyymmdd.xml file copy Location

loc0=$base_location'diff'
loc1=$base_location'result/input'
loc2=$base_location'file/in'

#echo "Location 0 "$loc0
#echo "Location 1 "$loc1
#echo "Location 2 "$loc2

echo "Set OrganisationExport_yyyymmdd.xml file name"
read ORG

echo "File Name " $ORG
org_file=$base_location''$ORG
echo "ORG File location "$org_file
if [ -e $org_file ]
   then
     echo "File found "$ORG
#---------------TRUE PART-------------------
cp $ORG $loc1
echo "ORG file coppied to "$loc1
sleep 2
cp $ORG $loc2
echo "ORG file coppied to "$loc2
sleep 2

echo "Check file Exsistance"
cd $loc1
#pwd
ls -ltr $loc1 | tail -3
cd $loc2
#pwd
ls -ltr $loc2 | tail -3

# Check File existance
#pwd
loc3=$base_location'file/out/'
cd $loc3
#pwd

#Get the date
prsdt=$(date +"%Y%m%d")
echo 'Check date '$prsdt

#files to check
#AuthorizationDiffImport_yyyymmdd
#AuthorizationMaster
#OrganisationImport_yyyymmdd

AuthDif=$loc3'AuthorizationDiffImport_'$prsdt
OrgImp=$loc3'OrganisationImport_'$prsdt
Mst=$loc3'AuthorizationMaster'

echo $AuthDif
echo $OrgImp
echo $Mst
echo 'Wait for 5 minutes'
sleep 300
###########################################################
if [ -e $AuthDif ]
  then
    if [ -e $Mst ]
      then
        if [ -e $OrgImp ]
          then
#--------------Ready to backup-------------
     	    echo "All the files were found"
##############
#Backup all three files
bkp=$base_location'result/output/'$prsdt
echo "Backup Location "$bkp
mkdir $bkp
ls -ltr $bkp
#pwd
sleep 2
cp * $bkp

#Set the "AuthorizationMaster" file
echo "DIFF File sent Location "$loc0
cp $Mst $loc0

#Take OrgImport and Attest file out
cp $OrgImp $base_location
cp $AuthDif $base_location

cd $base_location
att=$base_location'attest_scania_'$prsdt
cp $AuthDif $att
sleep 5
rm $ORG

rm $AuthDif
rm $OrgImp
rm $Mst

##############
          else
            echo ""$OrgImp" File NOT Found"	
        fi
      else
         echo ""$Mst" File NOT Found" 
     fi
	else
	   echo ""$AuthDif" File NOT Found"
fi
#--------------ELSE PART-------------
else
    echo "Org file incorrect "$org_file

fi
#################################################################

