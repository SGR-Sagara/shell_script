#!/bin/bash
#
# Normal flow OK status list
#
rm /opt/phxib/OFA_BACKUP/ok-status.txt
FIL='/opt/phxib/OFA_BACKUP/ok-status.txt'
FIL2='/opt/phxib/OFA_BACKUP/ok-status1.txt'
#
tim=$(date +"%Y-%m-%d %H:%M:%S")
cd /opt/phxib/OFA_BACKUP/dhlgf/carrier_status
#dy=$(date +"%Y%m%d")
dy=$1
#cd $dy
lst=$(find . -type f)
#
for i in $lst
do
ship_id=$(egrep -o "CNI.{50}" $i | grep 'STS+*+21' | awk -F '+' '{print $3}' | awk -F "'" '{print $1}')
echo "$ship_id" >> $FIL
#echo "" >> $FIL
done
# CIP flow OK status list
cd /opt/phxib/OFA_BACKUP/cip/status
cd $dy
lst1=$(find . -type f)
#
for j in $lst1
do
ship_ids=$(egrep -o "CNI.{50}" $j | grep 'STS+*+21' | awk -F '+' '{print $3}' | awk -F "'" '{print $1}')
echo "$ship_ids" >> $FIL
#echo "" >> $FIL
done
#
#
### Sort and remove duplicate
echo "Delivered Status Received Shipment List at $tim - $dy" > $FIL2
sort $FIL | uniq -i >> $FIL2
#
#
mail -s "OK status received shiments on $dy" sagara.jayathilaka@ebuilder.com < $FIL2
#