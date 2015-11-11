#!/bin/bash
###
##CIP-233 - Handling possible incomplete EIP file pickup
###
##1. Retrieve from EIP APA (SFTP) | /home/trafik/sgr/upload/ready
cd /home/trafik/sgr/upload/
APA=$(find . -maxdepth 1 -mmin +1 -type f)
CNT_APA=$(find . -maxdepth 1 -mmin +1 -type f | wc -l)
if [ $CNT_APA -gt 0 ]
then
pwd
mv $APA /home/trafik/sgr/upload/ready/
fi
##