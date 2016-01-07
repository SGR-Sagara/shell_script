#!/bin/bash
## Invoice date set for fulltext invoice
cd /home/trafik/sgr/VGR-7179/WORK
pwd
lst=$(find . -type f)
#
fix='<\/date><parties>'
echo "FIX part : $fix"
std='2015-12-28'
echo "New Dat : $std"
echo "what to set : $std$fix"
#
for i in $lst
do
#
old_dt=$(egrep -o '.{10}</date><parties>' $i | cut -c 1-10 )
echo "Name : $i"
echo "Old set : $old_dt$fix"
echo "New set : $std$fix"
#sed -i 's/$old_dt$fix/$std$fix/g' $i
#
done
