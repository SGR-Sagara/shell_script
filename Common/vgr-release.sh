#!/bin/bash
##Release checklist message verification
bse='/data/mxib/data/projectbackup/mxib/vgr/archive/'
dy=$(date +"%Y%m%d")
#dy='20140404'
fld01='exin_despatchadvice/'
fld02='exin_invoice/'
fld03='exin_orderresponse/'
fld04='exin_svefaktura/'
fld05='exout_faxorders/'
fld06='exout_invoice/'
fld07='exout_orders/'
fld08='exout_sveorder/'
fld09='rdex_ankomst/'
fld10='rdex_attest/'
fld11='rdex_kundfaktura/'
fld12='rdex_makulering/'
fld13='rdin_authledger/'
fld14='rdin_kodplan/'
fld15='rdin_paydateslev/'
fld16='salja_despatchadvice/'
fld17='salja_invoice/'
fld18='salja_orderresponse/'
fld19='salja_orders/'
fld20='whin_despatchadvice/'
fld21='whin_orderresponse/'
fld22='whin_partialinvoice/'
fld23='whin_receiveadvice/'
fld24='whin_refillorders/'
fld25='whout_despatchadvice/'
fld26='whout_orderresponse/'
fld27='whout_receiveadvice/'
dt=$(date)
echo "VGR after release message list $dt ." > $bse"/messages.txt"

##Supplier DESADV
if [ -e $bse$fld01$dy ]
then
cd $bse$fld01$dy
fld01_1=$(find . -type f | wc -l)
if [ $fld01_1 -ge 1 ]
then
lst=$(ls -ltr | tail -5 | awk '{print $9}')
echo "Supplier DESADV Total files so far $fld01_1 - Sample DESADV IDs" >> $bse"/messages.txt"
for i in $lst
do
id=$(egrep -o 'BGM.{30}' $i | awk -F '+' '{print $3}' | awk -F "'" '{print $1}')
echo $id >> $bse"/messages.txt"
done
fi
else
echo "No Supplier DESADVs received yet" >> $bse"/messages.txt"
fi

##Supplier INVOICE
if [ -e $bse$fld02$dy ]
then
cd $bse$fld02$dy
fld02_1=$(find . -type f | wc -l)
if [ $fld02_1 -ge 1 ]
then
lst=$(ls -ltr | tail -5 | awk '{print $9}')
echo "Supplier Invoice Total files so far $fld02_1 - Sample Invoice IDs" >> $bse"/messages.txt"
for i in $lst
do
id=$(egrep -o 'BGM.{30}' $i | awk -F '+' '{print $3}' | awk -F "'" '{print $1}')
echo $id >> $bse"/messages.txt"
done
fi
else
echo "No Supplier Invoices received yet" >> $bse"/messages.txt"
fi

##Supplier ORDRSP
if [ -e $bse$fld03$dy ]
then
cd $bse$fld03$dy
fld03_1=$(find . -type f | wc -l)
if [ $fld03_1 -ge 1 ]
then
lst=$(ls -ltr | tail -5 | awk '{print $9}')
echo "Supplier ORDRSP files Total so far $fld03_1 - Sample Order Response IDs" >> $bse"/messages.txt"
for i in $lst
do
id=$(egrep -o 'BGM.{30}' $i | awk -F '+' '{print $3}' | awk -F "'" '{print $1}')
echo $id >> $bse"/messages.txt"
done
fi
else
echo "No Supplier ORDRSPs received yet" >> $bse"/messages.txt"
fi

##Supplier SVEFAKTURA INVOICES
if [ -e $bse$fld04$dy ]
then
cd $bse$fld04$dy
fld04_1=$(find . -type f | wc -l)
if [ $fld04_1 -ge 1 ]
then
lst=$(ls -ltr | tail -5 | awk '{print $9}')
echo "Supplier SVEFAKTURA INVOICES files Total so far $fld04_1 - Sample SVEFAKTURA INVOICE IDs" >> $bse"/messages.txt"
for i in $lst
do
id=$(grep '<ID>' $i | awk -F '>' '{print $2}' | awk -F '<' '{print $1}')
echo $id >> $bse"/messages.txt"
done
fi
else
echo "No Supplier SVEFAKTURAs received yet" >> $bse"/messages.txt"
fi

##FAX Order for Supplier
if [ -e $bse$fld05$dy ]
then
cd $bse$fld05$dy
fld05_1=$(find . -type f | wc -l)
if [ $fld05_1 -ge 1 ]
then
lst=$(ls -ltr | tail -5 | awk '{print $9}')
echo "FAX Order for Supplier Total files so far $fld05_1 - Sample Order IDs" >> $bse"/messages.txt"
for i in $lst
do
id=$(grep -A 1 '<header>' $i | grep 'proprietary' | awk -F '>' '{print $2}' | awk -F '<' '{print $1}')
echo $id >> $bse"/messages.txt"
done
fi
else
echo "No VGR FAX Orders received yet" >> $bse"/messages.txt"
fi

##Outgoing Commercial Invoices for Application
if [ -e $bse$fld06$dy ]
then
cd $bse$fld06$dy
fld06_1=$(find . -type f -exec grep -l '<buyer><party><identification type="proprietary" country="SE">7350003373001' {} \; | wc -l)
if [ $fld06_1 -ge 1 ]
then
lst=$(find . -type f -exec grep -l '<buyer><party><identification type="proprietary" country="SE">7350003373001' {} \; | tail -5)
echo "Outgoing Commercial Invoices for Application Total files so far $fld06_1 - Sample Outgoing Invoice IDs" >> $bse"/messages.txt"
for i in $lst
do
id=$(egrep -o '<header>.{100}' $i | awk -F '>' '{print $3}' | awk -F '<' '{print $1}')
echo $id >> $bse"/messages.txt"
done
fi
else
echo "No Outgoing Commercial Invoices received yet" >> $bse"/messages.txt"
fi

##EDI Order for Supplier
if [ -e $bse$fld07$dy ]
then
cd $bse$fld07$dy
fld07_1=$(find . -type f | wc -l)
if [ $fld07_1 -ge 1 ]
then
lst=$(ls -ltr | tail -5 | awk '{print $9}')
echo "EDI Order for Supplier Total files so far $fld07_1 - Sample Order IDs" >> $bse"/messages.txt"
for i in $lst
do
id=$(grep -A 1 '<header>' $i | grep 'proprietary' | awk -F '>' '{print $2}' | awk -F '<' '{print $1}')
echo $id >> $bse"/messages.txt"
done
fi
else
echo "No EDI Orders received yet" >> $bse"/messages.txt"
fi

##SVE Order for Supplier
if [ -e $bse$fld08$dy ]
then
cd $bse$fld08$dy
fld08_1=$(find . -type f | wc -l)
if [ $fld08_1 -ge 1 ]
then
lst=$(ls -ltr | tail -5 | awk '{print $9}')
echo "SVE Order for Supplier Total files so far $fld08_1 - Sample Order IDs" >> $bse"/messages.txt"
for i in $lst
do
id=$(grep -A 1 '<header>' $i | grep 'proprietary' | awk -F '>' '{print $2}' | awk -F '<' '{print $1}')
echo $id >> $bse"/messages.txt"
done
fi
else
echo "No SVE Orders received yet" >> $bse"/messages.txt"
fi

##ANK files for RD
if [ -e $bse$fld09$dy ]
then
cd $bse$fld09$dy
fld09_1=$(find . -type f | wc -l)
if [ $fld09_1 -ge 1 ]
then
echo "ANKOMIST(Approve) files to RD Total files so far $fld09_1 " >> $bse"/messages.txt"
else
echo " NO ANKOMIST(Approve) files to RD Total files so far $fld09_1 " >> $bse"/messages.txt"
fi
else
echo "No ANKOMIST(Approve) received yet" >> $bse"/messages.txt"
fi

##ATT files for RD
if [ -e $bse$fld10$dy ]
then
cd $bse$fld10$dy
fld10_1=$(find . -type f | wc -l)
if [ $fld10_1 -ge 1 ]
then
echo "ATTEST(Authorize) files to RD Total files so far $fld10_1 " >> $bse"/messages.txt"
else
echo " NO ATTEST(Authorize) files to RD Total files so far $fld10_1 " >> $bse"/messages.txt"
fi
else
echo "No ATTEST(Authorize) received yet" >> $bse"/messages.txt"
fi


##KUND files for RD
if [ -e $bse$fld11$dy ]
then
cd $bse$fld11$dy
fld11_1=$(find . -type f | wc -l)
if [ $fld11_1 -ge 1 ]
then
echo "KUND(Approve) files to RD Total files so far $fld11_1 " >> $bse"/messages.txt"
else
echo " NO KUND(Approve) files to RD Total files so far $fld11_1 " >> $bse"/messages.txt"
fi
else
echo "No KUND(Approve) received yet" >> $bse"/messages.txt"
fi

##Makulering files for RD
if [ -e $bse$fld12$dy ]
then
cd $bse$fld12$dy
fld12_1=$(find . -type f | wc -l)
if [ $fld12_1 -ge 1 ]
then
echo "Makulering(REJECT) files to RD Total files so far $fld12_1 " >> $bse"/messages.txt"
else
echo " NO Makulering(REJECT) files to RD Total files so far $fld12_1 " >> $bse"/messages.txt"
fi
else
echo "No Makulering(REJECT) received yet" >> $bse"/messages.txt"
fi

##Auth Ledger from RD
if [ -e $bse$fld13$dy ]
then
cd $bse$fld13$dy
fld13_1=$(find . -type f | wc -l)
if [ $fld13_1 -ge 1 ]
then
lst=$(ls -ltr | tail -5 | awk '{print $9}')
echo "Auth Ledger Total files so far $fld13_1 - Sample Auth Ledger Records " >> $bse"/messages.txt"
for i in $lst
do
cat $i | tail -15 >> $bse"/messages.txt"
done
fi
else
echo "No Auth Ledger received yet" >> $bse"/messages.txt"
fi

##KOD PLAN from RD
if [ -e $bse$fld14$dy ]
then
cd $bse$fld14$dy
fld14_1=$(find . -type f | wc -l)
if [ $fld14_1 -ge 1 ]
then
lst=$(ls -ltr | tail -5 | awk '{print $9}')
echo "KOD PLAN(kplan) Total files so far $fld14_1 - Sample Kplan Records " >> $bse"/messages.txt"
for i in $lst
do
cat $i | tail -5 >> $bse"/messages.txt"
done
fi
else
echo "No KOD Plan received yet" >> $bse"/messages.txt"
fi

##PAYDATE from RD
if [ -e $bse$fld15$dy ]
then
cd $bse$fld15$dy
fld15_1=$(find . -type f | wc -l)
if [ $fld15_1 -ge 1 ]
then
lst=$(ls -ltr | tail -5 | awk '{print $9}')
echo "Pay Date Total files so far $fld15_1 - Sample Invoice Vs Paydate " >> $bse"/messages.txt"
for i in $lst
do
cat $i | tail -5 | cut -c 40-62 >> $bse"/messages.txt"
done
fi
else
echo "No Pay Dates received yet" >> $bse"/messages.txt"
fi

##WEB-EDI DESADVs
if [ -e $bse$fld16$dy ]
then
cd $bse$fld16$dy
fld16_1=$(find . -type f | wc -l)
if [ $fld16_1 -ge 1 ]
then
lst=$(ls -ltr | tail -5 | awk '{print $9}')
echo "WEB-EDI DESADV Total files so far $fld16_1 - Sample DESADV IDs" >> $bse"/messages.txt"
for i in $lst
do
id=$(egrep -o '<header>.{100}' $i | awk -F '>' '{print $3}' | awk -F '<' '{print $1}')
echo $id >> $bse"/messages.txt"
done
fi
else
echo "No WEB-EDI DESADVs received yet" >> $bse"/messages.txt"
fi

##WEB-EDI Invoices
if [ -e $bse$fld17$dy ]
then
cd $bse$fld17$dy
fld17_1=$(find . -type f | wc -l)
if [ $fld17_1 -ge 1 ]
then
lst=$(ls -ltr | tail -5 | awk '{print $9}')
echo "WEB-EDI Invoice Total files so far $fld17_1 - Sample WEB-EDI Invoice IDs" >> $bse"/messages.txt"
for i in $lst
do
id=$(grep -A 3 '<InvoiceHead>' $i | grep '<Number>' | awk -F '>' '{print $2}' | awk -F '<' '{print $1}')
echo $id >> $bse"/messages.txt"
done
fi
else
echo "No WEB-EDI Invoices received yet" >> $bse"/messages.txt"
fi

##WEB-EDI ORDRSP
if [ -e $bse$fld18$dy ]
then
cd $bse$fld18$dy
fld18_1=$(find . -type f | wc -l)
if [ $fld18_1 -ge 1 ]
then
lst=$(ls -ltr | tail -5 | awk '{print $9}')
echo "WEB-EDI ORDRSP Total files so far $fld18_1 - Sample WEB-EDI ORDRSP IDs" >> $bse"/messages.txt"
for i in $lst
do
id=$(grep -A 3 '<OrderResponsHead>' $i | grep '<Number>' | awk -F '>' '{print $2}' | awk -F '<' '{print $1}')
echo $id >> $bse"/messages.txt"
done
fi
else
echo "No WEB-EDI ORDRSPs received yet" >> $bse"/messages.txt"
fi

##WEB-EDI Order for Supplier
if [ -e $bse$fld19$dy ]
then
cd $bse$fld19$dy
fld19_1=$(find . -type f | wc -l)
if [ $fld19_1 -ge 1 ]
then
lst=$(ls -ltr | tail -5 | awk '{print $9}')
echo "WEB-EDI Order for Supplier Total files so far $fld19_1 - Sample Order IDs" >> $bse"/messages.txt"
for i in $lst
do
id=$(grep -A 1 '<header>' $i | grep 'proprietary' | awk -F '>' '{print $2}' | awk -F '<' '{print $1}')
echo $id >> $bse"/messages.txt"
done
fi
else
echo "No WEB-EDI Orders received yet" >> $bse"/messages.txt"
fi

##Warehouse DESADV
if [ -e $bse$fld20$dy ]
then
cd $bse$fld20$dy
fld20_1=$(find . -type f | wc -l)
if [ $fld20_1 -ge 1 ]
then
lst=$(ls -ltr | tail -5 | awk '{print $9}')
echo "Warehouse DESADV Total files so far $fld20_1 - Sample DESADV IDs" >> $bse"/messages.txt"
for i in $lst
do
id=$(egrep -o 'BGM.{30}' $i | awk -F '+' '{print $3}' | awk -F "'" '{print $1}')
echo $id >> $bse"/messages.txt"
done
fi
else
echo "No Warehouse DESADVs received yet" >> $bse"/messages.txt"
fi

##Warehouse ORDRSP
if [ -e $bse$fld21$dy ]
then
cd $bse$fld21$dy
fld21_1=$(find . -type f | wc -l)
if [ $fld21_1 -ge 1 ]
then
lst=$(ls -ltr | tail -5 | awk '{print $9}')
echo "Warehouse ORDRSP Total files so far $fld21_1 - Sample ORDRSP IDs" >> $bse"/messages.txt"
for i in $lst
do
id=$(egrep -o 'BGM.{30}' $i | awk -F '+' '{print $3}' | awk -F "'" '{print $1}')
echo $id >> $bse"/messages.txt"
done
fi
else
echo "No Warehouse ORDRSPs received yet" >> $bse"/messages.txt"
fi

##ILEV1(Partial) INVOICE
if [ -e $bse$fld22$dy ]
then
cd $bse$fld22$dy
fld22_1=$(find . -type f | wc -l)
if [ $fld22_1 -ge 1 ]
then
lst=$(ls -ltr | tail -5 | awk '{print $9}')
echo "ILEV1(Partial) INVOICE Total files so far $fld22_1 - Sample ILEV1(Partial) INVOICE IDs" >> $bse"/messages.txt"
for i in $lst
do
id=$(egrep -o '<header>.{100}' $i | awk -F '>' '{print $3}' | awk -F '<' '{print $1}')
echo $id >> $bse"/messages.txt"
done
fi
else
echo "No ILEV1(Partial) INVOICEs received yet" >> $bse"/messages.txt"
fi

##Warehouse RECADV
if [ -e $bse$fld23$dy ]
then
cd $bse$fld23$dy
fld23_1=$(find . -type f | wc -l)
if [ $fld23_1 -ge 1 ]
then
lst=$(ls -ltr | tail -5 | awk '{print $9}')
echo "Warehouse RECADV Total files so far $fld23_1 - Sample RECADV(REFILL) IDs" >> $bse"/messages.txt"
for i in $lst
do
id=$(egrep -o 'BGM.{30}' $i | awk -F '+' '{print $3}' | awk -F "'" '{print $1}')
echo $id >> $bse"/messages.txt"
done
fi
else
echo "No Warehouse RECADVs received yet" >> $bse"/messages.txt"
fi

##Warehouse Refill Orders
if [ -e $bse$fld24$dy ]
then
cd $bse$fld24$dy
fld24_1=$(find . -type f | wc -l)
if [ $fld24_1 -ge 1 ]
then
lst=$(ls -ltr | tail -5 | awk '{print $9}')
echo "Warehouse Refill Orders Total files so far $fld24_1 - Sample Refill Orders IDs" >> $bse"/messages.txt"
for i in $lst
do
id=$(egrep -o '<RefillOrderNumber>.{30}' $i | awk -F '>' '{print $2}' | awk -F '<' '{print $1}')
echo $id >> $bse"/messages.txt"
done
fi
else
echo "No Warehouse Refill Orders received yet" >> $bse"/messages.txt"
fi

##Warehouse Hamlet DESADV copyback
if [ -e $bse$fld25$dy ]
then
cd $bse$fld25$dy
fld25_1=$(find . -type f | wc -l)
if [ $fld25_1 -ge 1 ]
then
echo "Warehouse Hamlet DESADV copyback Total files so far $fld25_1 " >> $bse"/messages.txt"
else
echo " NO Warehouse Hamlet DESADV copyback Total files so far $fld25_1 " >> $bse"/messages.txt"
fi
else
echo "No Warehouse Hamlet DESADV copyback received yet" >> $bse"/messages.txt"
fi

##Warehouse Hamlet ORDRSP copyback
if [ -e $bse$fld26$dy ]
then
cd $bse$fld26$dy
fld26_1=$(find . -type f | wc -l)
if [ $fld26_1 -ge 1 ]
then
echo "Warehouse Hamlet ORDRSP copyback Total files so far $fld26_1 " >> $bse"/messages.txt"
else
echo " NO Warehouse Hamlet ORDRSP copyback Total files so far $fld26_1 " >> $bse"/messages.txt"
fi
else
echo "No Warehouse Hamlet ORDRSP copyback received yet" >> $bse"/messages.txt"
fi

##Warehouse Hamlet RECADV copyback
if [ -e $bse$fld27$dy ]
then
cd $bse$fld27$dy
fld27_1=$(find . -type f | wc -l)
if [ $fld27_1 -ge 1 ]
then
echo "Warehouse Hamlet RECADV copyback Total files so far $fld27_1 " >> $bse"/messages.txt"
else
echo " NO Warehouse Hamlet RECADV copyback Total files so far $fld27_1 " >> $bse"/messages.txt"
fi
else
echo "No Warehouse Hamlet RECADV copyback received yet" >> $bse"/messages.txt"
fi

sleep 3

mail -s "VGR After Release message verification" sagara.jayathilaka@ebuilder.com < $bse"/messages.txt"