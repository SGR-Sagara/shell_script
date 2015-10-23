#!/bin/bash
####### Move Data to Archive Partition /data/archive from /data/comamexbta #######
############################################################
##01##/data/comamexbta/data/user/btareconciliation/sftp/eip/emea/backup			 		----> /data/archive/comamexbta/eip/emea/backup			
##02##/data/comamexbta/data/user/btareconciliation/sftp/eip/emea/bprocess			 	----> /data/archive/comamexbta/eip/emea/bprocess			
##03##/data/comamexbta/data/user/btareconciliation/sftp/eip/emea/bprocess/zip		 	----> /data/archive/comamexbta/eip/emea/bprocess/zip		
##04##/data/comamexbta/data/user/btareconciliation/sftp/customized/IMP2_NTC/backup 		----> /data/archive/comamexbta/customized/IMP2_NTC/backup
##############################################################################################################################################
# 
cd /data/comamexbta/data/user/btareconciliation/sftp/eip/emea/backup
mv $(find . -maxdepth 1 -mtime +1 -type f) /data/archive/comamexbta/eip/emea/backup
#
cd /data/comamexbta/data/user/btareconciliation/sftp/eip/emea/bprocess/zip
mv $(find . -maxdepth 1 -mtime +1 -type f) /data/archive/comamexbta/eip/emea/bprocess/zip
#
cd /data/comamexbta/data/user/btareconciliation/sftp/eip/emea/bprocess
mv $(find . -maxdepth 1 -mtime +1 -type f) /data/archive/comamexbta/eip/emea/bprocess
#
cd /data/comamexbta/data/user/btareconciliation/sftp/customized/IMP2_NTC/backup
mv $(find . -maxdepth 1 -mtime +1 -type f) /data/archive/comamexbta/customized/IMP2_NTC/backup
#