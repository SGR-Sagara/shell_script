#! /bin/sh
## DHL Counts
#base='/home/sagara/bin/'
base='/data/phxib/data/projectbackup/phxib/dhlgf/'
tmp_root='/opt/phxib/xib/local/bin/src'
iftmin='alfa_orders/'
iftrin='alfa_iftrin/'
carr_ord='carrier_orders/'
iod='alfa_iod/'
tnt='TT_Status/'
car_stat_nor='carrier_status/'
car_stat_cip='../cip/status/'
cont_file=$base'count.txt'
#
#
#
. $tmp_root/count-list-func.sh
#
#set date
day=$(date +'%Y%m%d')
#echo $day
cd $base
#pwd
if [ -e $cont_file ]
	then
		rm -rf count.txt
fi
#sleep 1
touch count.txt
time=$(date +'%Y-%m-%d %H:%M:%S' | awk '{print $2}')
#echo $time
echo "DHL GF Order Count at $time" >> $cont_file
#Take Order Count
cd $iftmin
#pwd
if [ -d $day ]
	then
		cd $day
		#pwd
		orders=$(find . -type f | wc -l)
		echo "IFTMIN Count = " $orders >> $cont_file
	else
		orders=0
		echo "IFTMIN Count = " $orders >> $cont_file
fi
cd $base
#Take IFTRIN Count
cd $iftrin
#pwd
if [ -d $day ]
	then
		cd $day
		#pwd
		invoice=$(find . -type f | wc -l)
		echo "IFTRIN Count = " $invoice >> $cont_file
	else
		invoice=0
		echo "IFTRIN Count = " $invoice >> $cont_file
fi
cd $base
#Take carrier Order Count
cd $carr_ord
#pwd
if [ -d $day ]
	then
		cd $day
		#pwd
		carr_orders=$(find . -type f | wc -l)
		echo "Carrier IFTMIN(Order Count) = " $carr_orders >> $cont_file
	else
		carr_orders=0
		echo "Carrier IFTMIN(Order Count) = " $carr_orders >> $cont_file
fi
cd $base
#Take carrier Order Count
cd $iod
#pwd
if [ -d $day ]
        then
                cd $day
                #pwd
                alf_iod=$(find . -type f | wc -l)
                echo "ALFA IOD = " $alf_iod >> $cont_file
        else
                alf_iod=0
                echo "ALFA IOD = " $alf_iod >> $cont_file
fi
cd $base
#Take Track n Trace
cd $tnt
#pwd
if [ -d $day ]
        then
                cd $day
                #pwd
                t_n_t=$(find . -type f | wc -l)
                echo "Track & Trace = " $t_n_t >> $cont_file
        else
                t_n_t=0
                echo "Track & Trace = " $t_n_t >> $cont_file
fi
cd $base
#Take carrier status normal flow Count
cd $car_stat_nor
#pwd
if [ -d $day ]
        then
                cd $day
                #pwd
                car_status_normal=$(find . -type f | wc -l)
                echo "Carrier Status Normal = " $car_status_normal >> $cont_file
        else
                car_status_normal=0
                echo "Carrier Status Normal = " $car_status_normal >> $cont_file
fi
cd $base
#Take carrier status CIP flow Count
cd $car_stat_cip
#pwd
if [ -d $day ]
        then
                cd $day
                #pwd
                car_status_cip=$(find . -type f | wc -l)
                echo "Carrier Status CIP = " $car_status_cip >> $cont_file
        else
                car_status_cip=0
                echo "Carrier Status CIP = " $car_status_cip >> $cont_file
fi
#
#
echo "" >> $cont_file
echo "" >> $cont_file
echo "" >> $cont_file
echo "--- Message IDs are attached in the ZIP file ---" >> $cont_file
#############Call message ID generate functions
#
IftminOrders
IftrinInvoice
CarrierIftmin
IOD
#
zip -r MESSAGE-IDs.zip $tmp_root/iftmin-list.txt $tmp_root/iftrin-list.txt $tmp_root/carrier_iftmin.txt $tmp_root/iod.txt
#
sleep 5
#
chktimer=$(date +'%Y-%m-%d %H:%M')
#
#mutt -a "MESSAGE-IDs.zip" -s "DHL GF Message Count at $chktimer CET" -- cta.alfasupport@ebuilder.com cta.2ndline.int@ebuilder.com < $cont_file
mutt -a "MESSAGE-IDs.zip" -s "DHL GF Message Count at $chktimer CET" -- sagara.jayathilaka@ebuilder.com < $cont_file
#cat $cont_file
#mail -s "DHL GF Message Count at $chktimer CET" sagara.jayathilaka@ebuilder.com < $cont_file
#mail -s "DHL GF Message Count at $chktimer CET" cta.alfasupport@ebuilder.com cta.2ndline.int@ebuilder.com < $cont_file
sleep 2
rm -r MESSAGE-IDs.zip
