#!/bin/bash
. ~/.bash_profile
#
### Weekend check list automation
# Task list
# 1. Remove ".core" files
# 2. Remove files older than 8 days from "tmp" folder
# 3. Run "checkUnArchived" script - check if there are any logger files that are older than this date, plus three days. If available archive (-a) and Clean (-c)
#####################################
cd ~/
bs=$(pwd)
WE_LOG="$bs/week_end_checklist.txt"
OUT_LOG="$bs/week_end_checklist_out.txt"
rm $WE_LOG
rm $OUT_LOG
touch $WE_LOG
touch $OUT_LOG
tim=$(date +'%Y-%m-%d %H:%M:%S')
echo "Week end check list for $USER XIB - Carried out at $tim CET" > $WE_LOG
echo "Week end check list for $USER XIB - Carried out at $tim CET" > $OUT_LOG
echo "------------------------------------------------------" >> $WE_LOG
#
# 1. Remover ".core" files
cd ~/xib
#echo pwd
cnt1=$(find . -maxdepth 1 -name "core.[0-9]*" | wc -l)
#echo "$cnt1"
if [ $cnt1 -ge 1 ]
then
#echo "core. found"
echo "-----Task 1-----" >> $OUT_LOG
find . -maxdepth 1 -name "core.[0-9]*" >> $OUT_LOG
lst1=$(find . -maxdepth 1 -name "core.[0-9]*")
#loc1=$(pwd)
#echo "$loc1 --- $lst1" >> $WE_LOG
rm $lst1
fi
#
echo "-----Task 1-----" >> $WE_LOG
echo "Removed [core.] files : $cnt1" >> $WE_LOG
echo "----------------" >> $WE_LOG
#
# 2. Remove files older than 8 days from "tmp" folder
cd /data/$USER/data/tmp
cnt2=$(find . -mtime +7 -type f | wc -l)
#echo "------ $cnt2" >> $WE_LOG
if [ $cnt2 -ge 1 ]
then
echo "-----Task 2-----" >> $OUT_LOG
find . -mtime +7 -type f >> $OUT_LOG
lst2=$(find . -mtime +7 -type f)
#loc2=$(pwd)
#echo "$loc2 --- $lst2" >> $WE_LOG
rm $lst2
fi
echo "-----Task 2-----" >> $WE_LOG
echo "Removed files older than 8 days from CORE_DATA/tmp folder : $cnt2" >> $WE_LOG
echo "----------------" >> $WE_LOG
#
# 3. Run "checkUnArchived" script
echo "-----Task 3-----" >> $OUT_LOG
cd /opt/$USER/xib/local/bin
./CheckUnArchived.sh -a 90 -c >> $OUT_LOG
#loc3=$(pwd)
#echo "$loc3 " >> $WE_LOG
echo "-----Task 3-----" >> $WE_LOG
echo "Archived and cleaned logger files older that 120 days" >> $WE_LOG
echo "----------------" >> $WE_LOG
echo "##########################################################" >> $WE_LOG
echo "Please proceed with the XIB RE-START !!!" >> $WE_LOG
#
#
mail -s "Weekend Check List for $USER at $tim" sagara.jayathilaka@ebuilder.com < $WE_LOG
#