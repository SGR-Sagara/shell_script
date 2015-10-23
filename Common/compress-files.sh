#! /bin/sh

PROJECT_HOME=/data_current/trafik/project_archive/24S_PROJECT_BACKUP
LOGFILE=$PROJECT_HOME/logs/archive_`date +%Y%m%d`.log

#Refere jira=IC-335, for more information.
#35 days to make sure /home/trafik/scripts/file_backup_sync.sh doesn't create empty folders
#FOLDERNAME=`date -d "-30 day" +'%Y%m%d'`

getTime () #assignes the current time date in to varibale
{
        TIMENOW=`date +'%Y%m%d:%H%M%S'`
}


ArchiveFolder () {

        DAYS_TOKEEP=$1
        PROJECT_FOLDER=$2
        FOLDERNAME=`date -d "-$DAYS_TOKEEP day" +'%Y%m%d'`
        #TARGETDIR=$PROJECT_HOME/project_archive

        getTime
        echo "$TIMENOW : Archiving started on $PROJECT_FOLDER " >> ${LOGFILE}

        test -d $PROJECT_HOME/$PROJECT_FOLDER/$FOLDERNAME
        if test $? -eq 0 ; then
                #zip -rmj $PROJECT_HOME/$PROJECT_FOLDER/$FOLDERNAME".zip" $PROJECT_HOME/$PROJECT_FOLDER/$FOLDERNAME
                cd $PROJECT_HOME/$PROJECT_FOLDER
                tar -czf $FOLDERNAME".tar.gz" $FOLDERNAME --remove-files
                find $FOLDERNAME -depth -type d -exec rmdir {} \;
        fi

        getTime
        echo "$TIMENOW : Archiving finished on $PROJECT_FOLDER  " >> ${LOGFILE}
}

# Archive VGR messages
ArchiveFolder 180 ebitg12_mxib/vgr/archive/exin_despatchadvice
ArchiveFolder 180 ebitg12_mxib/vgr/archive/exin_invoice
ArchiveFolder 180 ebitg12_mxib/vgr/archive/exin_orderresponse
ArchiveFolder 180 ebitg12_mxib/vgr/archive/exin_pricat
ArchiveFolder 180 ebitg12_mxib/vgr/archive/exin_shoppingcart
ArchiveFolder 180 ebitg12_mxib/vgr/archive/exin_svefaktura
ArchiveFolder 180 ebitg12_mxib/vgr/archive/exout_faxorders
ArchiveFolder 180 ebitg12_mxib/vgr/archive/exout_invoice
ArchiveFolder 180 ebitg12_mxib/vgr/archive/exout_orders
ArchiveFolder 180 ebitg12_mxib/vgr/archive/exout_sveorder
ArchiveFolder 180 ebitg12_mxib/vgr/archive/rdex_ankomst
ArchiveFolder 180 ebitg12_mxib/vgr/archive/rdex_attest
ArchiveFolder 180 ebitg12_mxib/vgr/archive/rdex_kundfaktura
ArchiveFolder 180 ebitg12_mxib/vgr/archive/rdex_makulering
ArchiveFolder 180 ebitg12_mxib/vgr/archive/rdin_authledger
ArchiveFolder 180 ebitg12_mxib/vgr/archive/rdin_kodplan
ArchiveFolder 180 ebitg12_mxib/vgr/archive/rdin_paydateskund
ArchiveFolder 180 ebitg12_mxib/vgr/archive/rdin_paydateslev
ArchiveFolder 180 ebitg12_mxib/vgr/archive/rdin_zipfiles
ArchiveFolder 180 ebitg12_mxib/vgr/archive/salja_despatchadvice
ArchiveFolder 180 ebitg12_mxib/vgr/archive/salja_invoice
ArchiveFolder 180 ebitg12_mxib/vgr/archive/salja_orderresponse
ArchiveFolder 180 ebitg12_mxib/vgr/archive/salja_orders
ArchiveFolder 180 ebitg12_mxib/vgr/archive/whin_despatchadvice
ArchiveFolder 180 ebitg12_mxib/vgr/archive/whin_ilev1
ArchiveFolder 180 ebitg12_mxib/vgr/archive/whin_ilev2
ArchiveFolder 180 ebitg12_mxib/vgr/archive/whin_orderresponse
ArchiveFolder 180 ebitg12_mxib/vgr/archive/whin_receiveadvice
ArchiveFolder 180 ebitg12_mxib/vgr/archive/whin_refillorders
ArchiveFolder 180 ebitg12_mxib/vgr/archive/whout_despatchadvice
ArchiveFolder 180 ebitg12_mxib/vgr/archive/whout_orderresponse
ArchiveFolder 180 ebitg12_mxib/vgr/archive/whout_receiveadvice

# Archive PA messages
ArchiveFolder 180 ebitg11_mxib/mi/dynamic_xib/INVOIC_Files_Processed
ArchiveFolder 180 ebitg11_mxib/mi/dynamic_xib/archive
ArchiveFolder 180 ebitg11_mxib/stromberg/bgc_invoice

# Archive ASA messages
ArchiveFolder 30 ebitg13_phnms2/asa/cu_request
ArchiveFolder 30 ebitg13_phnms2/asa/cu_response
ArchiveFolder 30 ebitg13_phnms3/asa/cu_request
ArchiveFolder 30 ebitg13_phnms3/asa/cu_response
ArchiveFolder 30 ebitg13_phnms/asa/cu_request
ArchiveFolder 30 ebitg13_phnms/asa/cu_response
ArchiveFolder 30 ebitg13_phnms/asa/carrier/DHLEX/status
ArchiveFolder 30 ebitg13_xib/asa/cu_request
ArchiveFolder 30 ebitg13_xib/asa/cu_response

ArchiveFolder 30 ebuvmritg081_phnms/asa/cu_request
ArchiveFolder 30 ebuvmritg081_phnms/asa/cu_response

# Archive Amex messages
ArchiveFolder 180 ebaxpdmz10_comamexbta/amexnordic/svefak_itella
ArchiveFolder 180 ebaxpdmz10_comamexbta/customer/xml_cexp/sftp
ArchiveFolder 180 ebaxpitg10_proamexbta/archive/cexp1
ArchiveFolder 180 ebaxpitg10_proamexbta/archive/exp1
ArchiveFolder 180 ebaxpitg10_proamexbta/archive/imp1
ArchiveFolder 180 ebaxpitg10_proamexbta/archive/imp2
ArchiveFolder 180 ebaxpitg10_proamexbta/archive/imp3
ArchiveFolder 180 ebaxpitg10_proamexbta/archive/imp4
ArchiveFolder 180 ebaxpitg10_proamexbta/archive/imp5

# Archive DHLAU messages
ArchiveFolder 30 ebuvmritg080_phau/dhlau/statusin/aupost

# Archvie TA messages
ArchiveFolder 90 ebuvmritg080_mexib/mecp_import/backup

ArchiveFolder 360 ebdmz11_etcomxib/bprocess/backup

# Archive OFA messages
ArchiveFolder 180 ebitg10_phxib/dhlgf/alfa_orders
ArchiveFolder 180 ebitg10_phxib/dhlgf/alfa_iftrin
ArchiveFolder 180 ebitg10_phxib/dhlgf/carrier_invoice
ArchiveFolder 180 ebitg10_phxib/dhlgf/carrier_orders
ArchiveFolder 180 ebitg10_phxib/dhlgf/carrier_status
ArchiveFolder 180 ebitg10_phxib/dhlgf/manual_status

exit 0

ebaxpdmz10 _comamexbta
EBAXPDMZ10