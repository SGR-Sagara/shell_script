#!/bin/bash
#### ORDRSP copy back missing list
. ~/.bash_profile
#
base_root="/opt/mxib/scripts/verify"
#
##Load functions
##Integration ORDRSP list function
. $base_root/src/vgr-integration-ordrsp-list.sh
##VGR DB ORDRSP List function
. $base_root/sql/vgr-db-ordrsp-list.sh
. $base_root/src/vgr-db-access.txt
#
#
cd $base_root
#
INT_MIS_RSP=$base_root/tmp/integration-missing-ordrsp.txt
INT_RSP_SRT=$base_root/tmp/integration-ordrsp-list-sorted.txt
INT_RSP=$base_root/tmp/integration-ordrsp-list.txt
DB_RSP_SRT=$base_root/tmp/vgr-db-ordrsp-list-sorted.txt
DB_RSP=$base_root/tmp/vgr-db-ordrsp-list.txt
INT_DUP_RSP=$base_root/tmp/xib-duplicate-ordrsp-list.txt
RSP_CHK=$base_root/output/vgr-check-ordrsp.txt
LOG=$base_root/output/log.txt
#
## Clear previousely created file.
rm $INT_MIS_RSP
rm $INT_RSP_SRT
rm $INT_RSP
rm $DB_RSP_SRT
rm $DB_RSP
rm $INT_DUP_RSP
rm $RSP_CHK
#
#
echo "ORDRSP verification Script started ... " >> $LOG
#sleep 59
cktm=$(date +"%Y-%m-%d %H:%M:%S")
ctm=$(date +"%Y-%m-%d_%H-%M-%S")
echo $ctm >> $LOG
#
#
## Time range generate for VGR ORDRSP list.
current_hour=$(date +"%H")
#
#
if [ $current_hour -ge 6 -a $current_hour -le 18 ]
then
tm1=$(date +"%Y-%m-%d")
tm2=$(date +"%Y-%m-%d")
tm3=1
echo $tm1 >> $LOG
echo $tm2 >> $LOG
echo $tm3 >> $LOG
else
tm1=$(date --date='1 day ago' +"%Y-%m-%d")
tm2=$(date +"%Y-%m-%d")
tm3=2
echo $tm1 >> $LOG
echo $tm2 >> $LOG
echo $tm3 >> $LOG
fi
#
#
##Call SQL method to create DB ORDRSP List
#VgrDbORDRSPList ( spool_file , start_day , end_day)
VgrDbORDRSPList $DB_RSP $tm1 $tm2
#VgrDbORDRSPList $DB_RSP '2014-09-21' '2014-09-21'
sleep 5
dbordrspcnt=$(cat $DB_RSP | wc -l )
#
## Get DB ordrsp count before duplicate handle
echo "DB ordrsp list created in  vgr-db-ordrsp-list.txt" >> $LOG
echo "Test - Do changes in  vgr-db-ordrsp-list.txt - To verify missing ordrsps." >> $LOG
sleep 15
#
##Call Integration ordrsp List create method
CreateORDRSPIdList $INT_RSP "$tm3"
#
## Get details of ordrsp : Remove spaces and duplicates
#
##Sort files
sed 's/ //g' $DB_RSP | sort | uniq -i > $DB_RSP_SRT
sed 's/ //g' $INT_RSP | sort | uniq -i > $INT_RSP_SRT
#
#
echo "XIB and DB ordrsp list sorted" >> $LOG
#
## Sorted ordrsp list counts
srtdbordrspcnt=$(cat $DB_RSP_SRT | wc -l)
echo "DB ordrsp count in  vgr-db-ordrsp-list-sorted.txt - $srtdbordrspcnt" >> $LOG
srtxibordrspcnt=$(cat $INT_RSP_SRT | wc -l)
echo "XIB ordrsp count in  integration-ordrsp-list-sorted.txt - $srtxibordrspcnt" >> $LOG
#
#
#
echo "Testing - Change vgr-db-ordrsp-list-sorted.txt" >> $LOG
#sleep 15
### List only the differed lines
### Check only the XIB missing ordrsps
diff -iBwa $DB_RSP_SRT $INT_RSP_SRT | grep '<' | awk -F '<' '{print $2}' > $INT_MIS_RSP
#
#
#Missing ORDRSP Count
mis_cnt=$(cat $INT_MIS_RSP | wc -l)
echo "XIB missing ordrsp count $mis_cnt" >> $LOG
if [ $mis_cnt -ge 1 ]
then
#Send alert mail
INT_MIS_REP=$base_root/output/vgr-missing-ordrsps-at-$ctm.txt
echo "VGR ordrsp verification result !!!" > $INT_MIS_REP
echo "ORDRSP Copy back checked on $tm1 at $ctm" >> $INT_MIS_REP
echo " " >> $INT_MIS_REP
echo "Integration Missing ordrsps Count - $mis_cnt" >> $INT_MIS_REP
echo " " >> $INT_MIS_REP
echo "Database ordrsp count - $dbordrspcnt" >> $INT_MIS_REP
echo " " >> $INT_MIS_REP
echo "Integration Missing ORDRSP ID/s list." >> $INT_MIS_REP
echo "----------------------------------------------" >> $INT_MIS_REP
echo "ORDER ID | ORDRSP ID" >> $INT_MIS_REP
cat $INT_MIS_RSP >> $INT_MIS_REP
sleep 2
mail -s "VGR ORDRSP Copy back <<<MISSING>>> - $cktm !!!" procurement.2ndline.int@ebuilder.com procurement.2ndline@ebuilder.com < $INT_MIS_REP
#mail -s "VGR ORDRSP Copy back <<<MISSING>>> - $cktm !!!" sagara.jayathilaka@ebuilder.com < $INT_MIS_REP
#
else
#
echo "VGR ordrsp verification result !!!" > $RSP_CHK
echo "ORDRSP Copy back checked at $cktm" >> $RSP_CHK
echo " " >> $RSP_CHK
echo "Database ordrsp count - $dbordrspcnt" >> $RSP_CHK
echo " " >> $RSP_CHK
echo "Integration successfully received $dbordrspcnt ORDRSPs and sent to Warehouse ...!!!" >> $RSP_CHK
echo " " >> $RSP_CHK
#
mail -s "VGR ORDRSP Copy back check at $cktm !!!" procurement.2ndline.int@ebuilder.com procurement.2ndline@ebuilder.com < $RSP_CHK
#mail -s "VGR ORDRSP Copy back check at $cktm !!!" sagara.jayathilaka@ebuilder.com < $RSP_CHK
#
fi
