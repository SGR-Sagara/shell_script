#!/bin/bash
#VGR message checker

base='/data/mxib/data/projectbackup/mxib/vgr/archive/'
exin_des=$base'exin_despatchadvice'
exin_inv=$base'exin_invoice'
exin_ord=$base'exin_orderresponse'
exin_pri=$base'exin_pricat'
exin_svef=$base'exin_svefaktura'
exout_faxorder=$base'exout_faxorders'
exout_inv=$base'exout_invoice'
exout_order=$base'exout_orders'
exout_sveorde=$base'exout_sveorder'
rdex_ank=$base'rdex_ankomst'
rdex_att=$base'rdex_attest'
rdex_kund=$base'rdex_kundfaktura'
rdex_makul=$base'rdex_makulering'
rdin_auth=$base'rdin_authledger'
rdin_kod=$base'rdin_kodplan'
rdin_paydatlev=$base'rdin_paydateslev'
rdin_zip=$base'rdin_zipfiles'
salja_despatch=$base'salja_despatchadvice'
salja_inv=$base'salja_invoice'
salja_ordrsp=$base'salja_orderresponse'
salja_order=$base'salja_orders'
whin_despatch=$base'whin_despatchadvice'
whin_ilev_1=$base'whin_ilev1'
whin_ordrsp=$base'whin_orderresponse'
whin_receiveadvic=$base'whin_receiveadvice'
whin_refillorder=$base'whin_refillorders'
whout_despatchadvic=$base'whout_despatchadvice'
whout_ordrsp=$base'whout_orderresponse'
whout_receiveadvic=$base'whout_receiveadvice'

msgtyp1='DESADV From Suppliers                '
msgtyp2='INVOICE From Suppliers               '
msgtyp3='ORDRSP From Suppliers                '
msgtyp4='PRICAT From Suppliers                '
msgtyp5='SVEFAKTURA From Suppliers            '
msgtyp6='FAX Orders to Suppliers              '
msgtyp7='Out Going Invoices from App          '
msgtyp8='EDI Orders to Suppliers              '
msgtyp9='SVE Orders to Suppliers              '
msgtyp10='ANK from Applcation                  '
msgtyp11='ATT from Applcation                  '
msgtyp12='KUNDUFAKRUTA from Application        '
msgtyp13='MAKUL from Application               '
msgtyp14='AUTH LEDGER from Raindance           '
msgtyp15='KODPLAN from Raindance               '
msgtyp16='PAY DATES LEV from Raindance         '
msgtyp17='ZIP Files From Raindance             '
msgtyp18='DESADV Files from SALJA              '
msgtyp19='INVOICE Files from SALJA             '
msgtyp20='ORDRSP Files from SALJA              '
msgtyp21='ORDER Files from SALJA               '
msgtyp22='DESADV from Warehouse to App         '
msgtyp23='ILEV1 from Warehouse to App          '
msgtyp24='ORDRSP from Warehouse to App         '
msgtyp25='RECADV from Warehouse to App         '
msgtyp26='REFILL ORDER from Warehouse to App   '
msgtyp27='DESADV from App to Warehouse         '
msgtyp28='ORDRSP from App to Warehouse         '
msgtyp29='RECADV from App to Warehouse         '

msghed='Message Type                        | '
reptim=' Last File Received Time Date & Time(MM-DD HH:mm) |'
nofils='| Number of files During Last Hour |'
#timspc=' Feb-7 18:29                                     '
timspc='                                     '
nofiles='No files during last Hour'

cd $base
#pwd

#Remove Stat file 
if [ -e message_stat.txt ]
then
   rm $base'message_stat.txt'
fi

#Create stat file
touch message_stat.txt

#get the date
davasa=$(date +"%Y%m%d")
#echo "Date is -> " $davasa

echo '####################### VGR Message Stat Report during last Hour ######################' >> $base'message_stat.txt'
echo '' >> $base'message_stat.txt'
echo 'Message Type                  | Last File Received Time Date & Time(MM-DD HH:mm)| Number of files During Last Hour |' >> $base'message_stat.txt'
#echo '________________________________________________________________' >> $base'message_stat.txt'
###########exin_despatchadvice###########
#echo '############ 1. External Supplier Despatch advices Stats##############' >> $base'message_stat.txt'
if [ -d $exin_des ]
then
   cd $exin_des
   if [ -d $davasa ]
   then 
	cd $davasa
#	echo '1.1 External Supplier Despatch advices - Count' >> $base'message_stat.txt'
	count1=$(find . -cmin -60 -type f -exec ls -l {} \; | wc -l) #>> $base'message_stat.txt'
#	echo $count1
#       echo '1.2 External Supplier Despatch advices - Last Message Processed time' >> $base'message_stat.txt'
        dte1=$(ls -ltr | tail -1 | awk '{ print $6 "-" $7 "  "  $8}') #>> $base'message_stat.txt'
#	echo $dte1
#echo 'Message Type                  | Last File Received Time Date & Time(MM-DD HH:mm)| Number of files During Last Hour |' 
echo "$msgtyp1"$dte1"$timspc"$count1 >> $base'message_stat.txt'
   else
      echo "$msgtyp1""$nofiles" >> $base'message_stat.txt'
   fi
else
   echo "$msgtyp1""$nofiles" >> $base'message_stat.txt'
fi
cd $base


###########exin_invoice###########
#echo '############ 2. External Supplier Invoices Stats ##############' >> $base'message_stat.txt'
if [ -d $exin_inv ]
then
   cd $exin_inv
   if [ -d $davasa ]
   then 
	cd $davasa
	#echo '2.1 External Supplier Invoices - Count' >> $base'message_stat.txt'
	count2=$(find . -cmin -60 -type f -exec ls -l {} \; | wc -l) # >> $base'message_stat.txt'
        #echo '2.2 External Supplier Invoices - Last Message Processed time' >> $base'message_stat.txt'
        dte2=$(ls -ltr | tail -1 | awk '{ print $6 "-" $7 "  "  $8}') # >> $base'message_stat.txt'
	echo "$msgtyp2"$dte2"$timspc"$count2 >> $base'message_stat.txt'
   else
      echo "$msgtyp2""$nofiles" >> $base'message_stat.txt'
   fi
else
   echo "$msgtyp2""$nofiles" >> $base'message_stat.txt'
fi
cd $base

###########exin_orderresponse###########
#echo '############ 3. External Supplier Order Response Stats ##############' >> $base'message_stat.txt'
if [ -d $exin_ord ]
then
   cd $exin_ord
   if [ -d $davasa ]
   then 
	cd $davasa
	#echo '3.1 External Supplier Invoices - Count' >> $base'message_stat.txt'
	count3=$(find . -cmin -60 -type f -exec ls -l {} \; | wc -l) #>> $base'message_stat.txt'
        #echo '3.2 External Supplier Invoices - Last Message Processed time' >> $base'message_stat.txt'
        dte3=$(ls -ltr | tail -1 | awk '{ print $6 "-" $7 "  "  $8}') #>> $base'message_stat.txt'
	echo "$msgtyp3"$dte3"$timspc"$count3 >> $base'message_stat.txt'
   else
       echo "$msgtyp3""$nofiles" >> $base'message_stat.txt'
   fi
else
   echo "$msgtyp3""$nofiles" >> $base'message_stat.txt'
fi
cd $base

###########exin_pricat###########
#echo '############ 4. External Supplier PRICAT Stats ##############' >> $base'message_stat.txt'
if [ -d $exin_pri ]
then
   cd $exin_pri
   if [ -d $davasa ]
   then 
	cd $davasa
	#echo '4.1 External Supplier PRICAT - Count' >> $base'message_stat.txt'
	count4=$(find . -cmin -60 -type f -exec ls -l {} \; | wc -l) #>> $base'message_stat.txt'
        #echo '4.2 External Supplier PRICAT - Last Message Processed time' >> $base'message_stat.txt'
        dte4=$(ls -ltr | tail -1 | awk '{ print $6 "-" $7 "  "  $8}') #>> $base'message_stat.txt'
	echo "$msgtyp4"$dte4"$timspc"$count4 >> $base'message_stat.txt'
   else
      echo "$msgtyp4""$nofiles" >> $base'message_stat.txt'
   fi
else
   echo "$msgtyp4""$nofiles" >> $base'message_stat.txt'
fi
cd $base

###########exin_svefaktura###########
#echo '############ 5. External Supplier SVEFAKTURA Stats ##############' >> $base'message_stat.txt'
if [ -d $exin_svef ]
then
   cd $exin_svef
   if [ -d $davasa ]
   then 
	cd $davasa
	#echo '5.1 External Supplier SVEFAKTURA - Count' >> $base'message_stat.txt'
	count5=$(find . -cmin -60 -type f -exec ls -l {} \; | wc -l) # >> $base'message_stat.txt'
        #echo '5.2 External Supplier SVEFAKTURA - Last Message Processed time' >> $base'message_stat.txt'
        dte5=$(ls -ltr | tail -1 | awk '{ print $6 "-" $7 "  "  $8}') #>> $base'message_stat.txt'
	echo "$msgtyp5"$dte5"$timspc"$count5 >> $base'message_stat.txt'
   else
      echo "$msgtyp5""$nofiles" >> $base'message_stat.txt'
   fi
else
   echo "$msgtyp5""$nofiles" >> $base'message_stat.txt'
fi
cd $base

###########exout_faxorders###########
#echo '############ 6. External Supplier FAX Orders Stats ##############' >> $base'message_stat.txt'
if [ -d $exout_faxorder ]
then
   cd $exout_faxorder
   if [ -d $davasa ]
   then 
	cd $davasa
	#echo '6.1 External Supplier  FAX Orders - Count' >> $base'message_stat.txt'
	count6=$(find . -cmin -60 -type f -exec ls -l {} \; | wc -l) # >> $base'message_stat.txt'
        #echo '6.2 External Supplier  FAX Orders - Last Message Processed time' >> $base'message_stat.txt'
        dte6=$(ls -ltr | tail -1 | awk '{ print $6 "-" $7 "  "  $8}') # >> $base'message_stat.txt'
	echo "$msgtyp6"$dte6"$timspc"$count6 >> $base'message_stat.txt'
   else
      echo "$msgtyp6""$nofiles" >> $base'message_stat.txt'
   fi
else
   echo "$msgtyp6""$nofiles" >> $base'message_stat.txt'
fi
cd $base

###########exout_invoice###########
#echo '############ 7. Out Invoices Stats ##############' >> $base'message_stat.txt'
if [ -d $exout_inv ]
then
   cd $exout_inv
   if [ -d $davasa ]
   then 
	cd $davasa
	#echo '7.1 Out Invoices - Count' >> $base'message_stat.txt'
	count7=$(find . -cmin -60 -type f -exec ls -l {} \; | wc -l) #>> $base'message_stat.txt'
        #echo '7.2 Out Invoices - Last Message Processed time' >> $base'message_stat.txt'
        dte7=$(ls -ltr | tail -1 | awk '{ print $6 "-" $7 "  "  $8}') #>> $base'message_stat.txt'
	echo "$msgtyp7"$dte7"$timspc"$count7 >> $base'message_stat.txt'
   else
      echo "$msgtyp7""$nofiles" >> $base'message_stat.txt'
   fi
else
   echo "$msgtyp7""$nofiles" >> $base'message_stat.txt'
fi
cd $base

###########exout_orders###########
#echo '############ 8. Out Order Stats ##############' >> $base'message_stat.txt'
if [ -d $exout_order ]
then
   cd $exout_order
   if [ -d $davasa ]
   then 
	cd $davasa
	#echo '8.1 Out Order - Count' >> $base'message_stat.txt'
	count8=$(find . -cmin -60 -type f -exec ls -l {} \; | wc -l) #>> $base'message_stat.txt'
        #echo '8.2 Out Order - Last Message Processed time' >> $base'message_stat.txt'
        dte8=$(ls -ltr | tail -1 | awk '{ print $6 "-" $7 "  "  $8}') #>> $base'message_stat.txt'
	echo "$msgtyp8"$dte8"$timspc"$count8 >> $base'message_stat.txt'
   else
      echo "$msgtyp8""$nofiles" >> $base'message_stat.txt'
   fi
else
   echo "$msgtyp8""$nofiles" >> $base'message_stat.txt'
fi
cd $base

###########exout_sveorder###########
#echo '############ 9. Out SVE Order Stats ##############' >> $base'message_stat.txt'
if [ -d $exout_sveorde ]
then
   cd $exout_sveorde
   if [ -d $davasa ]
   then 
	cd $davasa
	#echo '9.1 Out SVE Order - Count' >> $base'message_stat.txt'
	count9=$(find . -cmin -60 -type f -exec ls -l {} \; | wc -l) >> $base'message_stat.txt'
        #echo '9.2 Out SVE Order - Last Message Processed time' >> $base'message_stat.txt'
        dte9=$(ls -ltr | tail -1 | awk '{ print $6 "-" $7 "  "  $8}') >> $base'message_stat.txt'
	echo "$msgtyp9"$dte9"$timspc"$count9 >> $base'message_stat.txt'
   else
      echo "$msgtyp9""$nofiles" >> $base'message_stat.txt'
   fi
else
   echo "$msgtyp9""$nofiles" >> $base'message_stat.txt'
fi
cd $base

###########rdex_ankomst###########
#echo '############ 10. To Raindance ANK files Stats ##############' >> $base'message_stat.txt'
if [ -d $rdex_ank ]
then
   cd $rdex_ank
   if [ -d $davasa ]
   then 
	cd $davasa
	#echo '10.1 To Raindance ANK file - Count' >> $base'message_stat.txt'
	count10=$(find . -cmin -60 -type f -exec ls -l {} \; | wc -l) #>> $base'message_stat.txt'
        #echo '10.2 To Raindance ANK file - Last Message Processed time' >> $base'message_stat.txt'
        dte10=$(ls -ltr | tail -1 | awk '{ print $6 "-" $7 "  "  $8}') # >> $base'message_stat.txt'
	echo "$msgtyp10"$dte10"$timspc"$count10 >> $base'message_stat.txt'
   else
      echo "$msgtyp10""$nofiles" >> $base'message_stat.txt'
   fi
else
   echo "$msgtyp10""$nofiles" >> $base'message_stat.txt'
fi
cd $base

###########rdex_attest###########
#echo '############ 11. To Raindance ATT files Stats ##############' >> $base'message_stat.txt'
if [ -d $rdex_att ]
then
   cd $rdex_att
   if [ -d $davasa ]
   then 
	cd $davasa
	#echo '11.1 To Raindance ATT file - Count' >> $base'message_stat.txt'
	count11=$(find . -cmin -60 -type f -exec ls -l {} \; | wc -l) # >> $base'message_stat.txt'
        #echo '11.2 To Raindance ATT file - Last Message Processed time' >> $base'message_stat.txt'
        dte11=$(ls -ltr | tail -1 | awk '{ print $6 "-" $7 "  "  $8}') >> $base'message_stat.txt'
	echo "$msgtyp11"$dte11"$timspc"$count11 >> $base'message_stat.txt'
   else
      echo "$msgtyp11""$nofiles" >> $base'message_stat.txt'
   fi
else
   echo "$msgtyp11""$nofiles" >> $base'message_stat.txt'
fi
cd $base

###########rdex_kundfaktura###########
#echo '############ 12. To Raindance KUND files Stats ##############' >> $base'message_stat.txt'
if [ -d $rdex_kund ]
then
   cd $rdex_kund
   if [ -d $davasa ]
   then 
	cd $davasa
	#echo '12.1 To Raindance KUND file - Count' >> $base'message_stat.txt'
	count12=$(find . -cmin -60 -type f -exec ls -l {} \; | wc -l) #>> $base'message_stat.txt'
        #echo '12.2 To Raindance KUND file - Last Message Processed time' >> $base'message_stat.txt'
        dte12=$(ls -ltr | tail -1 | awk '{ print $6 "-" $7 "  "  $8}') #>> $base'message_stat.txt'
	echo "$msgtyp12"$dte12"$timspc"$count12 >> $base'message_stat.txt'

   else
      echo "$msgtyp12""$nofiles" >> $base'message_stat.txt'
   fi
else
   echo "$msgtyp12""$nofiles" >> $base'message_stat.txt'
fi
cd $base

###########rdex_makulering###########
#echo '############ 13. To Raindance MAKUL files Stats ##############' >> $base'message_stat.txt'
if [ -d $rdex_makulering ]
then
   cd $rdex_makulering
   if [ -d $davasa ]
   then 
	cd $davasa
	#echo '13.1 To Raindance MAKUL file - Count' >> $base'message_stat.txt'
	count13=$(find . -cmin -60 -type f -exec ls -l {} \; | wc -l) # >> $base'message_stat.txt'
        #echo '13.2 To Raindance MAKUL file - Last Message Processed time' >> $base'message_stat.txt'
        dte13=$(ls -ltr | tail -1 | awk '{ print $6 "-" $7 "  "  $8}') # >> $base'message_stat.txt'
	echo "$msgtyp13"$dte13"$timspc"$count13 >> $base'message_stat.txt'
   else
      echo "$msgtyp13""$nofiles" >> $base'message_stat.txt'
   fi
else
   echo "$msgtyp13""$nofiles" >> $base'message_stat.txt'
fi
cd $base

###########rdin_authledger###########
#echo '############ 14. Authorization Ledger files Stats ##############' >> $base'message_stat.txt'
if [ -d $rdin_auth ]
then
   cd $rdin_auth
   if [ -d $davasa ]
   then 
	cd $davasa
	#echo '14.1 Authorization Ledger file - Count' >> $base'message_stat.txt'
	count14=$(find . -cmin -60 -type f -exec ls -l {} \; | wc -l) # >> $base'message_stat.txt'
        #echo '14.2 Authorization Ledger file - Last Message Processed time' >> $base'message_stat.txt'
        dte14=$(ls -ltr | tail -1 | awk '{ print $6 "-" $7 "  "  $8}') # >> $base'message_stat.txt'
	echo "$msgtyp14"$dte14"$timspc"$count14 >> $base'message_stat.txt'
   else
      echo "$msgtyp14""$nofiles" >> $base'message_stat.txt'
   fi
else
   echo "$msgtyp14""$nofiles" >> $base'message_stat.txt'
fi
cd $base

###########rdin_kodplan###########
#echo '############ 15. KODPLAN files Stats ##############' >> $base'message_stat.txt'
if [ -d $rdin_kod ]
then
   cd $rdin_kod
   if [ -d $davasa ]
   then 
	cd $davasa
	#echo '15.1 KODPLAN file - Count' >> $base'message_stat.txt'
	count15=$(find . -cmin -60 -type f -exec ls -l {} \; | wc -l) # >> $base'message_stat.txt'
        #echo '15.2 KODPLAN file - Last Message Processed time' >> $base'message_stat.txt'
        dte15=$(ls -ltr | tail -1 | awk '{ print $6 "-" $7 "  "  $8}') # >> $base'message_stat.txt'
	echo "$msgtyp15"$dte15"$timspc"$count15 >> $base'message_stat.txt'
   else
      echo "$msgtyp15""$nofiles" >> $base'message_stat.txt'
   fi
else
   echo "$msgtyp15""$nofiles" >> $base'message_stat.txt'
fi
cd $base

###########rdin_paydateslev###########
#echo '############ 16. Pay Dates Lev files Stats ##############' >> $base'message_stat.txt'
if [ -d $rdin_paydatlev ]
then
   cd $rdin_paydatlev
   if [ -d $davasa ]
   then 
	cd $davasa
	#echo '16.1 Pay Dates Lev file - Count' >> $base'message_stat.txt'
	count16=$(find . -cmin -60 -type f -exec ls -l {} \; | wc -l) # >> $base'message_stat.txt'
        #echo '16.2 Pay Dates Lev file - Last Message Processed time' >> $base'message_stat.txt'
        dte16=$(ls -ltr | tail -1 | awk '{ print $6 "-" $7 "  "  $8}') # >> $base'message_stat.txt'
	echo "$msgtyp16"$dte16"$timspc"$count16 >> $base'message_stat.txt'
   else
      echo "$msgtyp16""$nofiles" >> $base'message_stat.txt'
   fi
else
   echo "$msgtyp16""$nofiles" >> $base'message_stat.txt'
fi
cd $base

###########rdin_zipfiles###########
#echo '############ 17. Raindance ZIP files Stats ##############' >> $base'message_stat.txt'
if [ -d $rdin_zip ]
then
   cd $rdin_zip
   if [ -d $davasa ]
   then 
	cd $davasa
	#echo '17.1 Raindance ZIP file - Count' >> $base'message_stat.txt'
	count17=$(find . -cmin -60 -type f -exec ls -l {} \; | wc -l) # >> $base'message_stat.txt'
        #echo '17.2 Raindance ZIP file - Last Message Processed time' >> $base'message_stat.txt'
        dte17=$(ls -ltr | tail -1 | awk '{ print $6 "-" $7 "  "  $8}') # >> $base'message_stat.txt'
	echo "$msgtyp17"$dte17"$timspc"$count17 >> $base'message_stat.txt'
   else
      echo "$msgtyp17""$nofiles" >> $base'message_stat.txt'
   fi
else
   echo "$msgtyp17""$nofiles" >> $base'message_stat.txt'
fi
cd $base

###########salja_despatchadvice###########
#echo '############ 18. SALJA DESADV files Stats ##############' >> $base'message_stat.txt'
if [ -d $salja_despatch ]
then
   cd $salja_despatch
   if [ -d $davasa ]
   then 
	cd $davasa
	#echo '18.1 SALJA DESADV file - Count' >> $base'message_stat.txt'
	count18=$(find . -cmin -60 -type f -exec ls -l {} \; | wc -l) # >> $base'message_stat.txt'
        #echo '18.2 SALJA DESADV file - Last Message Processed time' >> $base'message_stat.txt'
        dte18=$(ls -ltr | tail -1 | awk '{ print $6 "-" $7 "  "  $8}') # >> $base'message_stat.txt'
	echo "$msgtyp18"$dte18"$timspc"$count18 >> $base'message_stat.txt'
   else
      echo "$msgtyp18""$nofiles" >> $base'message_stat.txt'
   fi
else
   echo "$msgtyp18""$nofiles" >> $base'message_stat.txt'
fi
cd $base

###########salja_invoice###########
#echo '############ 19. SALJA Invoice files Stats ##############' >> $base'message_stat.txt'
if [ -d $salja_inv ]
then
   cd $salja_inv
   if [ -d $davasa ]
   then 
	cd $davasa
	#echo '19.1 SALJA Invoice file - Count' >> $base'message_stat.txt'
	count19=$(find . -cmin -60 -type f -exec ls -l {} \; | wc -l) # >> $base'message_stat.txt'
        #echo '19.2 SALJA Invoice file - Last Message Processed time' >> $base'message_stat.txt'
        dte19=$(ls -ltr | tail -1 | awk '{ print $6 "-" $7 "  "  $8}') # >> $base'message_stat.txt'
	echo "$msgtyp19"$dte19"$timspc"$count19 >> $base'message_stat.txt'
   else
      echo "$msgtyp19""$nofiles" >> $base'message_stat.txt'
   fi
else
   echo "$msgtyp19""$nofiles" >> $base'message_stat.txt'
fi
cd $base

###########salja_orderresponse###########
#echo '############ 20. SALJA ORDRSP files Stats ##############' >> $base'message_stat.txt'
if [ -d $salja_ordrsp ]
then
   cd $salja_ordrsp
   if [ -d $davasa ]
   then 
	cd $davasa
	#echo '20.1 SALJA ORDRSP file - Count' >> $base'message_stat.txt'
	count20=$(find . -cmin -60 -type f -exec ls -l {} \; | wc -l) # >> $base'message_stat.txt'
        #echo '20.2 SALJA ORDRSP file - Last Message Processed time' >> $base'message_stat.txt'
        dte20=$(ls -ltr | tail -1 | awk '{ print $6 "-" $7 "  "  $8}') # >> $base'message_stat.txt'
	echo "$msgtyp20"$dte20"$timspc"$count20 >> $base'message_stat.txt'
   else
      echo "$msgtyp20""$nofiles" >> $base'message_stat.txt'
   fi
else
   echo "$msgtyp20""$nofiles" >> $base'message_stat.txt'
fi
cd $base

###########salja_orders###########
#echo '############ 21. SALJA ORDERS files Stats ##############' >> $base'message_stat.txt'
if [ -d $salja_order ]
then
   cd $salja_order
   if [ -d $davasa ]
   then 
	cd $davasa
	#echo '21.1 SALJA ORDERS file - Count' >> $base'message_stat.txt'
	count21=$(find . -cmin -60 -type f -exec ls -l {} \; | wc -l) # >> $base'message_stat.txt'
        #echo '21.2 SALJA ORDERS file - Last Message Processed time' >> $base'message_stat.txt'
        dte21=$(ls -ltr | tail -1 | awk '{ print $6 "-" $7 "  "  $8}') # >> $base'message_stat.txt'
	echo "$msgtyp21"$dte21"$timspc"$count21 >> $base'message_stat.txt'
   else
      echo "$msgtyp21""$nofiles" >> $base'message_stat.txt'
   fi
else
   echo "$msgtyp21""$nofiles" >> $base'message_stat.txt'
fi
cd $base

###########whin_despatchadvice###########
#echo '############ 22. Wharehouse DESADV files Stats ##############' >> $base'message_stat.txt'
if [ -d $whin_despatch ]
then
   cd $whin_despatch
   if [ -d $davasa ]
   then 
	cd $davasa
	#echo '22.1 Wharehouse DESADV file - Count' >> $base'message_stat.txt'
	count22=$(find . -cmin -60 -type f -exec ls -l {} \; | wc -l) # >> $base'message_stat.txt'
        #echo '22.2 Wharehouse DESADV file - Last Message Processed time' >> $base'message_stat.txt'
        dte22=$(ls -ltr | tail -1 | awk '{ print $6 "-" $7 "  "  $8}') # >> $base'message_stat.txt'
	echo "$msgtyp22"$dte22"$timspc"$count22 >> $base'message_stat.txt'
   else
      echo "$msgtyp22""$nofiles" >> $base'message_stat.txt'
   fi
else
   echo "$msgtyp22""$nofiles" >> $base'message_stat.txt'
fi
cd $base

###########whin_ilev1###########
#echo '############ 23. Wharehouse ILEV1 files Stats ##############' >> $base'message_stat.txt'
if [ -d $whin_ilev_1 ]
then
   cd $whin_ilev_1
   if [ -d $davasa ]
   then 
	cd $davasa
	#echo '23.1 Wharehouse ILEV1 file - Count' >> $base'message_stat.txt'
	count23=$(find . -cmin -60 -type f -exec ls -l {} \; | wc -l) # >> $base'message_stat.txt'
        #echo '23.2 Wharehouse ILEV1 file - Last Message Processed time' >> $base'message_stat.txt'
        dte23=$(ls -ltr | tail -1 | awk '{ print $6 "-" $7 "  "  $8}') >> $base'message_stat.txt'
	echo "$msgtyp23"$dte23"$timspc"$count23 >> $base'message_stat.txt'
   else
      echo "$msgtyp23""$nofiles" >> $base'message_stat.txt'
   fi
else
   echo "$msgtyp23""$nofiles" >> $base'message_stat.txt'
fi
cd $base

###########whin_orderresponse###########
#echo '############ 24. Wharehouse ORDRSP files Stats ##############' >> $base'message_stat.txt'
if [ -d $whin_ordrsp ]
then
   cd $whin_ordrsp
   if [ -d $davasa ]
   then 
	cd $davasa
	#echo '24.1 Wharehouse ORDRSP file - Count' >> $base'message_stat.txt'
	count24=$(find . -cmin -60 -type f -exec ls -l {} \; | wc -l) # >> $base'message_stat.txt'
        #echo '24.2 Wharehouse ORDRSP file - Last Message Processed time' >> $base'message_stat.txt'
        dte24=$(ls -ltr | tail -1 | awk '{ print $6 "-" $7 "  "  $8}') # >> $base'message_stat.txt'
	echo "$msgtyp24"$dte24"$timspc"$count24 >> $base'message_stat.txt'
   else
      echo "$msgtyp24""$nofiles" >> $base'message_stat.txt'
   fi
else
   echo "$msgtyp24""$nofiles" >> $base'message_stat.txt'
fi
cd $base

###########whin_receiveadvice###########
#echo '############ 25. Wharehouse RECADV files Stats ##############' >> $base'message_stat.txt'
if [ -d $whin_receiveadvic ]
then
   cd $whin_receiveadvic
   if [ -d $davasa ]
   then 
	cd $davasa
	#echo '25.1 Wharehouse RECADV file - Count' >> $base'message_stat.txt'
	count25=$(find . -cmin -60 -type f -exec ls -l {} \; | wc -l) # >> $base'message_stat.txt'
        #echo '25.2 Wharehouse RECADV file - Last Message Processed time' >> $base'message_stat.txt'
        dte25=$(ls -ltr | tail -1 | awk '{ print $6 "-" $7 "  "  $8}') # >> $base'message_stat.txt'
	echo "$msgtyp25"$dte25"$timspc"$count25 >> $base'message_stat.txt'
   else
      echo "$msgtyp25""$nofiles" >> $base'message_stat.txt'
   fi
else
   echo "$msgtyp25""$nofiles" >> $base'message_stat.txt'
fi
cd $base

###########whin_refillorders###########
#echo '############ 26. Wharehouse REFILLORDERS files Stats ##############' >> $base'message_stat.txt'
if [ -d $whin_refillorder ]
then
   cd $whin_refillorder
   if [ -d $davasa ]
   then 
	cd $davasa
	#echo '26.1 Wharehouse REFILLORDERS file - Count' >> $base'message_stat.txt'
	count26=$(find . -cmin -60 -type f -exec ls -l {} \; | wc -l) # >> $base'message_stat.txt'
        #echo '26.2 Wharehouse REFILLORDERS file - Last Message Processed time' >> $base'message_stat.txt'
        dte26=$(ls -ltr | tail -1 | awk '{ print $6 "-" $7 "  "  $8}') # >> $base'message_stat.txt'
	echo "$msgtyp26"$dte26"$timspc"$count26 >> $base'message_stat.txt'
   else
      echo "$msgtyp26""$nofiles" >> $base'message_stat.txt'
   fi
else
   echo "$msgtyp26""$nofiles" >> $base'message_stat.txt'
fi
cd $base

###########whout_despatchadvic###########
#echo '############ 27. Wharehouse OUT DESADV files Stats ##############' >> $base'message_stat.txt'
if [ -d $whout_despatchadvic ]
then
   cd $whout_despatchadvic
   if [ -d $davasa ]
   then 
	cd $davasa
	#echo '27.1 Wharehouse OUT DESADV file - Count' >> $base'message_stat.txt'
	count27=$(find . -cmin -60 -type f -exec ls -l {} \; | wc -l) # >> $base'message_stat.txt'
        #echo '27.2 Wharehouse OUT DESADV file - Last Message Processed time' >> $base'message_stat.txt'
        dte27=$(ls -ltr | tail -1 | awk '{ print $6 "-" $7 "  "  $8}') # >> $base'message_stat.txt'
	echo "$msgtyp27"$dte27"$timspc"$count27 >> $base'message_stat.txt'
   else
      echo "$msgtyp27""$nofiles" >> $base'message_stat.txt'
   fi
else
   echo "$msgtyp27""$nofiles" >> $base'message_stat.txt'
fi
cd $base

###########whout_orderresponse###########
#echo '############ 28. Wharehouse OUT ORDRSP files Stats ##############' >> $base'message_stat.txt'
if [ -d $whout_ordrsp ]
then
   cd $whout_ordrsp
   if [ -d $davasa ]
   then 
	cd $davasa
	#echo '28.1 Wharehouse OUT ORDRSP file - Count' >> $base'message_stat.txt'
	count28=$(find . -cmin -60 -type f -exec ls -l {} \; | wc -l) # >> $base'message_stat.txt'
        #echo '28.2 Wharehouse OUT ORDRSP file - Last Message Processed time' >> $base'message_stat.txt'
        dte28=$(ls -ltr | tail -1 | awk '{ print $6 "-" $7 "  "  $8}') # >> $base'message_stat.txt'
	echo "$msgtyp28"$dte28"$timspc"$count28 >> $base'message_stat.txt'
   else
      echo "$msgtyp28""$nofiles" >> $base'message_stat.txt'
   fi
else
   echo "$msgtyp28""$nofiles" >> $base'message_stat.txt'
fi
cd $base

###########whout_orderresponse###########
#echo '############ 29. Wharehouse OUT RECADV files Stats ##############' >> $base'message_stat.txt'
if [ -d $whout_receiveadvic ]
then
   cd $whout_receiveadvic
   if [ -d $davasa ]
   then 
	cd $davasa
	#echo '29.1 Wharehouse OUT RECADV file - Count' >> $base'message_stat.txt'
	count29=$(find . -cmin -60 -type f -exec ls -l {} \; | wc -l) # >> $base'message_stat.txt'
        #echo '29.2 Wharehouse OUT RECADV file - Last Message Processed time' >> $base'message_stat.txt'
        dte29=$(ls -ltr | tail -1 | awk '{ print $6 "-" $7 "  "  $8}') # >> $base'message_stat.txt'
	echo "$msgtyp29"$dte29"$timspc"$count29 >> $base'message_stat.txt'
   else
      echo "$msgtyp29""$nofiles" >> $base'message_stat.txt'
   fi
else
   echo "$msgtyp29""$nofiles" >> $base'message_stat.txt'
fi
cd $base
sleep 5
mail -s "VGR Message Stat Report During Last Hour" sagara.jayathilaka@ebuilder.com < $base'message_stat.txt'