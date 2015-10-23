cd
. .bash_profile

while test $# -gt 0
do
        case $1 in
                -U|-V|-X) set `echo $1 | tr UVX uvx` ;;
                -d) Debug=1 ;;
                -d?) Debug=$1 ;;
                -t) Test=1 ;;
                NoLogs) NoLogs=NoLogs ;;
                *) LogDay=$1 ;;
        esac
        shift
done

for i  in `r4edi st_pid.x4 -a $CORE_LOCAL/config/passwd -s $CORE_STARTER_PORT | awk '{print $1}' | grep 'TransAdaptTask'`
        do
               STATUS=`r4edi st_pstatus.x4 -a $CORE_LOCAL/config/passwd -s $CORE_STARTER_PORT $i`
                           if [ "$STATUS" = "Stopped" ] ; then
			   
                              r4edi st_pstart.x4 -a $CORE_LOCAL/config/passwd -s $CORE_STARTER_PORT $i                                
                              STATUS=`r4edi st_pstatus.x4 -a $CORE_LOCAL/config/passwd -s $CORE_STARTER_PORT $i`

                                if [ "$STATUS" = "Started" ] ; then
                                       echo "Process $i was stopped and restart was successfull" | mail -s "$1 Process is down at EBAXPDMZ10" customized.2ndline.int@ebuilder.com, antony.fernando@ebuilder.com
                                else
					echo "Process $i was stopped and restart was unsuccessfull" | mail -s "$1 Process is down at EBAXPDMZ10" customized.2ndline.int@ebuilder.com,antony.fernando@ebuilder.com
                                fi			   
                           fi
        done
