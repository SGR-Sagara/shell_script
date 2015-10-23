#! /bin/sh

CUR_TIME_DATE=
LOG_FILE_NAME=FILE_`date +%Y_%m_%d`.log
LOCALARCPATH=/data_current/trafik/project_archive/24S_PROJECT_BACKUP
#LOCALARCPATH=/data_current/project_archive/24S_PROJECT_BACKUP
LOGFILE=$LOCALARCPATH/logs/$LOG_FILE_NAME
debug=
TARGETHOST=
TARGETUSER=

setTimeDate () #assignes the current time date in to varibale
{
        CURR_TIME_DATE=`date`

}


SyncWithProd () {

        TARGETHOST=$1
        TARGETUSER=$2
        TARGETDIR=$TARGETHOST"_"$TARGETUSER
        setTimeDate
        echo "$CURR_TIME_DATE : file arc syncronization  started from $TARGETHOST  $TARGETUSER " >> ${LOGFILE}

        rsync -arv $TARGETUSER@$TARGETHOST:/data/projectbackup/$TARGETUSER/ $LOCALARCPATH/$TARGETDIR
        if test $? -eq 0 ; then
                ssh $TARGETUSER@$TARGETHOST "find /data/projectbackup/$TARGETUSER -type f -mtime +15 -exec rm -f {} \;"
               #changed from 30 to 15, 2013/03/05
        fi
        setTimeDate
        echo "$CURR_TIME_DATE : file arc syncronization  ended from $TARGETHOST  $TARGETUSER " >> ${LOGFILE}
}

SyncWithProdCustom () {

        TARGETHOST=$1
        TARGETUSER=$2
        REMTARGETPATH=$3
        #LOCTARGETPATH=$4
        TARGETDIR=$TARGETHOST"_"$TARGETUSER
    setTimeDate
        echo "$CURR_TIME_DATE : file arc syncronization  started from $TARGETHOST  $TARGETUSER " >> ${LOGFILE}

        rsync -arv $TARGETUSER@$TARGETHOST:$REMTARGETPATH/$TARGETUSER/ $LOCALARCPATH/$TARGETDIR
        if test $? -eq 0 ; then
                ssh $TARGETUSER@$TARGETHOST "find $REMTARGETPATH/$TARGETUSER -type f -mtime +30 -exec rm -f {} \;"
        fi
        setTimeDate
        echo "$CURR_TIME_DATE : file arc syncronization  ended from $TARGETHOST  $TARGETUSER " >> ${LOGFILE}
}

SyncWithAmexProd () {

        TARGETHOST=$1
        TARGETUSER=$2
        setTimeDate
        echo "$CURR_TIME_DATE : file arc syncronization  started from $TARGETHOST  $TARGETUSER " >> ${LOGFILE}

        rsync -arv $TARGETUSER@$TARGETHOST:/data/comamexbta/data/user/btareconciliation/ $LOCALARCPATH/$TARGETUSER
        if test $? -eq 0 ; then
                ssh $TARGETUSER@$TARGETHOST "find /data/comamexbta/data/user/btareconciliation -type f -mtime +30 -exec rm -f {} \;"
        fi
        setTimeDate
        echo "$CURR_TIME_DATE : file arc syncronization  ended from $TARGETHOST  $TARGETUSER " >> ${LOGFILE}
}


### Archieve MXIB2 Data###################
SyncWithProdCustomMXIB2 () {

        TARGETHOST=$1
        TARGETUSER=$2
        REMTARGETPATH=$3
        #LOCTARGETPATH=$4
        TARGETDIR=$TARGETHOST"_"$TARGETUSER
    setTimeDate
        echo "$CURR_TIME_DATE : file arc syncronization  started from $TARGETHOST  $TARGETUSER " >> ${LOGFILE}

        rsync -arv $TARGETUSER@$TARGETHOST:$REMTARGETPATH/ $LOCALARCPATH/$TARGETDIR
        if test $? -eq 0 ; then
                ssh $TARGETUSER@$TARGETHOST "find $REMTARGETPATH/ -type f -mtime +90 -exec rm -f {} \;"
        fi
        setTimeDate
        echo "$CURR_TIME_DATE : file arc syncronization  ended from $TARGETHOST  $TARGETUSER " >> ${LOGFILE}
}

test -d $LOCALARCPATH/logs ||  mkdir -p $LOCALARCPATH/logs/
test -d $LOCALARCPATH/$TARGETUSER || mkdir -p $LOCALARCPATH/$TARGETUSER

SyncWithProd ebitg10 xib 
SyncWithProd ebitg10 phxib 
SyncWithProd ebitg10 mexib 
SyncWithProd ebitg10 mxib 
SyncWithProd ebitg10 phnms

#2012/12/04 disabled, 2012/12/11 enabled back
SyncWithProd ebitg11 amexib
SyncWithProd ebitg11 mxib

#2012/11/29 disabled, 2013/01/07 enabled back
SyncWithProd ebitg12 mxib

SyncWithProd ebitg13 phnms
SyncWithProd ebitg13 phnms2
SyncWithProd ebitg13 phnms3
SyncWithProd ebitg13 xib
SyncWithProd ebuvmritg080 phau
SyncWithProd ebuvmritg080 mexib
SyncWithProd ebuvmritg081 phnms

#2012/11/29 disabled, jira=IC-335, 2013/05/09 enabled back
#SyncWithProdCustom ebdmz11 etcomxib /data/etcomxib/data/ftp/bprocess/backup/ bprocess/backup
#SyncWithProdCustom ebdmz11 etcomxib /dataarchive/projectbackup/etcomxib/bprocess/backup bprocess/backup
SyncWithProdCustom ebdmz11 etcomxib /dataarchive/projectbackup
SyncWithProdCustom ebaxpdmz10 comamexbta /data/archive
SyncWithProdCustom ebaxpdmz10 comamexbta /data/comamexbta
SyncWithProdCustom ebaxpitg10 proamexbta /data/backup
SyncWithProdCustomMXIB2 ebitg12 mxib2 /data/mxib2/data/archive/


exit 0
