#! /bin/sh

if test "-?" = "$1" ; then
    echo " Program to export the config as an xml file. The file will be named after the date."
			
    exit	
fi


Today=`date +%y%m%d`
. /opt/phau/.profile

test -d ${CORE_DATA}/cfg_exports/ || mkdir ${CORE_DATA}/cfg_exports/
r4edi $CORE_ROOT/4edi/pgm/cfgtfr_export.x4 -o ${CORE_DATA}/cfg_exports/export_${Today}.xml
