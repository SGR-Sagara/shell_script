#!/bin/bash
##This script is to generate LIV FULL-EDI/WEB-EDI supplier reports.
. ~/.bash_profile
dte=$(date +'%Y-%m-%d')
##
#echo $dte
#get the last file
cd /data/mxib2/data/ftp/liv/archive/Archive_ConfigFiles/
#
rm /opt/mxib2/tmp/liv-full-edi-supplier-list.csv
rm /opt/mxib2/tmp/liv-web-edi-supplier-list.csv
rm /opt/mxib2/tmp/WEB-EDI-n-FULL-EDI-List.zip
#
FULL_EDI_SUP_LIST=/opt/mxib2/tmp/liv-full-edi-supplier-list.csv
SUP_LIST=/opt/mxib2/tmp/liv-web-edi-supplier-list.csv
WEB_EDI_n_FULL_EDI_List=/opt/mxib2/tmp/WEB-EDI-n-FULL-EDI-List.zip
arcfile=$(ls -ltr | tail -1 | awk '{print $9}')
#echo $arcfile
#
############################# FULL-EDI List ####################
#
fr=$(grep -n '# START External/Full-EDI suppliers' $arcfile | awk -F ':' '{print $1}')
ls=$(grep -n '# END External/Full-EDI suppliers' $arcfile | awk -F ':' '{print $1}')
echo "[Supplier Name] ; [Supplier EAN]" > $FULL_EDI_SUP_LIST
sed -n "$fr , $ls p" $arcfile | grep '^DTA' | awk -F '|' '{print $2 ";" $4}' | sed -e 's/ORDERS_LIV_to_/ /g' | sed -e 's/ORDERS_to_LIV_/ /g' | sed -e 's/ORDERSXML_LIV_/ /g' >> $FULL_EDI_SUP_LIST
sleep 5
############################# WEB-EDI List ####################
#
echo "[Supplier Name] ; [Supplier EAN]" > $SUP_LIST
grep -B 3 '/LIV/salja/orders' $arcfile | grep '^DTA'| awk -F '|' '{print $2 ";" $4}' | sed -e 's/ORDERS_LIV_to_/ /g' | sed -e 's/ORDERS_to_LIV_/ /g' | sed -e 's/ORDERSXML_LIV_/ /g' >> $SUP_LIST
sleep 5
#################################
##ZIP files
zip -r $WEB_EDI_n_FULL_EDI_List $SUP_LIST $FULL_EDI_SUP_LIST
#
#################################
echo "Pelase find the attached LIV WEB-EDI/FULL-EDI supplier list on $dte." | mutt -a $WEB_EDI_n_FULL_EDI_List -s "LIV WEB-EDI/FULL-EDI supplier List on $dte" -- procurement.2ndline.int@ebuilder.com procurement.2ndline@ebuilder.com
#echo "Pelase find the attached LIV WEB-EDI/FULL-EDI supplier list on $dte." | mutt -a $WEB_EDI_n_FULL_EDI_List -s "LIV WEB-EDI/FULL-EDI supplier List on $dte" -- sagara.jayathilaka@ebuilder.com
