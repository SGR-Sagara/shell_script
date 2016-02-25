#!/bin/bash
#
. ../sql/vvgr-db-order-list.sh
. ../src/vgr-db-access.txt
#
#
#VgrDBOrderList '2014/09/24 16:45:01' '2014/09/24 17:45:01'
base_root="/opt/mxib/scripts/verify"
#
#
cd $base_root
## Clear previousely created file.
rm $base_root/tmp/integration-missing-orders.txt
rm $base_root/tmp/integration-order-list-sorted.txt
rm $base_root/tmp/integration-order-list.txt
rm $base_root/tmp/vgr-db-order-list-sorted.txt
rm $base_root/tmp/vgr-db-order-list.txt
rm $base_root/tmp/xib-duplicate-order-list.txt
rm $base_root/output/vgr-check-orders.txt
#
touch $base_root/tmp/vgr-db-order-list.txt
#
##Load functions
##Integration order list function
. $base_root/src/vgr-integration-order-list.sh
##VGR DB Order List function
. $base_root/sql/vgr-db-order-list.sh
. $base_root/src/vgr-db-access.txt
#
#
#sleep 59
#
## Time range generate for VGR Order list.
current_hour=$(date +"%H")
#tm1=''
#tm2=''
ctm=$(date +"%Y%m%d%H%M%S")
echo $ctm >> $base_root/output/log.txt
#
if [ $current_hour -ge 6 -a $current_hour -le 18 ]
then
tm1=$(date --date='75 minute ago' +"%Y/%m/%d %H:%M:%S")
tm2=$(date --date='15 minute ago' +"%Y/%m/%d %H:%M:%S")
tm3="120"
tm4=$( echo $tm1" to "$tm2)
echo $tm1 >> $base_root/output/log.txt
echo $tm2 >> $base_root/output/log.txt
echo $tm3 >> $base_root/output/log.txt
echo $tm4 >> $base_root/output/log.txt
else
tm1=$(date --date='1455 minute ago' +"%Y/%m/%d %H:%M:%S")
tm2=$(date --date='15 minute ago' +"%Y/%m/%d %H:%M:%S")
tm3="1500"
tm4=$( echo $tm1" to "$tm2)
echo $tm1 >> $base_root/output/log.txt
echo $tm2 >> $base_root/output/log.txt
echo $tm3 >> $base_root/output/log.txt
echo $tm4 >> $base_root/output/log.txt
fi
#
#
##Call SQL method to create DB Order List
#VgrDBOrderList ( spool_file , start_time , end_time)
VgrDBOrderList $base_root/tmp/vgr-db-order-list.txt $tm1 $tm2
