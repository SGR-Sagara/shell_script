#!/bin/bash
##
## Detect Nordia Card Order request files an alert.
#
cd /data/projectbackup/mexib/qvoice/finnishstate/cardfile_requests/
pwd
#
tm=$(date +'%Y-%m-%d %H:%M:%S')
echo "Time Now: $tm"
tm1=$(date +'%H')
echo "Hour now: " $tm1
echo "Nordia Card Order request file check " > /opt/mexib/card_order_request_status.txt
echo "-------------------------------------" >> /opt/mexib/card_order_request_status.txt
echo "Checked at $tm " >> /opt/mexib/card_order_request_status.txt
#
if [ $tm1 -le 16 ]
then
echo "On or before 16CET"
cnt1=$(find . -mmin -960 -type f | wc -l)
echo "Value :" $cnt1
echo "Number of files found: $cnt1" >> /opt/mexib/card_order_request_status.txt
elif [ $tm1 -gt 16 ]
then
echo "After 16CET"
cnt1=$(find . -mmin -1080 -type f | wc -l)
echo "Value :" $cnt1
echo "Number of files found: $cnt1" >> /opt/mexib/card_order_request_status.txt
fi
#
if [ $cnt1 -ge 1 ]
then
echo "Order Request file detected"
echo "Order Request file detected - No Further action required from anyone." >> /opt/mexib/card_order_request_status.txt
#mail -s "Nordia Card Order Request detected from Application at $tm " sagara.jayathilaka@ebuilder.com < /opt/mexib/card_order_request_status.txt
mail -s "Nordia Card Order Request detected from Application at $tm " travel.2ndline.int@ebuilder.com,travel.2ndline@ebuilder.com < /opt/mexib/card_order_request_status.txt
else
echo "Order Request file NOT detected"
echo "Order Request file NOT detected - Please check the Travel Application for any queue issue.[See JIRA Nord-326]" >> /opt/mexib/card_order_request_status.txt
#mail -s "Nordia Card Order Request <<NOT DETECTED>> from Applicationat $tm" sagara.jayathilaka@ebuilder.com < /opt/mexib/card_order_request_status.txt
mail -s "Nordia Card Order Request <<NOT DETECTED>> from Applicationat $tm" travel.2ndline.int@ebuilder.com,travel.2ndline@ebuilder.com < /opt/mexib/card_order_request_status.txt
fi
#