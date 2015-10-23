#!/bin/bash
##Email Alert for the IFTMIN Orders

#Check Out file - /home/trafik/scripts/iftmin.txt
#Remove OLD file 
if [ -e /home/trafik/scripts/iftmin.txt ]
then
   rm /home/trafik/scripts/iftmin.txt
fi

sleep 1

ssh logview@10.26.13.10

sleep 1

cd /app/ftproot/uaexib/alfaftp/live/FromPH/IFTSTA/work

cnt=$(find . -type f -mmin +2)

if [ $cnt -gt 0 ]
then
   find . -type f -mmin +2 >> /home/logview/iftmin.txt
   sleep 1
   scp /home/logview/iftmin.txt trafik@10.26.16.50:/home/trafik/scripts/iftmin.txt
   sleep 1
fi

exit

if [ -e /home/trafik/scripts/iftmin.txt ]
then
mail -s "IFTMIN Not Processed" sagara.jayathilaka@ebuilder.com < /home/trafik/scripts/iftmin.txt
fi