#!/bin/bash
#


SCRIPTNAME=$0
PID=$$

STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4

function usage () {
cat <<EOF

usage: $0 [ -h ] -H PORTAL_HOST

Available options:
      PORTAL_HOST         - the name/IP of Rev portal server
EOF
exit 1
}

while getopts "hH:" OPTION; do
  case "$OPTION" in
    h) usage ;;
    H) PORTAL_HOST=$OPTARG ;;
  esac
done

if [ -z "$PORTAL_HOST" ]; then
	usage
fi

URL="https://$PORTAL_HOST/syncstatus/sync_failed_job?appName=portal.revsw.net&&token=12345678"

TMP=`mktemp`

curl -k -s "$URL" > $TMP
ERROR_CODE=$?
json=`cat $TMP`

rm -f $TMP

if [ $ERROR_CODE -ne 0 ]; then
	echo "CRITICAL: Failed to fetch the status page, curl exit code $ERROR_CODE"	
	exit $STATE_CRITICAL
fi

FAILED_PROXY=`echo "$json" | jq '.response[]'|jq '.ip[]'`

if [ ! -z "$FAILED_PROXY" ]; then
	echo "CRITICAL: Configuration push failed for proxy servers $FAILED_PROXY"
	exit $STATE_CRITICAL
fi

echo "OK: All proxy servers are up to date"
exit $STATE_OK
