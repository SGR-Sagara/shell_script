#!/bin/bash
#cd /home/trafik/VGR_BACKUP/pagero/discard/
cd /data/mxib/data/projectbackup/mxib/vgr/pagero/discard/
testArray=$(find . -ctime -7 -type f -exec grep -l '<?xml' {} \;)
cnty=$(find . -ctime -7 -type f -exec grep -l '<?xml' {} \; | wc -l)
#echo "first" $testArray
if [ $cnty -gt 1 ]
echo "Pagero Rejected invoice list during last 7 days" > /data/mxib/data/projectbackup/mxib/vgr/pagero-discarded.txt
echo " " >> /data/mxib/data/projectbackup/mxib/vgr/pagero-discarded.txt
echo "Number of rejected SVEFAKTURA invoices: " $cnty >> /data/mxib/data/projectbackup/mxib/vgr/pagero-discarded.txt
echo " " >> /data/mxib/data/projectbackup/mxib/vgr/pagero-discarded.txt
echo "Date : Invoice Type : Invoice ID : Supplier EAN :  Supplier Name " >> /data/mxib/data/projectbackup/mxib/vgr/pagero-discarded.txt
then
for i in $testArray
    do
        #echo "File Name: " "$i"
                typ="SVEFAKTURA"
                #echo "Type: " $typ
                dte=$(echo "$i" | awk -F '/' '{print $2}')
                #echo "Date: " $dte
                invID=$(grep '<ID>' $i | awk -F '>' '{print $2}' | awk -F '<' '{print $1}')
                #echo "Invoice ID: " $invID
                supEAN=$(grep -A 4 '<cac:SellerParty>' $i | grep '<cac:ID' | awk -F '>' '{print $2}' | awk -F '<' '{print $1}')
                #echo "Supplier EAN: " $supEAN
                supNM=$(grep -A 10 '<cac:SellerParty>' $i | grep '<cbc:Name' | awk -F '>' '{print $2}' | awk -F '<' '{print $1}')
                #echo "Supplier Name: " $supNM
                echo $dte " : " $typ " : " $invID    " : " $supEAN  " : " $supNM >> /data/mxib/data/projectbackup/mxib/vgr/pagero-discarded.txt
        done
fi
#sleep 5
#echo "SLEEPING"
#
#
#
cd /data/mxib/data/projectbackup/mxib/vgr/pagero/discard/
#cd /data/mxib/data/projectbackup/mxib/vgr/archive/exin_invoice/
etestArray=$(find . -ctime -7 -type f -exec grep -l "^UNA" {} \;)
cnt=$(find . -ctime -7 -type f -exec grep -l "^UNA" {} \; | wc -l)
if [ $cnt -gt 1 ]
echo " " >> /data/mxib/data/projectbackup/mxib/vgr/pagero-discarded.txt
echo "-----------------------------------------------------------" >> /data/mxib/data/projectbackup/mxib/vgr/pagero-discarded.txt
echo "Number of rejected EDI invoices: " $cnt >> /data/mxib/data/projectbackup/mxib/vgr/pagero-discarded.txt
echo " " >> /data/mxib/data/projectbackup/mxib/vgr/pagero-discarded.txt
echo "Date : Invoice Type : Invoice ID : Supplier EAN " >> /data/mxib/data/projectbackup/mxib/vgr/pagero-discarded.txt
then
for j in $etestArray
    do
        #echo "File Name: " "$j"
                etyp="EDI INVOIC"
                echo "Type: " $etyp
                edte=$(echo "$j" | awk -F '/' '{print $2}')
                echo "Date: " $edte
                einvID=$(egrep -o 'BGM.{30}' $j | awk -F '+' '{print $3}' | awk -F "'" '{print $1}')
                echo "Invoice ID: " $einvID
                esupEAN=$(egrep -o 'NAD\+SU.{40}' $j | awk -F '+' '{print $3}' | awk -F ':' '{print $1}')
                echo "Supplier EAN: " $esupEAN
                #esupNM=$(grep -A 10 '<cac:SellerParty>' $j | grep '<cbc:Name' | awk -F '>' '{print $2}' | awk -F '<' '{print $1}')
                #echo "Supplier Name: " $esupNM
                #echo $edte " ; " $einvID " ; " $esupEAN " ; " $esupNM >> /data/mxib/data/projectbackup/mxib/vgr/pagero-discarded.txt
        done		
fi
mail -s "Pagero Discarded Invoices" sagara.jayathilaka@ebuilder.com < /data/mxib/data/projectbackup/mxib/vgr/pagero-discarded.txt
