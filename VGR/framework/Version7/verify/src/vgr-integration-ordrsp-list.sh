#!/bin/bash
#
###This function is designed to generate list of ORDRSP ID with related order ids. 
###Based on the passed parameter to the function, it will generate ORDRSP list.
###Parameter value should be the number of minutes you want to search back.
#
base_root="/opt/mxib/scripts/verify"
cd $base_root
#
#temp="$base_root/tmp/integration-ordrsp-list.txt"
rm $base_root/tmp/integration-ordrsp-list.txt
rm $base_root/tmp/integration-ordrsp-list-sorted.txt
touch $base_root/tmp/integration-ordrsp-list.txt
ordlist="$base_root/tmp/integration-ordrsp-list.txt"
ordlistsrt="$base_root/tmp/integration-ordrsp-list-sorted.txt"
#
base="/data/mxib/data/projectbackup/mxib/vgr/archive/"
copyback="whout_orderresponse"
#
#
CreateORDRSPIdList(){
echo "Parameter value Passed minutes : $1" >> $base_root/output/log.txt
cd $base
##ORDRSP list
cd $copyback
##Count ORDRSP amount
cnt1=$(find . -mmin -$1 -type f | wc -l)
if [ $cnt1 -gt 0 ]
        echo "Para Value to Copy back ORDRSPs - $1" >> $base_root/output/log.txt
        then
        lst1=$(find . -mmin -$1 -type f)
        #echo $lst1
        for i in $lst1
                do
                ordrsp_id=$(grep -A 2 '<header>' $i | grep 'proprietary' | awk -F '>' '{print $2}' | awk -F '<' '{print $1}')
				ordid=$(grep -A 2 '<order>' $i | grep 'proprietary' | awk -F '>' '{print $2}' | awk -F '<' '{print $1}')
				echo $ordid "|" $ordrsp_id >> $ordlist
                done
##
## Remove spaces
sed 's/ //g' $ordlist  > $ordlistsrt
#
fi
}
##
##
##
CreateORDRSPIdList 1480
