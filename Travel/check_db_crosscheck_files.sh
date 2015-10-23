#!/bin/bash
#
cd /data/mexib/data/mecp_import/dbcheckerfiles/in/
count=$(find . -cmin +720 -type f | wc -l)
#count=$(find . -cmin +20 -type f | wc -l)
if [ $count -ge 1 ]
then
echo "Unprocessed DB cross check files in the Pickup location" > /data/mexib/data/mecp_import/dbcheckerfiles/unprocessed.txt
echo "Number of files: " $count >> /data/mexib/data/mecp_import/dbcheckerfiles/unprocessed.txt
echo "File List:" >> /data/mexib/data/mecp_import/dbcheckerfiles/unprocessed.txt
find . -cmin -720 -type f >> /data/mexib/data/mecp_import/dbcheckerfiles/unprocessed.txt
mail -s "Unprocessed DB cross check files in the Pickup location" travel.2ndline.int@ebuilder.com travel.2ndline@ebuilder.com < /data/mexib/data/mecp_import/dbcheckerfiles/unprocessed.txt
#mail -s "Unprocessed DB cross check files in the Pickup location" Sagara.Jayathilaka@ebuilder.com < /data/mexib/data/mecp_import/dbcheckerfiles/unprocessed.txt
fi
 
