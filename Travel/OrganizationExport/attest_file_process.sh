#!/bin/bash
### move the attest scania file to pickup location (SCANIA-202)(CIP-246)
##
cd /data/mexib/data/ftp/mecp_import/
pwd
timstamp=$(data +"%Y-%m-%d %H:%M:%S")
echo "Time stamp" $timstamp
dy=$(date --date="1 day ago" +"%Y%m%d")
echo "Day: " $dy
att_file='attest_scania_'$dy
echo "Attest file name : " $att_file
##
rm Diff-Attest-scania.txt*
##
if [ -e $att_file ]
then
echo "Attest file found"
####### Generate DIFF file########
echo "####### Generate DIFF file########"
diff -iBwa /data/mexib/data/mecp_import/reference/attest_scania $att_file | grep '>' | awk -F '>' '{print $2}' > Diff-Attest-scania.txt
##
sleep 20
##
cat Diff-Attest-scania.txt
echo "Start Zipping"
zip -9 Diff-Attest-scania.txt.zip Diff-Attest-scania.txt
##
sleep 10
##
cp $att_file /data/mexib/data/ftp/mecp_import/in/
mutt -a "Diff-Attest-scania.txt.zip" -s "SCANIA OrganisationExport SUCCESS - Attest file $att_file set to process at $timstamp CET " -- travel.2ndline@ebuilder.com,travel.2ndline.int@ebuilder.com,anna.soderbarj@ebuilder.com
#mutt -a "Diff-Attest-scania.txt.zip" -s "SCANIA OrganisationExport SUCCESS - Attest file $att_file set to process at $timstamp CET " -- sagara.jayathilaka@ebuilder.com
else
mail -s "SCANIA OrganisationExport FAILURE- NO ATTEST file($att_file) to process at $timstamp CET " travel.2ndline.int@ebuilder.com
#mail -s "SCANIA OrganisationExport FAILURE- NO ATTEST file($att_file) to process at $timstamp CET " sagara.jayathilaka@ebuilder.com
fi