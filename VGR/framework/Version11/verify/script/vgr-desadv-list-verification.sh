#!/bin/bash
#### DESADV copy back missing list
. ~/.bash_profile
#
base_root="/opt/mxib/scripts/verify"
#
##Load functions
##Integration DESADV list function
. $base_root/src/vgr-integration-desadv-list.sh
##VGR DB DESADV List function
. $base_root/sql/vgr-db-desadv-list.sh
. $base_root/src/vgr-db-access.txt
#
#
cd $base_root
#
INT_MIS_DSV=$base_root/tmp/integration-missing-desadv.txt
INT_DSV_SRT=$base_root/tmp/integration-desadv-list-sorted.txt
INT_DSV=$base_root/tmp/integration-desadv-list.txt
DB_DSV_SRT=$base_root/tmp/vgr-db-desadv-list-sorted.txt
DB_DSV=$base_root/tmp/vgr-db-desadv-list.txt
INT_DUP_DSV=$base_root/tmp/xib-duplicate-desadv-list.txt
DSV_CHK=$base_root/output/vgr-check-desadv.txt
LOG=$base_root/output/log.txt
#
## Clear previousely created file.
rm $INT_MIS_DSV
rm $INT_DSV_SRT
rm $INT_DSV
rm $DB_DSV_SRT
rm $DB_DSV
rm $INT_DUP_DSV
rm $DSV_CHK
#
#
echo "DESADV verification Script started ... " >> $LOG
#sleep 59
cktm=$(date +"%Y-%m-%d %H:%M:%S")
ctm=$(date +"%Y-%m-%d_%H-%M-%S")
echo $ctm >> $LOG
#
#
## Time range generate for VGR DESADV list.
tm1=$(date --date='1 day ago' +"%Y-%m-%d")
tm2=$(date +"%Y-%m-%d")
tm3=2
echo $tm1 >> $LOG
echo $tm2 >> $LOG
echo $tm3 >> $LOG
#
#
##Call SQL method to create DB DESADV List
#VgrDbDESADVList ( spool_file , start_day , end_day)
VgrDbDESADVList $DB_DSV $tm1 $tm2
#VgrDbDESADVList $DB_DSV '2014-09-21' '2014-09-21'
sleep 5
dbdesadvcnt=$(cat $DB_DSV | wc -l )
#
## Get DB desadv count before duplicate handle
echo "DB desadv list created in  vgr-db-desadv-list.txt" >> $LOG
echo "Test - Do changes in  vgr-db-desadv-list.txt - To verify missing desadvs." >> $LOG
sleep 15
#
##Call Integration desadv List create method
CreateDESADVIdList $INT_DSV "$tm3"
#
## Get details of desadv : Remove spaces and duplicates
#
##Sort files
sed 's/ //g' $DB_DSV | sort | uniq -i > $DB_DSV_SRT
sed 's/ //g' $INT_DSV | sort | uniq -i > $INT_DSV_SRT
#
#
echo "XIB and DB desadv list sorted" >> $LOG
#
## Sorted desadv list counts
srtdbdesadvcnt=$(cat $DB_DSV_SRT | wc -l)
echo "DB desadv count in  vgr-db-desadv-list-sorted.txt - $srtdbdesadvcnt" >> $LOG
srtxibdesadvcnt=$(cat $INT_DSV_SRT | wc -l)
echo "XIB desadv count in  integration-desadv-list-sorted.txt - $srtxibdesadvcnt" >> $LOG
#
#
#
echo "Testing - Change vgr-db-desadv-list-sorted.txt" >> $LOG
#sleep 15
### List only the differed lines
### Check only the XIB missing desadvs
diff -iBwa $DB_DSV_SRT $INT_DSV_SRT | grep '<' | awk -F '<' '{print $2}' > $INT_MIS_DSV
#
#
#Missing DESADV Count
mis_cnt=$(cat $INT_MIS_DSV | wc -l)
echo "XIB missing desadv count $mis_cnt" >> $LOG
if [ $mis_cnt -ge 1 ]
then
#Send alert mail
INT_MIS_REP=$base_root/output/vgr-missing-desadvs-at-$ctm.txt
echo "VGR desadv verification result !!!" > $INT_MIS_REP
echo "Time duration $tm1 to $tm2" >> $INT_MIS_REP
echo " " >> $INT_MIS_REP
echo "Integration Missing desadvs Count - $mis_cnt" >> $INT_MIS_REP
echo " " >> $INT_MIS_REP
echo "Database desadv count - $dbdesadvcnt" >> $INT_MIS_REP
echo " " >> $INT_MIS_REP
echo "Integration Missing DESADV ID/s list." >> $INT_MIS_REP
echo "----------------------------------------------" >> $INT_MIS_REP
echo "ORDER ID | DESADV ID" >> $INT_MIS_REP
cat $INT_MIS_DSV >> $INT_MIS_REP
sleep 2
mail -s "VGR DESADV Copy back <<<MISSING>>> at $cktm !!!" procurement.2ndline.int@ebuilder.com procurement.2ndline@ebuilder.com < $INT_MIS_REP
#mail -s "VGR DESADV Copy back <<<MISSING>>> at $cktm !!!" sagara.jayathilaka@ebuilder.com < $INT_MIS_REP
#
else
#
echo "VGR desadv verification result !!!" > $DSV_CHK
echo "Time duration $tm1 to $tm2" >> $DSV_CHK
echo " " >> $DSV_CHK
echo "Database desadv count - $dbdesadvcnt" >> $DSV_CHK
echo " " >> $DSV_CHK
echo "Integration successfully received $dbdesadvcnt DESADVs and sent to Warehouse ...!!!" >> $DSV_CHK
echo " " >> $DSV_CHK
#
mail -s "VGR DESADV copy back check at $cktm !!!" procurement.2ndline.int@ebuilder.com procurement.2ndline@ebuilder.com < $DSV_CHK
#mail -s "VGR DESADV copy back check at $cktm !!!" sagara.jayathilaka@ebuilder.com < $DSV_CHK
#
fi
