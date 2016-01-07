#!/bin/bash
###
### Svefaktura invoice list
###
cd /home/trafik/VGR_BACKUP/archive/mapped_data/exin_svefaktura/
pwd
dt=$(date +'%Y-%m-%d')
month=$1
echo "Month $month"
lst=$(find ./$month* -type f)
#
#echo "List : $lst"
#
for i in $lst
do
#
inv_id=$(egrep -o "<header>.{80}" "$i" | awk -F '>' '{print $3}' | awk -F '<' '{print $1}')
ord_id=$(egrep -o "<order>.{110}" "$i" | awk -F '>' '{print $3}' | awk -F '<' '{print $1}')
sup_id=$(egrep -o ".{120}<type>SU" $i | awk -F 'ean' '{print $2}' | awk -F '>' '{print $2}' | awk -F '<' '{print $1}')
#
tim=$(stat "$i" | grep 'Modify' | awk -F '.' '{print $1}' | awk -F ':' '{print $2":"$3":"$4}')
echo "$tim | $inv_id | $ord_id | $sup_id" >> ~/sgr/vgr_inv_"$month".txt
#
done
###################################
cd /home/trafik/VGR_BACKUP/archive/mapped_data/exin_invoice/
pwd
lst1=$(find ./$month* -type f)
#
#echo "List : $lst1"
#
for j in $lst1
do
#
inv_id1=$(egrep -o "<header>.{80}" "$j" | awk -F '>' '{print $3}' | awk -F '<' '{print $1}')
ord_id1=$(egrep -o "<order>.{110}" "$j" | awk -F '>' '{print $3}' | awk -F '<' '{print $1}')
sup_id1=$(egrep -o ".{120}<type>SU" $j | awk -F 'ean' '{print $2}' | awk -F '>' '{print $2}' | awk -F '<' '{print $1}')
#
tim1=$(stat "$j" | grep 'Modify' | awk -F '.' '{print $1}' | awk -F ':' '{print $2":"$3":"$4}')
echo "$tim1 | $inv_id1 | $ord_id1 | $sup_id1" >> ~/sgr/vgr_inv_"$month".txt
#
done
cd ~/sgr
#
sleep 5
grep '|' vgr_inv_"$month".txt >> VGR_INV_"$month".txt
#
#mutt -a "VGR_INV_"$month".txt" -s "VGR Invoice List to Verify for $dt" -- sagara.jayathilaka@ebuilder.com
#mutt -a "VGR_INV_"$month".txt" -s "VGR Invoice List to Verify for $dt" -- procurement.2ndline.int@ebuilder.com