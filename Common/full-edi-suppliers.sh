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

#Start point
fr=$(grep -n '# 2. External/Full EDI suppliers configurations' $arcfile | awk -F ':' '{print $1}')
#echo "first $fr"
#End point
ls=$(grep -n '# 3. Internal suppliers configurations' $arcfile | awk -F ':' '{print $1}')
#echo "last $ls"

sed -n "$fr,$ls p" $arcfile | grep '^DTA' | awk -F '|' '{print $2 ";" $4}' | sed -e 's/ORDERS_VGR_to_/ /g' | sed -e 's/ORDERSXML_VGR_/ /g' > /opt/mxib/xib/local/user/sagara/full-edi-$dte.txt
sleep 5
#mail -s "FULL-EDI supplier List on $dte" charitha.perera@ebuilder.com sagara.jayathilaka@ebuilder.com < /opt/mxib/xib/local/user/sagara/full-edi-$dte.txt
mail -s "FULL-EDI supplier List on $dte" procurement.2ndline.int@ebuilder.com procurement.2ndline@ebuilder.com  < /opt/mxib/xib/local/user/sagara/full-edi-$dte.txt
