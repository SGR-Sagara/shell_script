#!/bin/bash
#
###This function is designed to generate list of DESADV ID with related order ids. 
###Based on the passed parameter to the function, it will generate DESADV list.
###Parameter value should be the number of minutes you want to search back.
#
base_root="/opt/mxib/scripts/verify"
cd $base_root
#
DSV_LST=$base_root/tmp/integration-desadv-list.txt
LOG=$base_root/output/log.txt
echo "Integration DESADV list generation started ... !!" >> $LOG
#
rm $DSV_LST
#
#
base="/data/mxib/data/projectbackup/mxib/vgr/archive/"
copyback="whout_despatchadvice"
#
#
CreateDESADVIdList(){
echo "Parameter value Passed : $1 , $2" >> $LOG
cd $base$copyback
##DESADV list
##Count DESADV amount
cnt1=$(find . -mtime -$2 -type f | wc -l)
if [ $cnt1 -gt 0 ]
        echo "Para Value to Copy back DESADVs - $1 , $2" >> $LOG
        then
        lst1=$(find . -mtime -$2 -type f)
        #echo $lst1
        for i in $lst1
                do
                DESADV_id=$(grep -A 2 '<header>' $i | grep 'proprietary' | awk -F '>' '{print $2}' | awk -F '<' '{print $1}')
                ordid=$(grep 'ordernumber' $i | awk -F '>' '{print $2}' | awk -F '<' '{print $1}')
                echo $ordid "|" $DESADV_id >> $1
                done
##
echo "Total DESADVs found in Integration within past $2 days : $(cat $1 | wc -l)" >> $LOG
#
echo "Integration DESADV list generation ended ... !!" >> $LOG
fi
}
##
##
##
#CreateDESADVIdList $DSV_LST 1
