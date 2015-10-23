#!/bin/sh
#Check server uptime for a restart cycle
PATH='/opt/oracle/home/bin:/opt/phxib/xib/local/bin:/opt/phxib/xib/bin:/opt/s24/bin:/opt/s24/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/opt/phxib//bin:/bin'
ups=$(uptime | awk '{print $3}')
echo $ups

if [ $ups -gt 120 ]
	then
		rm uptime.txt
		sleep 2
		echo 'System Up time Alert!' >> uptime.txt
		server=$(uname -a | awk '{print $2}')
		echo 'Host : '$server >> uptime.txt
		echo 'Uptime : '$ups' days' >> uptime.txt
		ip=$(ifconfig | grep -A 4 eth | grep 'inet addr' | awk '{print $2}' | awk -F ':' '{print $2}')
		echo 'Internal IP : '$ip >> uptime.txt
		echo "This server is up for more than $ups days. Please plan for a restart to be in the safe side." >> uptime.txt
		mail -s 'System Up time Alert!' sagara.jayathilaka@ebuilder.com charitha.perera@ebuilder.com hemantha.dejoedth@ebuilder.com -c operations@ebuilder.com -c au.2ndline.int@ebuilder.com -c ravinda.abeysinghe@ebuilder.com -c rohan.ranawaka@ebuilder.com < uptime.txt
fi
