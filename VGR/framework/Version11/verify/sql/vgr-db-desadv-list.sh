#!/bin/bash
#
. ~/.bash_profile
#
base_root="/opt/mxib/scripts/verify"
. $base_root/src/vgr-db-access.txt
#
DB_RSP=$base_root/tmp/vgr-db-desadv-list.txt
LOG=$base_root/output/log.txt
#
#
VgrDbDESADVList(){
#
## Time range generate for VGR DESADV list.
current_hour=$(date +"%H")
#ctm=$(date +"%Y%m%d%H%M%S")
#echo $ctm >> $base_root/tmp/test.txt
#
echo "Passed param valus to DESADV SQL" $1 , $2 , $3 >> $LOG
#
#
sqlplus -s $USER/$PASS@$EPDB24S << EOF
    set feedback off
    set linesize 120
    set pages 0
    set space 0
    set echo off
    set heading off
    set trimspool on
    set trimout on
    set colsep '|'
    set pagesize 0
    spool $1
    SELECT OO1.ID,OO2.ID FROM ORTORDER OO1, ORTORDER OO2, ORTORDERPARTY OP WHERE OO1.ORDERDID = OO2.PARENTORDERDID AND OO1.ORDERDID = OP.ORDERDID AND OO2.ORDERCATEGORYDID = 9 AND OP.ORDERPARTYTYPEDID = 4 AND OP.ISWAREHOUSE = 1 AND OO2.CREATEDATE >= TRUNC (TO_DATE('$2', 'YYYY-MM-DD')) AND OO2.CREATEDATE < (TO_DATE('$3','YYYY-MM-DD')) ORDER BY OO1.ID, OO2.ID;    
    spool off
    exit;
EOF
#
#
echo "Total DESADV found from Application : " $(cat $1 | wc -l) >> $base_root/output/log.txt
#
}
#
#VgrDbDESADVList $base_root/tmp/vgr-db-desadv-list.txt 2014-10-04 2014-10-05
