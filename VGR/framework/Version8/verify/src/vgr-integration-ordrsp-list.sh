#!/bin/bash
#
###This function is designed to generate list of ORDRSP ID with related order ids. 
###Based on the passed parameter to the function, it will generate ORDRSP list.
###Parameter value should be the number of minutes you want to search back.
#
base_root="/opt/mxib/scripts/verify"
cd $base_root
#
RSP_LST=$base_root/tmp/integration-ordrsp-list.txt
LOG=$base_root/output/log.txt
echo "Integration ORDRSP list generation started ... !!" >> $LOG
#
rm $RSP_LST
#
#
base="/data/mxib/data/projectbackup/mxib/vgr/archive/"
copyback="whout_orderresponse"
#
#
CreateORDRSPIdList(){
echo "Parameter value Passed : $1 , $2" >> $LOG
cd $base$copyback
##ORDRSP list
##Count ORDRSP amount
cnt1=$(find . -mtime -$2 -type f | wc -l)
if [ $cnt1 -gt 0 ]
        echo "Para Value to Copy back ORDRSPs - $1 , $2" >> $LOG
        then
        lst1=$(find . -mtime -$2 -type f)
        #echo $lst1
        for i in $lst1
                do
                ordrsp_id=$(grep -A 2 '<header>' $i | grep 'proprietary' | awk -F '>' '{print $2}' | awk -F '<' '{print $1}')
		ordid=$(grep -A 2 '<order>' $i | grep 'proprietary' | awk -F '>' '{print $2}' | awk -F '<' '{print $1}')
		echo $ordid "|" $ordrsp_id >> $1
                done
##
echo "Total ORDRSPs found in Integration within past $2 days : $(cat $1 | wc -l)" >> $LOG
#
echo "Integration ORDRSP list generation ended ... !!" >> $LOG
fi
}
##
##
##
#CreateORDRSPIdList $RSP_LST 2
