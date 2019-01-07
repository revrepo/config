#!/bin/bash

export CDS_URL="https://iad02-cds01.revsw.net:9000"
export CDS_KEY=kh3i45y98yfksdfkasgfjhgssrq35sf

# Don't change the status of the following servers - they should be always in pending state
PROXY_SERVERS_TO_INGORE=('SYD02-BP02', 'LGA02-BP03', 'MOW02-BP01', 'KNA02-BP01', 'JNB02-BP01', 'IAD02-BP01', 'HKG02-BP01', 'HKG02-BP02', 'BOM02-BP01', 'MAA02-BP01', 'SAO02-BP02', 'LON02-BP01', 'IAD02-BP05' )


TMP=`mktemp`

function jsonval {
    temp=`echo $json | sed 's/\\\\\//\//g' | sed 's/[{}]//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | sed 's/\"\:\"/\|/g' | sed 's/[\,]/ /g' | sed 's/\"//g' | grep -w $prop`
    echo ${temp##*|}
}

function change_proxy_status() {
	if [ -z "$1" ]; then
		log_message CRITICAL "Missing proxy name parameter (without the .REVSW.NET domain name) for function change_proxy_status"
		exit 1
	fi
	PROXY=$1.REVSW.NET
	STATUS=$2
	if [ -z "$STATUS" ]; then
		log_message CRITICAL "Missing proxy status parameter (online/offline/pending) for function change_proxy_status"
		exit 1
	fi
	# Get the server's current status and don't change it if it is "offline"
	log_message INFO "Verifying that server $PROXY in is not in offline state"
        curl -s --header "Content-Type:application/json" -H "Authorization: Bearer $CDS_KEY" $CDS_URL/v1/proxy_servers/byname/$PROXY 2>&1 > $TMP
        EXIT_CODE=$?
        if [ $EXIT_CODE -ne 0 ]; then
                log_message ERROR "Received curl exit code $EXIT_CODE while trying to get the current status for proxy server $PROXY. Please see curl output in file $TMP"
                exit 1
        fi
        if [ -z "`grep \\"status\\": $TMP`" ]; then
                log_message ERROR "It looks like server $HOST does not exist in the CDS database, please check Nagios configuration"
                exit 0
        fi
        if [ ! -z "`grep \\"status\\":\\"offline\\" $TMP`" ]; then
                log_message WARNING "Server $HOST is in offline state, skipping server status change"
                exit 0
        fi

	log_message INFO "Trying to set status $STATUS for proxy $PROXY"
	curl -s --header "Content-Type:application/json" -X PUT -H "Authorization: Bearer $CDS_KEY" -d "{ \"status\": \"$STATUS\" }" $CDS_URL/v1/proxy_servers/byname/$PROXY 2>&1 > $TMP
	EXIT_CODE=$?
	if [ $EXIT_CODE -ne 0 ]; then	
		log_message ERROR "Received curl exit code $EXIT_CODE while trying to update status for proxy server $PROXY. Please see curl output in file $TMP"
		exit 1
	fi
	if [ -z "`grep \\"status\\":\\"$STATUS\\" $TMP`" ]; then
		log_message ERROR "Failed to confirm the status change in curl output while trying to update proxy server $PROXY. Please see curl output in file $TMP"
		exit 1
	fi
	log_message INFO "Completed setting status $STATUS for server $PROXY"
}

# $SERVICESTATE$ $SERVICESTATETYPE$ $SERVICEATTEMPT$ $HOSTADDRESS$ $ARG1$

SERVICESTATE=$1
SERVICESTATETYPE=$2
HOST=$3

SCRIPTNAME=$0
PID=$$

function log_message () {
        SEVERITY=$1
        MESSAGE=$2

        echo `date` "$SCRIPTNAME[$PID]: $SERERITY $MESSAGE"
        logger -t "$SCRIPTNAME[$PID]" "$MESSAGE"
}

log_message INFO "Started for host $HOST, SERVICESTATE=$SERVICESTATE, SERVIVCESTATETYPE=$SERVICESTATETYPE"

#if [ "$SERVICESTATE" != "CRITICAL" -o "$SERVICESTATETYPE" != "HARD" ]; then
#        exit 
#fi

if [[ ${PROXY_SERVERS_TO_INGORE[*]} =~ $HOST ]]; then
    log_message INFO "Ignoring request for host $HOST since it is in the ignore list"
    exit 0
fi

case $SERVICESTATE in 
	OK)
		change_proxy_status $HOST online
		;;

	WARNING)
		log_message INFO "WARNING state for proxy $HOST: doing nothing"
		# do nothing
		;;
	CRITICAL)
		change_proxy_status $HOST pending
		;;
	* )
		log_message ERROR "Received unknown SERVERSTATE value $SERVICESTATE for host $HOST"
		exit 1
		;;
esac

exit 0

