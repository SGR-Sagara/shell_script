#!/bin/bash
###
##CIP-233 - Handling possible incomplete EIP file pickup
###
##1. Retrieve from EIP APA (SFTP) | $CORE_DATA/user/btareconciliation/sftp/eip/apa/upload/ready
cd $CORE_DATA/user/btareconciliation/sftp/eip/apa/upload/
APA=$(find . -maxdepth 1 -mmin +15 -type f)
CNT_APA=$(find . -maxdepth 1 -mmin +15 -type f | wc -l)
if [ $CNT_APA -gt 0 ]
then
mv $APA $CORE_DATA/user/btareconciliation/sftp/eip/apa/upload/ready/
fi
##
##2. Retrieve from EIP EMEA (SFTP) | $CORE_DATA/user/btareconciliation/sftp/eip/emea/upload/ready
cd $CORE_DATA/user/btareconciliation/sftp/eip/emea/upload/
EMEA=$(find . -maxdepth 1 -mmin +15 -type f)
CNT_EMEA=$(find . -maxdepth 1 -mmin +15 -type f | wc -l)
if [ $CNT_EMEA -gt 0 ]
then
mv $EMEA $CORE_DATA/user/btareconciliation/sftp/eip/emea/upload/ready
fi
##
##3. Retrieve from EIP LAC (SFTP) | $CORE_DATA/user/btareconciliation/sftp/eip/lac/upload/ready
cd $CORE_DATA/user/btareconciliation/sftp/eip/lac/upload/
LAC=$(find . -maxdepth 1 -mmin +15 -type f)
CNT_LAC=$(find . -maxdepth 1 -mmin +15 -type f | wc -l)
if [ $CNT_LAC -gt 0 ]
then
mv $LAC $CORE_DATA/user/btareconciliation/sftp/eip/lac/upload/ready
fi
##