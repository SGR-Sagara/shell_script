#!/bin/bash
### Cognos export check ###
#
rm ~/cognos_report.txt
touch ~/cognos_report.txt
tim=$(date +"%Y-%m-%d %H:%M:%S")
dy=$(date +"%Y%m%d")
#dy='20150710'
cd /data/mxib2/data/archive/cognos_export/
#
echo "Cognos file checked at $tim" > ~/cognos_report.txt
echo " " >> ~/cognos_report.txt
#
if [ -e ./$dy ]
then
cd ./$dy
fil_cnt=$(find . -type f | wc -l )
fil_tim=$(stat $(find . -type f | head -1) | grep 'Modify' | cut -c 8-27)
#
echo "Cognos file count : " $fil_cnt >> ~/cognos_report.txt
echo " " >> ~/cognos_report.txt
echo "Cognos file received time : " $fil_tim >> ~/cognos_report.txt
title="<<SUCCESS>> - LIV - Cognos export check on $dy"
else
title="<<FAILURE>> - LIV - No Cognos file on $dy"
echo "NO Cognos for today" >> ~/cognos_report.txt
echo " " >> ~/cognos_report.txt
echo "<<< PLEASE INVESTIGATE >>>" >> ~/cognos_report.txt
fi
#
#mail -s "$title" sagara.jayathilaka@ebuilder.com < ~/cognos_report.txt
mail -s "$title" procurement.2ndline@ebuilder.com procurement.2ndline.int@ebuilder.com < ~/cognos_report.txt