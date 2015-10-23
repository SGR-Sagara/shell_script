#!/bin/bash
#
#BASE_LOC='/dataarchive/projectbackup/etcomxib/stromberg' 
BASE_LOC='/home/trafik/data_current/project_archive/24S_PROJECT_BACKUP/ebdmz11_etcomxib/stromberg'
DATA_FULL=$BASE_LOC/stromberg-report-full.txt
DATA_LESS=$BASE_LOC/stromberg-report-less.txt
DISTINCT=$BASE_LOC/stromberg-report-distinct.txt
FINAL_REPORT=$BASE_LOC/stromberg-report-final.txt
DATA_ZIP=$BASE_LOC/stromberg-report-final.zip
FLD_PREF='edi_'
#
> $DATA_FULL
> $DATA_LESS
> $DISTINCT
> $FINAL_REPORT
> $DATA_ZIP
#
#
# 1. Find all the EDI files received previous day
MONTH=$(date --date='1 day ago' +"%Y%m")
#MONTH='20141230'
echo "Month of the year : $MONTH"
cd $BASE_LOC
LST=$(find ./$FLD_PREF*/$MONTH* -type f)
# 2. Write SENDER, RECEIVER, DATE and INVOICE ID to a file
for i in $LST
do
SND=$(egrep -o "UNB.{70}" $i | awk -F '+' '{print $3}' | awk -F ':' '{print $1}')
RCV=$(egrep -o "UNB.{70}" $i | awk -F '+' '{print $4}' | awk -F ':' '{print $1}')
DAY=$(egrep -o "UNB.{70}" $i | awk -F '+' '{print $5}' | awk -F ':' '{print $1}')
ID=$(egrep -o "BGM.{40}" $i | awk -F '+' '{print $3}' | awk -F "'" '{print $1}')
echo $DAY "--" $SND "--" $RCV "--" $ID >> $DATA_FULL
echo $SND "-" $RCV >> $DATA_LESS
done
# 3. Sort the file by date
sort $DATA_LESS | uniq > $DISTINCT
#
# 4. Read Distinct records and count
#
tim=$(date +"%Y-%m-%d %H:%M:%S")
mon=$(date +"%Y-%B")
echo "Stromberg Invoice Report for $mon" >> $FINAL_REPORT
echo "" >> $FINAL_REPORT
echo "Report Generated at $tim" >> $FINAL_REPORT
echo "" >> $FINAL_REPORT
echo "Supplier - Buyer - Number of Invoices" >> $FINAL_REPORT
#
while read LINE
do
#
echo "$LINE"
cnt=$(grep "$LINE" $DATA_LESS | wc -l)
echo "$cnt"
echo "$LINE -- $cnt"
echo "$LINE - $cnt" >> $FINAL_REPORT
#
done < $DISTINCT
#
# 5. ZIP files
#zip $DATA_ZIP $DATA_FULL
#
# 6. Email to support
#mail -s "STROMBERG Report for $MONTH" sagara.jayathilaka@ebuilder.com < $FINAL_REPORT
mail -s "STROMBERG Report for $MONTH" procurement.2ndline.int@ebuilder.com < $FINAL_REPORT
#