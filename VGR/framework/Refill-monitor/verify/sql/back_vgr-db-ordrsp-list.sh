#!/bin/bash
#
. ~/.bash_profile
#
base_root="/opt/mxib/scripts/verify"
. $base_root/src/vgr-db-access.txt
#
#rm $base_root/tmp/vgr-db-ordrsp-list.txt
rm $base_root/tmp/test-vgr-db-ordrsp-list-sorted.txt
#
touch $base_root/tmp/test-vgr-db-ordrsp-list.txt
#
VgrDbORDRSPList(){
#
## Time range generate for VGR Order list.
current_hour=$(date +"%H")
#ctm=$(date +"%Y%m%d%H%M%S")
#echo $ctm >> $base_root/tmp/test.txt
#
echo "Passed param valus to ORDRSP SQL" $1 , $2 , $3 >> $base_root/output/log.txt
#
#
sqlplus -s $USER/$PASS@$EPDB24S << EOF
    set feedback off
    set linesize 60
    set pages 0
    set space 0
    set echo off
    set heading off
    set trimspool on
    set trimout on
    set colsep '|'
    set pagesize 0
    spool $1
    SELECT OO.ID, OS.RESPONSEID FROM ORTORDERRESPONSE OS, ORTORDER OO, ORTORDERPARTY OP WHERE 1 = 1 AND OS.ORDERREFERENCE = OO.ID AND OO.ORDERDID = OP.ORDERDID AND OP.ORDERPARTYTYPEDID = 4 AND OP.ISWAREHOUSE = 1 AND OS.RESPONSEDATE >= TRUNC (TO_DATE('$2', 'YYYY-MM-DD')) AND OS.RESPONSEDATE < TRUNC (TO_DATE('$3','YYYY-MM-DD')) ORDER BY OO.ID, OS.RESPONSEDATE;    
spool off
    exit;
EOF
#
#
echo "Total ORDRSP found from Application : " $(cat $1 | wc -l) >> $base_root/output/log.txt
#
}
#
VgrDbORDRSPList $base_root/tmp/test-vgr-db-ordrsp-list.txt 2014-11-27 2014-11-28
