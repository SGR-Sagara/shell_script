#!/bin/sh

Time=
Native=
lqlFile=
StartDate=
EndDate=
ARG=

while test $# -gt 0
do
        case $1 in
                -X) set `echo $1 | tr X x` ;;
                -d) set -x ;;
                -t) Test=1 ;;
                -f) lqlFile=1 ;;
                -l) LogId=$2 shift ;;
                -R) Time=$2 shift ;;
                -S) StartDate=$2 shift ;;
                -E) EndDate=$2 shift ;;
                -V) ShowVersion=1 ;;
                *) ARG=$1 ;;
        esac
        shift
done

ShowVersion () 	{

echo "reportprogram.sh Version 2.1"
exit
}

runReport () {

CurrentDirectory=`pwd`

if test -f ${CurrentDirectory}/.profile ; then
   if grep -q core_setup ${CurrentDirectory}/.profile ; then
      `grep core_setup ${CurrentDirectory}/.profile`
   fi
elif test -f  ${CurrentDirectory}/.bash_profile ; then
   if grep -q core_setup ${CurrentDirectory}/.bash_profile ; then
      `grep core_setup ${CurrentDirectory}/.bash_profile`
   fi
elif test `find / -name core_setup 2> /dev/null | wc -l | awk {'print $1'}` = 1 ; then
   . `find / -name core_setup 2> /dev/null`
fi

test "$CORE_LOCAL" = "" && exit 1

if test "$Time" != "" ; then
   TestTime="-R $Time"
elif test "$EndDate" != "" ; then
   if test  "$StartDate" != "" ; then
      TestTime="-S $StartDate -E $EndDate"
   else
      TestTime=
   fi
elif test "$StartDate" != "" ; then
   TestTime="-S $StartDate"
fi

if test "$lqlFile" = 1 ; then
   echo "f_Event_Severity=4|f_Event_Severity=5" > ${CORE_LOCAL}/bin/search.lql
   LQLFILE="-f ${CORE_LOCAL}/bin/search.lql"
else
   LQLFILE=
fi

if test "$LogId" != "" ; then
   LOGID="-l $LogId"
else
   LOGID=
fi

r4edi ${CORE_LOCAL}/4edi/pgm/rep.x4 $TestTime $LQLFILE $LOGID $ARG
}

#Main

if test "$ShowVersion" = 1 ; then
   ShowVersion
else
   runReport
fi