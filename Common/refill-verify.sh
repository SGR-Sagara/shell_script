#!/bin/bash
#
base="/data/mxib/data/projectbackup/mxib/vgr/archive/"
loc1="exout_orders/"
loc2="exout_faxorders/"
loc3="exout_sveorder/"
#
cnt=$(cat /data/mxib/data/projectbackup/mxib/vgr/archive/refill-ids-last15min.txt | wc -l)
#
today=$(date +"%Y%m%d")
endtim==$(date +"%Y-%m-%d %H:%M")
#
if [ $cnt -gt 0 ]
then
#echo "There are $cnt refill to check"
lst=$(cat /data/mxib/data/projectbackup/mxib/vgr/archive/refill-ids-last15min.txt)
#echo $lst
#
for i in $lst
do
cnt1=$(find $base$loc1$today -type f -exec grep -l "$i" {} \; | wc -l)
cnt2=$(find $base$loc2$today -type f -exec grep -l "$i" {} \; | wc -l)
cnt3=$(find $base$loc3$today -type f -exec grep -l "$i" {} \; | wc -l)
#echo "Count 1 = $cnt1 | Count 2 = $cnt2 | Count 3 = $cnt3"
if [ $cnt1 -eq 0 -a $cnt2 -eq 0 -a $cnt3 -eq 0 ]
then
echo "No Order Out for the Refill ID : $i $'\r'" >> /data/mxib/data/projectbackup/mxib/vgr/archive/refills-no-order.txt
fi
done
sleep 2
mail -s "Refills without Order Outs at $endtim" sagara.jayathilaka@ebuilder.com < /data/mxib/data/projectbackup/mxib/vgr/archive/refills-no-order.txt
else
echo "No Refill Orders to check"
fi
sleep 2
rm /data/mxib/data/projectbackup/mxib/vgr/archive/refills-no-order.txt
