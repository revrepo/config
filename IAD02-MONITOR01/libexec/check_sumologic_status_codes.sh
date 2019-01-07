#!/bin/bash
#
# The script uses SumoLogic API to count the number of 5xx records for specified proxy
# server for the last 15 minutes
#

SCRIPTNAME=$0
PID=$$


API_USER="prashant@revsw.com"
API_PASS="Revsw1@34"
WARNING=8
CRITICAL=20

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
      -w WARNING_THRESHOLD      - Nagios warning threshold for number of 5xx errors during last 15 minutes (default value "$WARNING")
      -c CRITICAL_THRESHOLD     - Nagios critical threshold for number of 5xx errors during last 15 minutes (default value "$CRITICAL")
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

QUERY="_sourceHost%3D$PROXY.REVSW.NET%20%7C%20parse%20%22*%3A*%20*%20*%20*%20%5B*%5D%20%5C%22*%20*%20*%5C%22%20*%20*%20%5C%22*%5C%22%20%5C%22*%5C%22%22%20as%20domain%2Cport%2Cip%2Cthing1%2Cthing2%2Cdatestring%2Cmethod%2Cthing3%2Chttp_version%2Cresponse_code%2Csize%2Cthing4%2Cuser_agent%20%7C%20where%20response_code%20%3E%3D500%20%7C%20count"

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
	COUNT=0
	echo "OK: $COUNT requests with 5xx status code are detected for the last 15 minutes|5xxErrors=$COUNT;;;"
	exit $STATE_OK
fi

if [ $COUNT -ge $CRITICAL ]; then
	echo "CRITICAL: $COUNT requests with 5xx status code are detected for the last 15 minutes|5xxErrors=$COUNT;;;"
	exit $STATE_CRITICAL
fi

if [ $COUNT -ge $WARNING ]; then
	echo "WARNING: $COUNT requests with 5xx status code are detected for the last 15 minutes|5xxErrors=$COUNT;;;"
	exit $STATE_WARNING
fi

echo "OK: $COUNT requests with 5xx status code are detected for the last 15 minutes|5xxErrors=$COUNT;;;"
exit $STATE_OK
