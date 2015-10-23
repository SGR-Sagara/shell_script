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
hst=$(uname -n)
downlist=$(r4edi st_pid.x4 -a $CORE_LOCAL/config/passwd -s $CORE_STARTER_PORT | awk '{print $1}')
for i  in $downlist
        do
               STATUS=`r4edi st_pstatus.x4 -a $CORE_LOCAL/config/passwd -s $CORE_STARTER_PORT $i`
                           if [ "$STATUS" = "Stopped" ] ; 
                                                   then
                                                                echo "Process $(r4edi st_pstatus.x4 -a $CORE_LOCAL/config/passwd -s $CORE_STARTER_PORT $(r4edi st_pid.x4 -a $CORE_LOCAL/config/passwd -s $CORE_STARTER_PORT | awk '{print $1}') | grep 'Stopped') was/were stopped !!!" | mail -s "$1 Process is down at $hst" customized.2ndline.int@ebuilder.com,sampath.withanage@ebuilder.com,antony.fernando@ebuilder.com
                                                                exit
                           fi
        done
