#! /bin/sh

test "$1" = -d && set -x

. $CORE_LOCAL/bin/core_setup

echo "Shutting down the Monitor server" 
r4edi st_pstop.x4 -a $CORE_LOCAL/config/passwd -s $CORE_SYSSTARTER_PORT SystemManagerTask
sleep 2
echo "Starting the Monitor server" 
r4edi st_pstart.x4 -a $CORE_LOCAL/config/passwd -s $CORE_SYSSTARTER_PORT SystemManagerTask

