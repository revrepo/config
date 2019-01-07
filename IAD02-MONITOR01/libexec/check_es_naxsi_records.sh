#!/bin/bash
#
# The script communicates with ElasticSearch API and checks the number of uploaded records for specified proxy
# server for the last 5 minutes
#

SCRIPTNAME=$0
PID=$$

INDEX_NAME="naxsi-`date +%Y.%m.%d`"

API_URL="http://iad02-es08.revsw.net:9200/$INDEX_NAME/_search?&search_type=count&pretty=true"

WARNING=7
CRITICAL=12

STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4

function usage () {
cat <<EOF

usage: $0 [ -h ] -d PROXY_NAME [ -w WARNING_THRESHOLD ] [ -c CRITICAL_THRESHOLD ]

Available options:
      -d PROXY_NAME		- the short (not FQDN) name of BP proxy server to check
      -w WARNING_THRESHOLD      - Nagios warning threshold for number of records collected during last 5 minutes (default value "$WARNING")
      -c CRITICAL_THRESHOLD     - Nagios critical threshold for number of records collected during last 5 minutes (default value "$CRITICAL")
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

QUERY='{
    "query": {
        "filtered": {
            "query": {
                "query_string": {
                    "query": "proxy_name=\"%PROXY_NAME%\""
                }
            },
            "filter": {
                "range": {
                    "date": {
                        "gte": "now-15m",
                        "lte": "now"
                    }
                }
            }
        }
    }
}'

QUERY2=`echo $QUERY | sed s/\%PROXY_NAME\%/$PROXY/g`

TMP=`mktemp`

curl --fail -s -XGET $API_URL -d "$QUERY2"  > $TMP

EXIT_CODE=$?

COUNT=`cat $TMP | grep -A1 hits | grep total | awk '{print $3}' |cut -f1 -d,`

rm -f $TMP

if [ $EXIT_CODE != 0 ]; then
	echo "UNKNOWN: Failed to fetch the data from ElasticSearch API, curl exit code $EXIT_CODE"
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
