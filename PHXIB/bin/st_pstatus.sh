#!/bin/sh

. /opt/phau/xib/local/bin/core_setup

exec < ${CORE_LOCAL}/bin/ProcessList

        while read LINE
        do
           ServiceName=`echo $LINE | sed -n 's/^\([A-Z][A-Za-z0-9_]*\) .*$/\1/p'`
           echo "$ServiceName    \c"
           $CORE_ROOT/bin/r4edi st_pstatus.x4 -a $CORE_LOCAL/config/passwd -s $CORE_STARTER_PORT $ServiceName
        done

