#!/bin/bash
###### Detect SFTP log size and resent ########
cd /data/etcomxib/data/log
#row_cnt1=$(cat sftp.log | wc -l)
row_cnt1=$(cat sftp.log | wc -l)
#
dt=$(date +'%Y%m%d')
dt1=$(date +'%Y%m%d %H:%M:%S')
hst=$(uname -n)
#
if [ $row_cnt1 -gt 38000000 ]
then
mv sftp.log sftp.log_$dt
touch sftp.log
zip sftp.log_$dt.zip sftp.log_$dt
sleep 10
rm sftp.log_$dt
mail -s "$hst - $USER - SFTP log file too big - SFTP log [sftp.log] reset at $dt1 " customized.2ndline.int@ebuilder.com
#mail -s "$hst - $USER - SFTP log file too big - SFTP log [sftp.log] reset at $dt1 " Sagara.Jayathilaka@ebuilder.com
fi
#
#
