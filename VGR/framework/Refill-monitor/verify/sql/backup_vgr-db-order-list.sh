#!/bin/bash
#
. ~/.bash_profile
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
#ctm=$(date +"%Y%m%d%H%M%S")
#echo $ctm >> $base_root/tmp/test.txt
#
echo "Passed param valus to SQL" $1 , $2 , $3 , $4 , $5 >> $base_root/output/log.txt
#
timval1=$(echo $2 " " $3)
timval2=$(echo $4 " " $5)
echo $timval1 >> $base_root/output/log.txt
echo $timval2 >> $base_root/output/log.txt
#
#
sqlplus -s $USER/$PASS@$EPDB24S << EOF
    set feedback off
    set linesize 100
    set pages 0
    set space 0
    set echo off
    set heading off
    set trimspool on
    set trimout on
    set pagesize 0
    set colsep '|'  
    spool $1
    SELECT id FROM ORTORDER WHERE 1 = 1 AND ORDERCATEGORYDID = 3 AND BITAND (STATUS, 1024) = 1024 AND ISDOUBLEREGISTERED = 0 AND CREATEDATE BETWEEN TO_DATE ('$timval1', 'YYYY/MM/DD HH24:MI:SS') AND TO_DATE ('$timval2', 'YYYY/MM/DD HH24:MI:SS');
    spool off
    exit;
EOF
#
echo "Total Orders found from Application : " $(cat $base_root/tmp/vgr-db-order-list.txt | wc -l) >> $base_root/output/log.txt
#
}
#
#VgrDBOrderList $base_root/tmp/vgr-db-order-list.txt '2014/09/26 ' '09:01:01' '2014/09/26 ' '10:01:01'
#VgrDBOrderList
