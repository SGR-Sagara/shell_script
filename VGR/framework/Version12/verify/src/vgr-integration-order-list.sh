#!/bin/bash
#
###This function is designed to generate list of order ids. 
###Based on the passed parameter to the function, it will generate order list.
###Parameter value should be the number of minutes you want to search back.
#
base_root="/opt/mxib/scripts/verify"
cd $base_root
#
#temp="$base_root/tmp/integration-order-list.txt"
rm $base_root/tmp/integration-order-list.txt
touch $base_root/tmp/integration-order-list.txt
ordlist="$base_root/tmp/integration-order-list.txt"
#
base="/data/mxib/data/projectbackup/mxib/vgr/archive/"
fax_order="exout_faxorders"
edi_order="exout_orders"
sve_order="exout_sveorder"
#
#
CreateOrderIdList(){
echo "Parameter value Passed minutes : $1" >> $base_root/output/log.txt
cd $base
##FAX Order list
cd $fax_order
##Count fax order amount
cnt1=$(find . -mmin -$1 -type f | wc -l)
if [ $cnt1 -gt 0 ]
	echo "Para Value to FAX Order - $1" >> $base_root/output/log.txt
	then
	lst1=$(find . -mmin -$1 -type f)
	#echo $lst1
	for i in $lst1
		do
		grep -A 2 '<header>' $i | grep 'proprietary' | awk -F '>' '{print $2}' | awk -F '<' '{print $1}' >> $ordlist
		done
##
fi
##
##
cd $base
##EDI Order list
cd $edi_order
##Count EDI order amount
cnt2=$(find . -mmin -$1 -type f | wc -l)
if [ $cnt2 -gt 0 ]
	echo "Para Value to EDU Order - $1" >> $base_root/output/log.txt
        then
        lst2=$(find . -mmin -$1 -type f)
        #echo $lst2
	for j in $lst2
                do
                grep -A 2 '<header>' $j | grep 'proprietary' | awk -F '>' '{print $2}' | awk -F '<' '{print $1}' >> $ordlist
                done
##
fi
##
##
cd $base
##SVE Order list
cd $sve_order
##Count SVE order amount
cnt3=$(find . -mmin -$1 -type f | wc -l)
if [ $cnt3 -gt 0 ]
	echo "Para Value to SVE Order- $1" >> $base_root/output/log.txt
        then
        lst3=$(find . -mmin -$1 -type f)
	#echo $lst3
        for k in $lst3
                do
                grep -A 2 '<header>' $k | grep 'proprietary' | awk -F '>' '{print $2}' | awk -F '<' '{print $1}' >> $ordlist
                done
##
fi
##
##
}
##
##
##
#CreateOrderIdList 80
