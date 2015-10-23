#! /bin/sh

Debug=
Test=
PGM=CleanUpZeroByteFiles
PGM_HOME=`pwd`
. ~/.profile

while test $# -gt 0
do
	case $1 in
		-U|-V|-X) set `echo $1 | tr UVX uvx` ;;	
		-d) Debug=1 ;;
		-d*) Debug=`echo $1 | sed -n 's/\-d\(.*\)/\1/p'` ;;
		-t) Test=1 ;;
		-T) Trace=1 ;;
		-T*) Trace=`echo $1 | sed -n 's/\-T\(.*\)/\1/p'` ;;
		-?) USAGE=1 ;;
		*) Argument=$1 ;;
	esac
	shift
done

USAGE () {

clear

echo "This program is designed to remove zero byte files older than one day from some XIB folders. It is cleaning only in:

$CORE_ROOT
$CORE_DATA
$CORE_LOCAL
$CORE_DATA/tmp

The program can be used with some options:

-X	This will turn on "set -x", and all command lines will be displayed to prompt.
-d	debug. It will use "set -x" in the folders that has a statement for this.
-t	trace. Can be used in the code to echo the value of some variables (might not be used).
"

exit
}

#------------------------------------------------------------------------------------------------------------------------------------------
#
#------------------------------------------------------------------------------------------------------------------------------------------
CleanUpZeroByteFiles () {

test "$Debug" = 1 && set -x
echo Folder = `pwd`

if test -f ${PGM_HOME}/Files.lst ; then
    chmod 777 ${PGM_HOME}/Files.lst
    rm -f ${PGM_HOME}/Files.lst
fi

if test `pwd` = ${CORE_DATA}/tmp ; then
    find . -type f -mtime +7 > ${PGM_HOME}/Files.lst
else
    find . -type f -size 0c -mtime +1 > ${PGM_HOME}/Files.lst
fi

chmod 777 ${PGM_HOME}/Files.lst

if [ -f ${PGM_HOME}/Files.lst ] ; then 
    
    exec < ${PGM_HOME}/Files.lst 
    
    while read LINE 
        do
            echo $LINE | 
            EmptyFile=`sed -n 's/^.\/\([a-zA-Z0-9_][a-zA-Z0-9\._-]*\)$/\1/p'`
            
            if [ $EmptyFile ] ; then 
                if test "$Test" = 1 ; then 
                    ls -l $EmptyFile
                else
                    ls -l $EmptyFile
                    rm -f $EmptyFile
                fi
            fi
        done
fi

if test "$Trace" = 1 ; then 
    cat ${PGM_HOME}/Files.lst
fi

[ -f ${PGM_HOME}/Files.lst ] && rm ${PGM_HOME}/Files.lst

EXIT=0

}

#------------------------------------------------------------------------------------------------------------------------------------------
#
#------------------------------------------------------------------------------------------------------------------------------------------
DefineFolders () {

test "$Debug" = 1 && set -x

if [ $CORE_ROOT ] ; then
    cd $CORE_ROOT
    if test $CORE_ROOT = $(pwd) ; then 
        CleanUpZeroByteFiles
    fi
else
    echo "
    
    CORE_ROOT is not defined.
    
    "
    exit
fi

if [ $CORE_LOCAL ] ; then
    cd $CORE_LOCAL
    if test $CORE_LOCAL = $(pwd) ; then 
        CleanUpZeroByteFiles
    fi
else
    echo "
    
    CORE_LOCAL is not defined.
    
    "
    exit
fi

if [ $CORE_DATA ] ; then
    cd $CORE_DATA
    if test $CORE_DATA = $(pwd) ; then 
        CleanUpZeroByteFiles
    fi
    cd $CORE_DATA/tmp
    if test $CORE_DATA/tmp = $(pwd) ; then 
        CleanUpZeroByteFiles
    fi
else
    echo "
    
    CORE_DATA is not defined.
    
    "
    exit
fi

#if [ -d /tmp ] ; then
#    cd /tmp
#    CleanUpZeroByteFiles
#fi


EXIT=0

}

#==========================================================================================================================================
#
# Main
#
#==========================================================================================================================================

if test -f ${PGM_HOME}/${PGM}.pid ; then
    PGMPid=`cat ${PGM_HOME}/${PGM}.pid`
    if test "`ps -p $PGMPid | grep $PGMPid | awk {' print $1 '}`" = "$PGMPid" ; then
        echo "${PGM}.sh already running"
        exit
    else
        chmod 777 ${PGM_HOME}/${PGM}.pid
    fi
fi
	
echo $$ > ${PGM_HOME}/${PGM}.pid

if test "$USAGE" = "1" ; then 
    USAGE
else
    DefineFolders
fi

test -f ${PGM_HOME}/${PGM}.pid && rm ${PGM_HOME}/${PGM}.pid
