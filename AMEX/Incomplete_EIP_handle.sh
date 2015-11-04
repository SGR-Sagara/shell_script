#!/bin/bash
###
##CIP-233 - Handling possible incomplete EIP file pickup
###
##1. Retrieve from EIP APA (SFTP) | $CORE_DATA/user/btareconciliation/sftp/eip/apa/upload/ready
cd $CORE_DATA/user/btareconciliation/sftp/eip/apa/upload/
APA=$(find . -maxdepth 1 -mmin +15 -type f)
mv $APA $CORE_DATA/user/btareconciliation/sftp/eip/apa/upload/ready/
##
##2. Retrieve from EIP EMEA (SFTP) | $CORE_DATA/user/btareconciliation/sftp/eip/emea/upload/ready
cd $CORE_DATA/user/btareconciliation/sftp/eip/emea/upload/
EMEA=$(find . -maxdepth 1 -mmin +15 -type f)
mv $EMEA $CORE_DATA/user/btareconciliation/sftp/eip/emea/upload/ready
##
##3. Retrieve from EIP LAC (SFTP) | $CORE_DATA/user/btareconciliation/sftp/eip/lac/upload/ready
cd $CORE_DATA/user/btareconciliation/sftp/eip/lac/upload/
LAC=$(find . -maxdepth 1 -mmin +15 -type f)
mv $LAC $CORE_DATA/user/btareconciliation/sftp/eip/lac/upload/ready
##