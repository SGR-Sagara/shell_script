#!/bin/bash
#
#
##IFTMIN ID list
IftminOrders(){
dy=$(date +"%Y%m%d")
dyt=$(date +"%Y-%m-%d %H:%M:%S")
#
cd /data/phxib/data/projectbackup/phxib/dhlgf/alfa_orders/$dy
rm /opt/phxib/xib/local/bin/src/iftmin-list.txt
echo "IFTMIN Order List at $dyt" > /opt/phxib/xib/local/bin/src/iftmin-list.txt
#
fls=$(find . -type f)
cnt=$(find . -type f | wc -l)
echo "IFTMIN Order file count $cnt" >> /opt/phxib/xib/local/bin/src/iftmin-list.txt
#
for i in $fls
do
iftminid=$(egrep -o 'RFF\+CU.{40}' "$i" | awk -F ':' '{print $2}' | awk -F "'" '{print $1}')
echo "$iftminid" >> /opt/phxib/xib/local/bin/src/iftmin-list.txt
#
done
}
#
#
#IftminOrders
#
## IFTRIN ID List
IftrinInvoice(){
dy=$(date +"%Y%m%d")
dyt=$(date +"%Y-%m-%d %H:%M:%S")
#
cd /data/phxib/data/projectbackup/phxib/dhlgf/alfa_iftrin/$dy
rm /opt/phxib/xib/local/bin/src/iftrin-list.txt
echo "IFTRIN INVOICE List at $dyt" > /opt/phxib/xib/local/bin/src/iftrin-list.txt
#
fls=$(find . -type f)
cnt=$(find . -type f | wc -l)
echo "IFTRIN Invoice file count $cnt" >> /opt/phxib/xib/local/bin/src/iftrin-list.txt
#
for j in $fls
do
iftrinid=$(grep '<cbc:SalesOrderLineID>'  $j | awk -F '>' '{print $2}' | awk -F '<' '{print $1}')
echo "$iftrinid" >> /opt/phxib/xib/local/bin/src/iftrin-list.txt
#
done
}
#
#IftrinInvoice
#
#
## Carrier IFTMIN ID List
CarrierIftmin(){
dy=$(date +"%Y%m%d")
dyt=$(date +"%Y-%m-%d %H:%M:%S")
#
cd /data/phxib/data/projectbackup/phxib/dhlgf/carrier_orders/$dy
rm /opt/phxib/xib/local/bin/src/carrier_iftmin_tmp.txt
#
fls=$(find . -type f)
cnt=$(find . -type f | wc -l)
#
for k in $fls
do
iftrinid=$(grep -A 2 '<cac:Consignment>'  $k | grep '<cbc:ID>' | awk -F '>' '{print $2}' | awk -F '<' '{print $1}')
echo "$iftrinid" >> /opt/phxib/xib/local/bin/src/carrier_iftmin_tmp.txt
#
done
#
echo "Carrier IFTMIN List at $dyt" > /opt/phxib/xib/local/bin/src/carrier_iftmin.txt
echo "Carrier IFTMIN file count $cnt" >> /opt/phxib/xib/local/bin/src/carrier_iftmin.txt
sort /opt/phxib/xib/local/bin/src/carrier_iftmin_tmp.txt | uniq -i >> /opt/phxib/xib/local/bin/src/carrier_iftmin.txt
}
#
#
#CarrierIftmin
#
#
## IOD ID List
IOD(){
dy=$(date +"%Y%m%d")
dyt=$(date +"%Y-%m-%d %H:%M:%S")
#
cd /data/phxib/data/projectbackup/phxib/dhlgf/alfa_iod/$dy
rm /opt/phxib/xib/local/bin/src/iod.txt
#
fls=$(find . -type f)
cnt=$(find . -type f | wc -l)
echo "IODs List at $dyt" > /opt/phxib/xib/local/bin/src/iod.txt
echo "IOD file count $cnt" >> /opt/phxib/xib/local/bin/src/iod.txt
#
for l in $fls
do
iodid=$(grep '<cbc:SalesOrderID>' $l | awk -F '>' '{print $2}' | awk -F '<' '{print $1}')
echo "$iodid" >> /opt/phxib/xib/local/bin/src/iod.txt
#
done
#
}
#
#
IOD
