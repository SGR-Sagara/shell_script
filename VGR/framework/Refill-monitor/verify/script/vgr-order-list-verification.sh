#!/bin/bash
#
. ~/.bash_profile
#
base_root="/opt/mxib/scripts/verify"
#
##Load functions
##Integration order list function
. $base_root/src/vgr-integration-order-list.sh
##VGR DB Order List function
. $base_root/sql/vgr-db-order-list.sh
. $base_root/src/vgr-db-access.txt
#
#
cd $base_root
#
INT_MIS_ORD=$base_root/tmp/integration-missing-orders.txt
INT_ORD_SRT=$base_root/tmp/integration-order-list-sorted.txt
INT_ORD=$base_root/tmp/integration-order-list.txt
DB_ORD_SRT=$base_root/tmp/vgr-db-order-list-sorted.txt
DB_ORD=$base_root/tmp/vgr-db-order-list.txt
INT_DUP_ORD=$base_root/tmp/xib-duplicate-order-list.txt
ORD_CHK=$base_root/output/vgr-check-orders.txt
LOG=$base_root/output/log.txt
#
## Clear previousely created file.
rm $INT_MIS_ORD
rm $INT_ORD_SRT
rm $INT_ORD
rm $DB_ORD_SRT
rm $DB_ORD
rm $INT_DUP_ORD
rm $ORD_CHK
#
#
echo "Order verification Script started ... " >> $LOG
#sleep 59
ctm=$(date +"%Y-%m-%d_%H-%M-%S")
cktm=$(date +"%Y-%m-%d %H:%M:%S")
echo $ctm >> $LOG
#
#
## Time range generate for VGR Order list.
current_hour=$(date +"%H")
sec="00"
#
#
if [ $current_hour -ge 6 -a $current_hour -le 18 ]
then
tm_1=$(date --date='75 minute ago' +"%Y/%m/%d %H:%M:")
echo $tm_1 >> $LOG
tm1=$(echo $tm_1$sec )
tm_2=$(date --date='15 minute ago' +"%Y/%m/%d %H:%M:")
echo $tm_2 >> $LOG
tm2=$(echo $tm_2$sec)
tm3="120"
tm4=$( echo $tm1" to "$tm2)
echo $tm1 >> $LOG
echo $tm2 >> $LOG
echo $tm3 >> $LOG
echo $tm4 >> $LOG
else
tm_11=$(date --date='1455 minute ago' +"%Y/%m/%d %H:%M:")
echo $tm_11 >> $LOG
tm1=$(echo $tm_11$sec )
tm_22=$(date --date='15 minute ago' +"%Y/%m/%d %H:%M:")
echo $tm_22 >> $LOG
tm2=$(echo $tm_22$sec )
tm3="1500"
tm4=$( echo $tm1" to "$tm2)
echo $tm1 >> $LOG
echo $tm2 >> $LOG
echo $tm3 >> $LOG
echo $tm4 >> $LOG
fi
#
#
##Call SQL method to create DB Order List
#VgrDBOrderList ( spool_file , start_time , end_time)
VgrDBOrderList $DB_ORD $tm1 $tm2
#VgrDBOrderList $DB_ORD '2014/09/21 11:07:48' '2014/09/21 12:09:48'
#
## Get DB order count before duplicate handle
echo "DB order list created in  vgr-db-order-list.txt" >> $LOG
#echo "Test - Do changes in  vgr-db-order-list.txt - To verify missing orders." >> $LOG
#sleep 15
dbordercnt=$(cat $DB_ORD | wc -l)
echo "DB order count in  vgr-db-order-list.txt - $dbordercnt" >> $LOG
#
##Call Integration Order List create method
CreateOrderIdList "$tm3"
#
## Get total order count before duplicate handle
echo "XIB order list created in integration-order-list.txt" >> $LOG
echo "Do changes to integration-order-list.txt - To verify missing Orders: Delete | Duplicate" >> $LOG
sleep 25
xibordercnt=$(cat $INT_ORD | wc -l)
echo "XIB order count in  integration-order-list.txt - $xibordercnt" >> $LOG
#
##Sort files
sort $DB_ORD | uniq -i > $DB_ORD_SRT
sort $INT_ORD | uniq -i > $INT_ORD_SRT
#
echo "XIB and DB order list sorted" >> $LOG
#
## Sorted Order list counts
srtdbordercnt=$(cat $DB_ORD_SRT | wc -l)
echo "DB order count in  vgr-db-order-list-sorted.txt - $srtdbordercnt" >> $LOG
srtxibordercnt=$(cat $INT_ORD_SRT | wc -l)
echo "XIB order count in  integration-order-list-sorted.txt - $srtxibordercnt" >> $LOG
#
##Check Duplicate Orders in XIB side
echo "XIB Order count before sort : $xibordercnt - XIB Order count after sort : $srtxibordercnt" >> $LOG
intdupcnt=0
if [ $xibordercnt -gt $srtxibordercnt ]
then
#
echo "Duplicate Orders found at XIB" >> $LOG
sort $INT_ORD | uniq -id > $INT_DUP_ORD
intdupcnt=$(expr $xibordercnt - $srtxibordercnt) 
## v3=$(expr $v1 + $v2 )
fi
#
echo "XIB duplicate Order count : $intdupcnt" >> $LOG
#
#
echo "Testing - Change vgr-db-order-list-sorted.txt" >> $LOG
#sleep 15
### List only the differed lines
### Check only the XIB missing Orders
diff -iBwa $DB_ORD_SRT $INT_ORD_SRT | grep '<' | awk -F '<' '{print $2}' > $INT_MIS_ORD
#
#
#Missing Orde Count
mis_cnt=$(cat $INT_MIS_ORD | wc -l)
echo "XIB missing Order count $mis_cnt" >> $LOG
if [ $mis_cnt -ge 1 ]
then
#Send alert mail
INT_MIS_REP=$base_root/output/vgr-missing-orders-at-$ctm.txt
echo "VGR Order verification result !!!" > $INT_MIS_REP
echo "Time duration $tm4" >> $INT_MIS_REP
echo " " >> $INT_MIS_REP
echo "Integration Missing Orders Count - $mis_cnt" >> $INT_MIS_REP
echo " " >> $INT_MIS_REP
echo "Database Order count - $dbordercnt" >> $INT_MIS_REP
echo " " >> $INT_MIS_REP
if [ $intdupcnt -gt 0 ]
then
echo "DUPLICATE ORDER OUT DETECTED !!!" >> $INT_MIS_REP
echo "Duplicate Order count : $intdupcnt" >> $INT_MIS_REP
echo "Duplicated Order ID/s" >> $INT_MIS_REP
echo "----------------------------------------------" >> $INT_MIS_REP
cat $INT_DUP_ORD >> $INT_MIS_REP
fi
echo " " >> $INT_MIS_REP
echo "Integration Missing Order IDs list." >> $INT_MIS_REP
echo "----------------------------------------------" >> $INT_MIS_REP
cat $INT_MIS_ORD >> $INT_MIS_REP
sleep 2
mail -s "VGR Orders <<<MISSING>>> !!! - $cktm" procurement.2ndline.int@ebuilder.com procurement.2ndline@ebuilder.com < $INT_MIS_REP
#mail -s "VGR Orders <<<MISSING>>> !!! - $cktm" sagara.jayathilaka@ebuilder.com < $INT_MIS_REP
#
else
#
echo "VGR Order verification result !!!" > $ORD_CHK
echo "Time duration $tm4" >> $ORD_CHK
echo " " >> $ORD_CHK
echo "Database Order count - $dbordercnt" >> $ORD_CHK
echo " " >> $ORD_CHK
if [ $dbordercnt -gt 0 ]
then
echo "Integration successfully received $dbordercnt Order/s ...!!!" >> $ORD_CHK
fi
echo " " >> $ORD_CHK
if [ $intdupcnt -gt 0 ]
then
echo "DUPLICATE ORDER OUT DETECTED !!!" >> $ORD_CHK
echo " " >> $ORD_CHK
echo "Duplicate Order count : $intdupcnt" >> $ORD_CHK
echo "Duplicated Order ID/s" >> $ORD_CHK
echo "----------------------------------------------" >> $ORD_CHK
cat $INT_DUP_ORD >> $ORD_CHK
mail -s "VGR Orders check !!! - $cktm" procurement.2ndline.int@ebuilder.com procurement.2ndline@ebuilder.com < $ORD_CHK
else
echo "Duplicates not detected within above time range" >> $ORD_CHK
fi
#
if [ $current_hour -le 5 ]
then
mail -s "VGR Orders check !!! - $cktm" procurement.2ndline.int@ebuilder.com procurement.2ndline@ebuilder.com < $ORD_CHK
else
mail -s "VGR Orders check !!! - $cktm" sagara.jayathilaka@ebuilder.com < $ORD_CHK
fi
#
fi
