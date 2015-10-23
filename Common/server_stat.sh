#!/bin/bash
#Author : Integration Support
cd /opt/mexib/server_stats
total_mem=$(free | grep 'Mem:' | awk '{print $2}')
used_mem=$(free | grep 'buffers/cache:' | awk '{print $3}')
free_mem=$(free | grep 'buffers/cache:' | awk '{print $4}')

total_swap=$(free | grep 'Swap:' | awk '{print $2}')
used_swap=$(free | grep 'Swap:' | awk '{print $3}')
free_swap=$(free | grep 'Swap:' | awk '{print $4}')

buffer_mem=$(free | grep 'Mem:' | awk '{print $6}')
cached_mem=$(free | grep 'Mem:' | awk '{print $7}')


load_avg=$(cat /proc/loadavg | awk '{print $1}' )


time_wait_tcp_con=$(netstat | grep 'tcp' |grep 'TIME_WAIT' | wc -l)
total_tcp_connections=$(netstat | grep 'tcp' | wc -l)
close_wait_tcp_cont=$(netstat | grep 'tcp' | grep "CLOSE_WAIT" | wc -l)



echo `date +%F' '%T` ",""," total_mem "," $total_mem ",""," used_mem "," $used_mem ",""," free_mem "," $free_mem ",""," total_swap "," $total_swap ",""," used_swap "," $used_swap ",""," load_avg "," $load_avg ",""," time wait connections "," $time_wait_tcp_con ",""," total tcp connections "," $total_tcp_connections  ",""," close wait connections "," $close_wait_tcp_cont >> server_status.log


