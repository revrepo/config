#!/bin/bash


# $SERVICESTATE$ $SERVICESTATETYPE$ $SERVICEATTEMPT$ $HOSTADDRESS$ $ARG1$

SERVICESTATE=$1
SERVICESTATETYPE=$2

SCRIPTNAME=$0
PID=$$

function log_message () {
        SEVERITY=$1
        MESSAGE=$2

        echo `date` "$SCRIPTNAME[$PID]: $SERERITY $MESSAGE"
        logger -t "$SCRIPTNAME[$PID]" $MESSAGE
}

if [ "$SERVICESTATE" != "CRITICAL" -o "$SERVICESTATETYPE" != "HARD" ]; then
	exit 
fi

log_message INFO "Restarting CUBE service on IAD02-CUBE02"
/usr/local/nagios/libexec/check_nrpe -t 20 -H IAD02-CUBE02 -c restart_cube_service 

log_message INFO "Restarting CUBE service on IAD02-CUBE03"
/usr/local/nagios/libexec/check_nrpe -t 20 -H IAD02-CUBE03 -c restart_cube_service 

