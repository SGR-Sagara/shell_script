#! /bin/sh

# In this template, all occurances of <Must enter> must be edited.

Debug=
Test=
PGM=CheckUnArchived
PID_HOME=~

while test $# -gt 0
do
	case $1 in
		-U|-V|-X) set `echo $1 | tr UVX uvx` ;;	
		-a) ArchiveDays=$2 shift ;;
		-d) Debug=1 ;;
		-c) Clean=1 ;;
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

echo "

This program is used to check if there are any files remaining after archiving. You must enter one argument:

-a <Archiving Days>

The program will check if there are any logger files that are older than this date, plus three days, 
and if there is any filer files older than this date, plus thirty days. 
This to avoid removing files to early.
"

exit
}

CheckEnvVariables () {

if test "${ArchiveDays}" = "" ; then
    echo "
    
    The days that the archiving is set on must be entered as an argumant. Example:
    
    -a 90
    "
    exit
else
    ArchiveDaysPlusThirtyDays=`expr ${ArchiveDays} + 30`
    ArchiveDaysPlusThreeDays=`expr ${ArchiveDays} + 3`
fi

if test "$CORE_LOCAL" = "" ; then
    echo "
    
    You must have XIB environment variables to run this program.
    "
    exit
fi

CheckOldLoggerFiles
CheckOldFilerFiles
}

CheckUnArchived () {

test "$Debug" = 1 && set -x

}


#-------------------------------------------------------------------------------------------------------------------------------------------
CheckOldFilerFiles () {

test "$Debug" = 1 && set -x

if test `find ${CORE_DATA}/filer -type f -name 'f*' -ctime +${ArchiveDaysPlusThirtyDays} | wc -l | awk {' print $1 '}` = 0 ; then
    echo "No Filer entries older than ${ArchiveDaysPlusThirtyDays} days"
else
    echo "
    
    `find ${CORE_DATA}/filer -type f -name 'f*' -ctime +${ArchiveDaysPlusThirtyDays} | wc -l | awk {' print $1 '}` filer filesolder than ${ArchiveDaysPlusThirtyDays} days
    
    To be on the safe side, this program is set to clean out files in the filer directory older than archiving date plus 30 days. 
    To clean out, run this program again, with the argument -c (for 'clean')"
    
    if test "${Clean}" = 1 ; then
        if test -f $CORE_LOCAL/4edi/pgm/filerutil.x4 ; then
            $CORE_ROOT/bin/r4edi $CORE_LOCAL/4edi/pgm/filerutil.x4 -t ${ArchiveDaysPlusThirtyDays} -D
        else
            echo "
            
            filerutil.x4 not found. This program must be in:
            
            $CORE_LOCAL/4edi/pgm
            "            
        fi
    fi
fi
}

#-------------------------------------------------------------------------------------------------------------------------------------------
CheckLoggerDirectory () {

test "$Debug" = 1 && set -x

    test "$Trace" = 1 && ls -l ${CORE_DATA}/logger/${LoggerDirectory}/i*
    if test "`find ${CORE_DATA}/logger/${LoggerDirectory} -type f -name 'i*' -ctime +${ArchiveDaysPlusThreeDays}`" = "" ; then
        echo "No inactive Logger entries older than ${ArchiveDaysPlusThreeDays} days in ${CORE_DATA}/logger/${LoggerDirectory}"
    else
        find ${CORE_DATA}/logger/${LoggerDirectory} -type f -name 'i*' -ctime +${ArchiveDaysPlusThreeDays} 
    fi
}

#-------------------------------------------------------------------------------------------------------------------------------------------
CheckMultipleLoggerFiles () {

test "$Debug" = 1 && set -x

    while test $# -gt 0
    do
        LoggerDirectory=$1
        CheckLoggerDirectory ${LoggerDirectory}
        shift
    done
}


#-------------------------------------------------------------------------------------------------------------------------------------------
CheckOldLoggerFiles () {

test "$Debug" = 1 && set -x

LoggerDirectories=`ls -1 ${CORE_DATA}/logger/ `

test "$Trace" = 1 && echo LoggerDirectories = ${LoggerDirectories}

if test `echo "${LoggerDirectories}" | wc -w | awk {' print $1 '}` = 1 ; then
    LoggerDirectory=${LoggerDirectories}
    CheckLoggerDirectory ${LoggerDirectory}
else
    CheckMultipleLoggerFiles $LoggerDirectories 
fi


}

#==========================================================================================================================================
#
# Main
#
#==========================================================================================================================================

test -d ${PID_HOME} || mkdir ${PID_HOME}

if test -f ${PID_HOME}/${PGM}.pid ; then
    PGMPid=`cat ${PID_HOME}/${PGM}.pid`
    if test "`ps -p $PGMPid | grep $PGMPid | awk {' print $1 '}`" = "$PGMPid" ; then
        echo "${PGM}.sh already running"
        exit
    fi
fi
	
echo $$ > ${PID_HOME}/${PGM}.pid

if test "$USAGE" = "1" ; then 
    USAGE
else
    CheckEnvVariables
fi

test -f ${PID_HOME}/${PGM}.pid && rm ${PID_HOME}/${PGM}.pid
