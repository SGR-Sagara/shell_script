#!/bin/bash
####
### VGR Refill flow summary
### Checks
# 1. Number of Refill Orders Received (Int only)
# 2. Refills failed to generate Order Outs (Int only)
# 3. Number of Order outs received for Refills (Int only)
# 4. Total Number of Order outs generated (App only)
# 5. Total number of ORDRSPs received (Warehouse, Supplier and WEB-EDI) (Int only)
# 6. Total ORDRSP copy backs generated from Application (App only)
# 7. Total ORDRSP copy backs missing in Integration (Int and App)
# 8. Total number of DESADVs received (Warehouse, Supplier and WEB-EDI) (Int only)
# 9. Total DESADV copy backs generated from Application (App only)
# 10. Total DESADV copy backs missing in Integration (Int and App)
##################################################################################
. ~/.bash_profile
##
base_root="/opt/mxib/scripts/verify"
base="/data/mxib/data/projectbackup/mxib/vgr/archive/"
#
##Load functions
##VGR DB Order List function
. $base_root/sql/vgr-db-order-list.sh
. $base_root/src/vgr-db-access.txt
#
LOG=$base_root/tmp/refill_flow.log
REPORT=$base_root/tmp/refill_flow_report.txt
RO1=$base_root/tmp/refill_list1.txt
RO2=$base_root/tmp/refill_list2.txt
OL1=$base_root/tmp/order_list1.txt
OL2=$base_root/tmp/order_list2.txt
OL3=$base_root/tmp/order_list3.txt
OL4=$base_root/tmp/order_list4.txt
NO_REFIL=$base_root/tmp/no_order_refill1.txt
RE_DB_ORD=$base_root/tmp/vgrdb_order_list.txt
RE_DB_ORD_SRT=$base_root/tmp/vgrdb_order_list1.txt
#
> $RO1
> $RO2
> $REPORT
> $OL1
> $OL2
> $OL3
> $OL4
> $NO_REFIL
> $RE_DB_ORD
> $RE_DB_ORD_SRT
sleep 10
#
tim=$(date +"%Y-%m-%d %H:%M:%S")
echo "Report at $tim " >> $REPORT
#
TDAY=''
#
if [ $# = 1 ]
then
TDAY=$1
echo "If true : $TDAY"
else
TDAY=$(date +"%Y%m%d")
echo "If FALSE : $TDAY"
fi
#
# 1. Number of Refill Orders Received (Int only)
##
cd $base"whin_refillorders/$TDAY"
pwd
#
lst1=$(find . -type f)
#echo $lst
#
#
for i in $lst1
do
egrep -o "<RefillOrderNumber>.{15}" $i | awk -F ">" '{print $2}' | awk -F "<" '{print $1}' >> $RO1
done
#
sort $RO1 | uniq -i > $RO2
RO2_1=$(cat $RO2 | wc -l)
echo "RO2_1 :" $RO2_1
echo "Total Refill Orders Received : $RO2_1" >> $REPORT
###
###
# 2. Refills failed to generate Order Outs (Int only)
cd $base
sleep 5
#
lst2=$(find ./exout_[^{o,f,s}]*/$TDAY -type f)
echo "Order file count : " $(cat $lst2 | wc -l)
#
for j in $lst2
do
grep '<goods-label>Referens' $j | awk -F '>' '{print $2}' | awk -F '<' '{print $1}' | awk -F ':' '{print $2}' >> $OL1
grep -A 1 '<header>' $j | grep 'proprietary' | awk -F '>' '{print $2}' | awk -F '<' '{print $1}' >> $OL3
done
#
echo "Refill id count of order outs before sort : " $(cat $OL1 | wc -l)
sort $OL1 | uniq -i >> $OL2
echo "Refill id count of order outs after sort : " $(cat $OL2 | wc -l)
echo "Order id count of order outs before sort : " $(cat $OL3 | wc -l)
sort $OL3 | uniq -i >> $OL4
echo "Order id count of order outs after sort : " $(cat $OL4 | wc -l)
#
diff -iBwa $RO2 $OL2 | grep '<' | awk -F '<' '{print $2}' >> $NO_REFIL
#
NO_REFIL_1=$(cat $NO_REFIL | wc -l)
echo "Refill Orders failed generate Order Outs : $NO_REFIL_1" >> $REPORT
###
###
# 3. Number of Order outs received for Refills (Int only)
OL4_1=$(cat $OL4 | wc -l)
echo "Number of Order outs received for Refill Orders only : $OL4_1" >> $REPORT
###
###
# 4. Total Number of Order outs generated (App only)
##Call SQL method to create DB Order List
sec=":00"
sec1="00"
tm_1=$(date +"%Y/%m/%d ")
tm_2=$(date +"%Y/%m/%d %H:%M")
tm1=$tm_1$sec1$sec$sec
tm2=$tm_2$sec
echo $tm1
echo $tm2
#VgrDBOrderList ( spool_file , start_time , end_time)
VgrDBOrderList $RE_DB_ORD $tm1 $tm2 > /dev/null 2>&1
sort $RE_DB_ORD | uniq -i > $RE_DB_ORD_SRT
RE_DB_ORD_SRT_1=$(cat $RE_DB_ORD_SRT | wc -l)
echo "Total Number of Order outs generated from Application : $RE_DB_ORD_SRT_1" >> $REPORT
#