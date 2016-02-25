#!/bin/bash
#
base_root="/opt/mxib/scripts/verify"
##Load functions
cd $base_root
##Integration order list function
. $base_root/src/vgr-integration-order-list.sh
##VGR DB Order List function
. $base_root/sql/vgr-db-order-list.sh
. $base_root/src/vgr-db-access.txt
#
#
## Time range generate for VGR Order list.
current_hour=$(date +"%H")
#tm1=''
#tm2=''
ctm=$(date +"%Y%m%d%H%M%S")
#echo $ctm >> $base_root/tmp/test.txt
#
if [ $current_hour -ge 6 -a $current_hour -le 18 ]
then
tm1=$(date --date='75 minute ago' +"%Y/%m/%d %H:%M:%S")
tm2=$(date --date='15 minute ago' +"%Y/%m/%d %H:%M:%S")
tm3="80"
tm4=$( echo $tm1" to "$tm2)
#echo $tm1 >> $base_root/tmp/test.txt
#echo $tm2 >> $base_root/tmp/test.txt
#echo $tm3 >> $base_root/tmp/test.txt
#echo $tm4 >> $base_root/tmp/test.txt
else
tm1=$(date --date='1450 minute ago' +"%Y/%m/%d %H:%M:%S")
tm2=$(date --date='1440 minute ago' +"%Y/%m/%d %H:%M:%S")
tm3="1460"
tm4=$( echo $tm1" to "$tm2)
#echo $tm1 >> $base_root/tmp/test.txt
#echo $tm2 >> $base_root/tmp/test.txt
#echo $tm3 >> $base_root/tmp/test.txt
#echo $tm4 >> $base_root/tmp/test.txt
fi
#
#
##Call SQL method to create DB Order List
VgrDBOrderList # "$tm1" "$tm2"
#VgrDBOrderList '2014/09/21 11:07:48' '2014/09/21 12:09:48'
#
sleep 5
#
##Call Integration Order List create method
CreateOrderIdList "$tm3"
#
sleep 5
#
##Sort files
sort $base_root/tmp/vgr-db-order-list.txt | uniq -i > $base_root/tmp/vgr-db-order-list-sorted.txt
sort $base_root/tmp/integration-order-list.txt | uniq -i > $base_root/tmp/integration-order-list-sorted.txt
#
#
#echo "Testing - Change vgr-db-order-list-sorted.txt"
#sleep 40
### List only the differed lines
diff -iBwa $base_root/tmp/vgr-db-order-list-sorted.txt $base_root/tmp/integration-order-list-sorted.txt | grep '<' | awk -F '<' '{print $2}' > $base_root/tmp/integration-missing-orders.txt
#
#
#Missing Orde Count
mis_cnt=$(cat $base_root/tmp/integration-missing-orders.txt | wc -l)
if [ $mis_cnt -ge 1 ]
then
#Send alert mail
echo "VGR Order verification result !!!" > $base_root/output/vgr-missing-orders-at-$ctm.txt
echo "Time duration $tm4" >> $base_root/output/vgr-missing-orders-at-$ctm.txt
echo "Integration Missing Order IDs - $mis_cnt" >> $base_root/output/vgr-missing-orders-at-$ctm.txt
cat $base_root/tmp/integration-missing-orders.txt >> $base_root/output/vgr-missing-orders-at-$ctm.txt
sleep 2
mail -s "VGR Orders missing !!! - $ctm" procurement.2ndline.int@ebuilder.com procurement.2ndline.int@ebuilder.com < $base_root/output/vgr-missing-orders-at-$ctm.txt
#mail -s "VGR Orders missing !!! - $ctm" sagara.jayathilaka@ebuilder.com < $base_root/output/vgr-missing-orders-at-$ctm.txt
fi
