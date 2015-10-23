#!/bin/sh

cat server_status.log  > server_status_daily.csv

mutt -s "MEXIB server stats on `date +%F`" -a server_status_daily.csv lahiru.bulathsinhala@ebuilder.lk </dev/null

#/bin/mail -s "MEXIB server stats on `date +%F`" lahiru.bulathsinhala@ebuilder.lk < server_status_daily.log

mv server_status.log /opt/mexib/server_stats/stat_logs/server_status.csv_`date +%Y.%m.%d-%H.%M:%S`
