#!/bin/bash
#set -x

ROOT=/data/mexib/data/mecp_import/dbcheckerfiles
INFILE=$ROOT/in
OUTFILE=$ROOT/out
LOG=$ROOT/log
FILETOMOVE=""


mkdir -p $LOG

FILETOMOVE=`find $INFILE -type f -mmin +120 | head -1` 
if [ "$FILETOMOVE" = "" ]
then
{
	echo ""
}
else
{ 
	mv "$FILETOMOVE" $OUTFILE/
	if [ "$?" -eq "0" ]
	then
	
		  echo "File $FILETOMOVE moved to $OUTFILE/" >> $LOG/dbchecker_file_move.log
	fi
}
fi

exit 0
