#!/bin/bash
###
##CIP-233 - Handling possible incomplete EIP file pickup
###
##1. Retrieve from EIP APA (SFTP) | /data/comamexbta/data/user/btareconciliation/sftp/eip/apa/upload/ready
cd /data/comamexbta/data/user/btareconciliation/sftp/eip/apa/upload/
APA=$(find . -maxdepth 1 -mmin +15 -type f)
CNT_APA=$(find . -maxdepth 1 -mmin +15 -type f | wc -l)
if [ $CNT_APA -gt 0 ]
then
mv $APA /data/comamexbta/data/user/btareconciliation/sftp/eip/apa/upload/ready/
fi
CNT_APA_CNT=$(find . -maxdepth 1 -mmin +30 -type f | wc -l)
##
##2. Retrieve from EIP EMEA (SFTP) | /data/comamexbta/data/user/btareconciliation/sftp/eip/emea/upload/ready
cd /data/comamexbta/data/user/btareconciliation/sftp/eip/emea/upload/
EMEA=$(find . -maxdepth 1 -mmin +15 -type f)
CNT_EMEA=$(find . -maxdepth 1 -mmin +15 -type f | wc -l)
if [ $CNT_EMEA -gt 0 ]
then
mv $EMEA /data/comamexbta/data/user/btareconciliation/sftp/eip/emea/upload/ready
fi
CNT_EMEA_CNT=$(find . -maxdepth 1 -mmin +30 -type f | wc -l)
##
##3. Retrieve from EIP LAC (SFTP) | /data/comamexbta/data/user/btareconciliation/sftp/eip/lac/upload/ready
cd /data/comamexbta/data/user/btareconciliation/sftp/eip/lac/upload/
LAC=$(find . -maxdepth 1 -mmin +15 -type f)
CNT_LAC=$(find . -maxdepth 1 -mmin +15 -type f | wc -l)
if [ $CNT_LAC -gt 0 ]
then
mv $LAC /data/comamexbta/data/user/btareconciliation/sftp/eip/lac/upload/ready
fi
CNT_LAC_CNT=$(find . -maxdepth 1 -mmin +30 -type f | wc -l)
##
TOT=`expr $CNT_APA_CNT + $CNT_EMEA_CNT + $CNT_LAC_CNT`
if [ $TOT -gt 0 ]
then
mail -s "Unprocessed AMEX EIP file in pickup location" customized.2ndline.int@ebuilder.com
fi