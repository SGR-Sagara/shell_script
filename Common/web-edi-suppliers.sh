#!/bin/bash
##This script is to generate WEB-EDI and FULL EDI supplier reports.
. ~/.bash_profile

dte=$(date +'%Y-%m-%d')
## WEB-EDI Supplier LIST
#echo $dte
#get the last file
cd /data/mxib/data/ftp/vgr/archive/Archive_ConfigFiles/

arcfile=$(ls -ltr | tail -1 | awk '{print $9}')
#echo $arcfile

grep -B 3 '/VGR/salja/orders' $arcfile | grep '^DTA' | awk -F '|' '{print $2 ";" $4}' | sed -e 's/ORDERS_VGR_to_/ /g' > /opt/mxib/xib/local/user/sagara/web-edi-$dte.txt
sleep 5
mail -s "WEB-EDI supplier List on $dte" procurement.2ndline.int@ebuilder.com procurement.2ndline@ebuilder.com < /opt/mxib/xib/local/user/sagara/web-edi-$dte.txt
