#!/bin/bash
#
base_root="/opt/mxib/scripts/verify"
. $base_root/src/vgr-db-access.txt
#
#rm $base_root/tmp/vgr-db-order-list.txt
touch $base_root/tmp/vgr-db-order-list.txt
#
VgrDBOrderList(){
#
## Time range generate for VGR Order list.
current_hour=$(date +"%H")
#tm1=''
#tm2=''
#ctm=$(date +"%Y%m%d%H%M%S")
#echo $ctm >> $base_root/tmp/test.txt
#
if [ $current_hour -ge 6 -a $current_hour -le 18 ]
then
tm1=$(date --date='75 minute ago' +"%Y/%m/%d %H:%M:%S")
tm2=$(date --date='15 minute ago' +"%Y/%m/%d %H:%M:%S")
#tm3="80"
#tm4=$( echo $tm1" to "$tm2)
#echo $tm1 #>> $base_root/tmp/test.txt
#echo $tm2 #>> $base_root/tmp/test.txt
#echo $tm3 #>> $base_root/tmp/test.txt
#echo $tm4 #>> $base_root/tmp/test.txt
else
tm1=$(date --date='1450 minute ago' +"%Y/%m/%d %H:%M:%S")
tm2=$(date --date='1440 minute ago' +"%Y/%m/%d %H:%M:%S")
#tm3="1460"
#tm4=$( echo $tm1" to "$tm2)
#echo $tm1 #>> $base_root/tmp/test.txt
#echo $tm2 #>> $base_root/tmp/test.txt
#echo $tm3 #>> $base_root/tmp/test.txt
#echo $tm4 #>> $base_root/tmp/test.txt
fi
#
#
sqlplus -s $USER/$PASS@$EPDB24S << EOF
    set feedback off
    set linesize 500
    set pages 0
    set space 0
    set echo off
    set trimspool on
    set pagesize 0
    set colsep '|'  
    spool $base_root/tmp/vgr-db-order-list.txt 
    SELECT id FROM ORTORDER WHERE 1 = 1 AND ORDERCATEGORYDID = 3 AND BITAND (STATUS, 1024) = 1024 AND ISDOUBLEREGISTERED = 0 AND CREATEDATE BETWEEN TO_DATE ('$tm1', 'YYYY/MM/DD HH24:MI:SS') AND TO_DATE ('$tm2', 'YYYY/MM/DD HH24:MI:SS');
    spool off
    exit;
EOF
#
}
#
#VgrDBOrderList '2014/09/24 08:00:00' '2014/09/18 08:59:59'
#VgrDBOrderList
