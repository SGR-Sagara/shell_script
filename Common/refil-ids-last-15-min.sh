#!/bin/bash
##REfill list during last 15 miniues
#
base="/data/mxib/data/projectbackup/mxib/vgr/archive/whin_refillorders/"
#
today=$(date +"%Y%m%d")
#echo $today
#
#echo $base$today"/"
cd $base$today"/"
#pwd
#
lst=$(find . -amin -15 -type f)
#echo $lst
#
rm /data/mxib/data/projectbackup/mxib/vgr/archive/refill-ids-last15min.txt
touch /data/mxib/data/projectbackup/mxib/vgr/archive/refill-ids-last15min.txt
#
for i in $lst
do
egrep -o "<RefillOrderNumber>.{15}" $i | awk -F ">" '{print $2}' | awk -F "<" '{print $1}' >> /data/mxib/data/projectbackup/mxib/vgr/archive/refill-ids-last15min.txt
done
