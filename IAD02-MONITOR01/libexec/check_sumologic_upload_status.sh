#!/bin/bash
#
# The script communicates with SumoLogic API and checks the number of uploaded records for specified proxy
# server for the last 15 minutes
#

SCRIPTNAME=$0
PID=$$


API_USER="prashant@revsw.com"
API_PASS="Revsw1@34"
WARNING=7
CRITICAL=12

STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4

function usage () {
cat <<EOF

usage: $0 [ -h ] -p PROXY_NAME [ -w WARNING_THRESHOLD ] [ -c CRITICAL_THRESHOLD ]

Available options:
      -d PROXY_NAME		- the short (not FQDN) name of BP proxy server to check
      -w WARNING_THRESHOLD      - Nagios warning threshold for number of records collected during last 15 minutes (default value "$WARNING")
      -c CRITICAL_THRESHOLD     - Nagios critical threshold for number of records collected during last 15 minutes (default value "$CRITICAL")
EOF
exit 1
}

while getopts "hd:w:c:" OPTION; do
  case "$OPTION" in
    h) usage ;;
    d) PROXY=$OPTARG ;;
    w) WARNING=$OPTARG ;;
    c) CRITICAL=$OPTARG ;;
  esac
done

if [ -z "$PROXY" ]; then
	usage
	exit $STATE_UNKNOWN
fi

QUERY="_sourceHost%3D$PROXY.REVSW.NET%7Ccount"

TMP=`mktemp`

curl --fail -s -u $API_USER:$API_PASS "https://api.sumologic.com/api/v1/logs/search?q=$QUERY" > $TMP

EXIT_CODE=$?

COUNT=`cat $TMP | grep _count | awk '{print $3}'`

rm -f $TMP

if [ $EXIT_CODE != 0 ]; then
	echo "UNKNOWN: Failed to fetch the data from SumeLogic, curl exit code $EXIT_CODE"
	exit $STATE_UNKNOWN
fi

if [ -z "$COUNT" ]; then
	echo "CRITICAL: Failed to read the number of uploaded records"
	exit $STATE_CRITICAL
fi

if [ $COUNT -le $CRITICAL ]; then
	echo "CRITICAL: Only $COUNT records are detected for the last 15 minutes|AccessRecords=$COUNT;;;"
	exit $STATE_CRITICAL
fi

if [ $COUNT -le $WARNING ]; then
	echo "WARNING: Only $COUNT records are detected for the last 15 minutes|AccessRecords=$COUNT;;;"
	exit $STATE_WARNING
fi

echo "OK: $COUNT records are detected for the last 15 minutes|AccessRecords=$COUNT;;;"
exit $STATE_OK
