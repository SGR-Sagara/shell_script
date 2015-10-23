#! /bin/sh

Debug=
Test=
PWD=`pwd`
PGM=CheckUncomitted

while test $# -gt 0
do
	case $1 in
		-U|-V|-X) set `echo $1 | tr UVX uvx` ;;	
		-d) Debug=1 ;;
		-t) Test=1 ;;
		-T) Trace=1 ;;
		-c) CleanUp=1 ;;
		-?) USAGE=1 ;;
		*) Dataset=$1 ;;
	esac
	shift
done

test "$Dataset" = "" && USAGE=1

USAGE () {

echo "

This program is used to check which users that has uncommitted transactions.
It is necessary when installing patches to remove these before installation.

When you get the message that one dataset has uncommitted transactions, run this program with the dataset as an argument.

Note! The dataset must be given as an argument!

Example:

Dataset Initial has uncomitted transactions. Run:

CheckUncomitted.sh Initial 

The result will show which user that has uncomitted transactions:


configset = Initial.18

UserName = Sven Olander
User = sven



To clean up this configset, run:

CheckUncomitted.sh Initial -c

Note! All configsets will be cleaned!
"

exit
}

CleanUp () {

UserId=$1

if test -f $CORE_LOCAL/config/cfgserver/configset/${Dataset}.${UserId}/* ; then
    rm $CORE_LOCAL/config/cfgserver/configset/${Dataset}.${UserId}/*
fi
}

CheckUncomitted () {

test "$Debug" = 1 && set -x

# First, find out which users dataset that has uncommitted transactions.

cd $CORE_LOCAL/config/cfgserver/configset
ls -1d ${Dataset}.* |

while read LINE 

do
    ls -l $LINE |
    
    if grep -vq "total 0" ; then
       echo
       echo configset = $LINE
       echo

       UserId=`echo $LINE | sed -n "s/${Dataset}\.\(.*\)/\1/p"`
       test "$Trace" = 1 && echo UserId = ${UserId}

#      Example of user line:
#      DATA : 18={18,0,"Sven Olander","sven","ly.gj5VNo7oFg","",2,4,{},{}}

       eval `r4edi cfgdump.x4 $CORE_LOCAL/config/cfgserver/configset/System/User |
       grep ${UserId}= |
       sed -n "s/.*${UserId}={${UserId},[0-9]*,\"\([A-Za-zÅÄÖåäö][A-Za-zÅÄÖåäö ]*\)\",\"\([A-Za-zÅÄÖåäö][A-Za-zÅÄÖåäö ]*\)\",.*/UserName='\1' User=\2/p"`
       
       echo UserName = "$UserName"
       echo User     = "$User"
       echo
       
       if test "${CleanUp}" = 1 ; then
           CleanUp ${UserId}
       fi
    fi
done

}

#==========================================================================================================================================
#
# Main
#
#==========================================================================================================================================

if test -f ${PWD}/${PGM}.pid ; then
    PGMPid=`cat ${PWD}/${PGM}.pid`
    if test "`ps -p $PGMPid | grep $PGMPid | awk {' print $1 '}`" = "$PGMPid" ; then
        echo "${PGM}.sh already running"
        exit
    fi
fi
	
echo $$ > ${PWD}/${PGM}.pid

if test "$USAGE" = "1" ; then 
    USAGE
else
    CheckUncomitted
fi

test -f ${PWD}/${PGM}.pid && rm ${PWD}/${PGM}.pid
