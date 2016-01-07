#!/bin/bash
### Move PERS and ANST Files (SCANIA-202)(CIP-246)
cd /data/projectbackup/mexib/mecp_import/backup/ftp_original/
###
## select the PERS files received during past week.
##
LOG='/opt/mexib/scania_pers_anstlog.txt'
echo "SCANIA Organization Import related PERS and ANST set !!!" > $LOG
echo "========================================================" >> $LOG
prs=8
echo $prs
while [ $prs -ge 0 ]
do
timstamp=$(date +"%Y-%m-%d %H:%M:%S")
dy=$(date --date="$prs day ago" +"%Y%m%d")
echo "Selected date : " $dy
echo "File name to search : pers_scania_$dy"
fil=$(find . -name "pers_scania_$dy*")
echo "fil : " $fil
fil_cnt=$(find . -name "pers_scania_$dy*" | wc -l)
echo "fil_cnt : " $fil_cnt
if [ $fil_cnt -eq 1 ]
then
new_fil_nm=$(echo "$fil" | awk -F '/' '{print $3}' | awk -F '_' '{print $1"_"$2"_"$3}')
echo "New File NAme : " $new_fil_nm
cp "$fil" /data/mexib/data/ftp/mecp_import/in/$new_fil_nm
echo "PERS File $fil set to import at $timstamp CET		$'\r'" >> $LOG
fi
#
prs=$(expr $prs - 1 )
sleep 180
#
done
#
########################
echo "========================================================" >> $LOG
ans=8
echo $ans
while [ $ans -ge 0 ]
do
timstamp1=$(date +"%Y-%m-%d %H:%M:%S")
dy1=$(date --date="$ans day ago" +"%Y%m%d")
echo "Selected date : " $dy1
echo "File name to search : anst_scania_$dy1"
fil1=$(find . -name "anst_scania_$dy1*")
echo "fil1 : " $fil1
fil_cnt1=$(find . -name "anst_scania_$dy1*" | wc -l)
echo "fil_cnt1 : " $fil_cnt1
if [ $fil_cnt1 -eq 1 ]
then
new_fil_nm1=$(echo "$fil1" | awk -F '/' '{print $3}' | awk -F '_' '{print $1"_"$2"_"$3}')
echo "New File NAme : " $new_fil_nm1
cp "$fil1" /data/mexib/data/ftp/mecp_import/in/$new_fil_nm1
echo "ANST File $fil1 set to import at $timstamp1 CET	$'\r'" >> $LOG
fi
#
ans=$(expr $ans - 1 )
sleep 180
#
done
########################
timstamp2=$(date +"%Y-%m-%d %H:%M:%S")
mail -s "PERS and ANST set to import at $timstamp2 CET " travel.2ndline@ebuilder.com,travel.2ndline.int@ebuilder.com,anna.soderbarj@ebuilder.com < $LOG
#mail -s "PERS and ANST set to import at $timstamp2 CET " sagara.jayathilaka@ebuilder.com < $LOG