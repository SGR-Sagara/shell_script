#! /bin/sh
## DHL Counts
base='/home/sagara/bin/'
iftmin='alfa_orders/'
iftrin='alfa_iftrin/'
carr_ord='carrier_orders/'
cont_file=$base'count.txt'
#set date
day=$(date +%Y%m%d)
#echo $day

cd $base
#pwd

if [ -e $cont_file ]
	then
		rm -rf count.txt
fi

sleep 1

touch count.txt

time=$(date +'%Y-%m-%d %H-%m-%S' | awk '{print $2}')
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
		echo "Carrier IFTMIN(Order Count = )" $carr_orders >> $cont_file
	else
		carr_orders=0
		echo "Carrier IFTMIN(Order Count) = " $carr_orders >> $cont_file
fi

#cat $cont_file
cat $cont_file | mail -s "DHL GF Message Count" sagara.jayathilaka@ebuilder.com
