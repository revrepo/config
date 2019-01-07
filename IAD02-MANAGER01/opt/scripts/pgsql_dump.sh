#!/bin/bash

#
# This simple script dumps the content of all local PGSQL databases to 
# a timestamped sub-directory in directory "/var/pgsql_backups/"
#


umask 0077


SCRIPTNAME=$0
PID=$$

function log_message () {
        SEVERITY=$1
        MESSAGE=$2

        echo `date` "$SCRIPTNAME[$PID]: $SERERITY $MESSAGE"
        logger -t "$SCRIPTNAME[$PID]" $MESSAGE
}

DUMP=`which pg_dumpall`

if [ ! -x "$DUMP" ]; then
        log_message CRITICAL "pg_dumpall binary cannot be found on the server"
        exit 1
fi


DIR="/var/pgsql_backups/`date +%Y%m%d-%H%M%S`"

mkdir -p $DIR

if [ $? -ne 0 ]; then
        log_message CRITICAL "Failed to create work directory $DIR"
        exit 1  
fi

cd $DIR

if [ $? -ne 0 ]; then
        log_message CRITICAL "Failed to CWD to $DIR"
        exit 1
fi

$DUMP  --clean > pgsql_dump.sql

ERRORCODE=$?

if [ $ERRORCODE -ne 0 ]; then
        log_message ERROR "$DUMP returned non-zero error code ($ERRORCODE) - please investigate"
        exit 1
fi

exit 0
