#!/bin/bash


# $SERVICESTATE$ $SERVICESTATETYPE$ $SERVICEATTEMPT$ $HOSTADDRESS$ $ARG1$

SERVICESTATE=$1
SERVICESTATETYPE=$2
CHECKATTEMPT=$3

SCRIPTNAME=$0
PID=$$

function log_message () {
        SEVERITY=$1
        MESSAGE=$2

        echo `date` "$SCRIPTNAME[$PID]: $SERERITY $MESSAGE"
        logger -t "$SCRIPTNAME[$PID]" $MESSAGE
}

log_message INFO "Received parameters: $SERVICESTATE, $SERVICESTATETYPE, $CHECKATTEMPT"

if [ "$SERVICESTATE" != "CRITICAL" -o $CHECKATTEMPT -ne 1 ]; then
	exit 
fi

log_message INFO "Restarting CDS service on IAD02-CDS01"
/usr/local/nagios/libexec/check_nrpe -t 20 -H IAD02-CDS01 -c restart_cds_service 

mailx -s "Restarted the CDS service" ops@revsw.com < /dev/null


