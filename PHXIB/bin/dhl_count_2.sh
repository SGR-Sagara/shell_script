#! /bin/sh
## DHL Counts
#base='/home/sagara/bin/'
base='/data/phxib/data/projectbackup/phxib/dhlgf/'
iftmin='alfa_orders/'
iftrin='alfa_iftrin/'
ccarr_ord='carrier_orders/'
ccont_file=$base'count_c.txt'
#set date
cday=$(date +'%Y%m%d')
#echo $cday

cd $base
#pwd

if [ -e $ccont_file ]
	then
		rm -rf count_c.txt
fi

#sleep 1

touch count_c.txt

ctime=$(date +'%Y-%m-%d %H:%M:%S' | awk '{print $2}')
#echo $time
cd $base
#Take carrier Order Count
cd $ccarr_ord
#pwd
if [ -d $cday ]
	then
		cd $cday
		#pwd
		ccarr_orders=$(find . -type f | wc -l)
		echo "Carrier IFTMIN(Carrier Order Count) = " $ccarr_orders >> $ccont_file
	else
		ccarr_orders=0
		echo "Carrier IFTMIN(Carrier Order Count) = " $ccarr_orders >> $ccont_file
fi

#cat $ccont_file
#mail -s "DHL GF Carrier IFTMIN Count at $ctime CET" sagara.jayathilaka@ebuilder.com < $ccont_file
mail -s "DHL GF Carrier IFTMIN Count at $ctime CET" cta.alfasupport@ebuilder.com cta.2ndline.int@ebuilder.com < $ccont_file
