#!/bin/bash
#
# The script communicates with ElasticSearch API and checks the number of requests with 5xx status code for specified proxy
# server for the last 5 minutes
#

SCRIPTNAME=$0
PID=$$


INDEX_NAME="logstash-`date +%Y.%m.%d`"

API_URL="http://iad02-es11.revsw.net:9200/$INDEX_NAME/_search?&search_type=count&pretty=true"

WARNING=3
CRITICAL=8
STATUS_CODE='[500 TO 599]'

STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4

function usage () {
cat <<EOF

usage: $0 [ -h ] -d PROXY_NAME [ -w WARNING_THRESHOLD ] [ -c CRITICAL_THRESHOLD ] [ -s STATUS_CODE ]

Available options:
      -d PROXY_NAME		- the short (not FQDN) name of BP proxy server to check
      -w WARNING_THRESHOLD      - Nagios warning threshold for number of 5xx hits during last 5 minutes (default value "$WARNING")
      -c CRITICAL_THRESHOLD     - Nagios critical threshold for number of 5xx hits during last 5 minutes (default value "$CRITICAL")
      -s STATUS_CODE		- Specific status code (lile 502) to monitor (by default monitor all 5xx codes)
EOF
exit 1
}

while getopts "hd:w:c:s:" OPTION; do
  case "$OPTION" in
    h) usage ;;
    d) PROXY=$OPTARG ;;
    w) WARNING=$OPTARG ;;
    c) CRITICAL=$OPTARG ;;
    s) STATUS_CODE=$OPTARG ;;
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
                    "query": "host:\"%PROXY_NAME%\" AND NOT domain:\"%PROXY_NAME%\" AND response:%STATUS_CODE%"
                }
            },
            "filter": {
                "range": {
                    "@timestamp": {
                        "gte": "now-5m",
                        "lte": "now"
                    }
                }
            }
        }
    }
}'

QUERY2=`echo $QUERY | sed s/\%PROXY_NAME\%/$PROXY.REVSW.NET/g | sed s/\%STATUS_CODE\%/"$STATUS_CODE"/g`

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
	echo "CRITICAL: Failed to read the number of $STATUS_CODE records"
	exit $STATE_CRITICAL
fi

if [ $COUNT -ge $CRITICAL ]; then
	echo "CRITICAL: $COUNT $STATUS_CODE hits are detected for the last 5 minutes|${STATUS_CODE}Records=$COUNT;;;"
	exit $STATE_CRITICAL
fi

if [ $COUNT -ge $WARNING ]; then
	echo "WARNING: $COUNT $STATUS_CODE hits are detected for the last 5 minutes|${STATUS_CODE}Records=$COUNT;;;"
	exit $STATE_WARNING
fi

echo "OK: $COUNT $STATUS_CODE hits are detected for the last 5 minutes|${STATUS_CODE}Records=$COUNT;;;"
exit $STATE_OK
