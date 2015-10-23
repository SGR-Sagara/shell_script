#!/bin/sh
## Detect 100% CPU utilizations and alert
#
max_cpu=$(ps -eo pcpu,pid,user,args | sort -k 1 -r | head -2 | tail -1 | awk '{printf "%.0f\n", $1}')
#echo $max_cpu
#check the CPU > 100% 
if [ $max_cpu -ge 100 ]
then
##proceed if CPU % is over 100%
#  echo "CPU is less than 100% for IF CONDITION"

rm cpuinf.txt
sleep 2
echo 'CPU Utilization MAXIMUM ALERT !' >> cpuinf.txt
echo '-------------------------------' >> cpuinf.txt
echo '%CPU PID USER    COMMAND  	Timestamp' >> cpuinf.txt
##Check 5 times with 2 minutes delay
i=1
#echo $i
while [ $i -le 5 ]
do
cpuinfo=$(ps -eo pcpu,pid,user,comm | sort -k 1 -r | head -2 | tail -1)
#echo $cpuinfo
cpus=$(echo $cpuinfo | awk '{printf "%.0f\n", $1}')
pids=$(echo $cpuinfo | awk '{printf "%.0f\n", $2}')
#echo 'CPU : '$cpus
#echo 'PID : '$pids
###################################
if [ $cpus -lt 100 ]
then
i=5
#echo $i
#echo "CPU % less thatn 100"
break
else
#echo $i
i=$(expr $i + 1)
#echo "CPU % higher than 100"
echo $cpuinfo" at " $(date '+%Y-%m-%d %H:%M:%S') >> cpuinf.txt
fi
###################################
sleep 120
done
echo '-------------------------------' >> cpuinf.txt
echo 'CPU is in maximum utilization for long time. This may not be an issue. If you you get the same alert twice within 30 minutes please verify the issues.' >> cpuinf.txt
echo 'Host : '$(uname -n) >> cpuinf.txt
sleep 2
#mail -s 'CPU utilization alert !!!' sagara.jayathilaka@ebuilder.com charitha.perera@ebuilder.com hemantha.dejoedth@ebuilder.com -c operations@ebuilder.com -c ravinda.abeysinghe@ebuilder.com -c rohan.ranawaka@ebuilder.com < cpuinf.txt
fi