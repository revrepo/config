#!/bin/bash
#
# The script communicates with ElasticSearch API and checks the number of unparsed records 
# (records with word "_grokparsefailure" in"tags" field
#

SCRIPTNAME=$0
PID=$$


API_URL='http://iad02-es01.revsw.net:9200/_search?&search_type=count&pretty=true'
WARNING=1
CRITICAL=3

STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4

function usage () {
cat <<EOF

usage: $0 [ -h ] [ -w WARNING_THRESHOLD ] [ -c CRITICAL_THRESHOLD ]

Available options:
      -w WARNING_THRESHOLD      - Nagios warning threshold for number of unparsed records inserted during last 5 minutes (default value "$WARNING")
      -c CRITICAL_THRESHOLD     - Nagios critical threshold for number of unparsed records inserted during last 5 minutes (default value "$CRITICAL")
EOF
exit 1
}

while getopts "hw:c:" OPTION; do
  case "$OPTION" in
    h) usage ;;
    w) WARNING=$OPTARG ;;
    c) CRITICAL=$OPTARG ;;
  esac
done


QUERY='{
    "query": {
        "filtered": {
            "query": {
                "query_string": {
                    "query": "tags=\"_grokparsefailure\""
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

TMP=`mktemp`

curl --fail -s -XGET $API_URL -d "$QUERY"  > $TMP

EXIT_CODE=$?

COUNT=`cat $TMP | grep -A1 hits | grep total | awk '{print $3}' |cut -f1 -d,`

rm -f $TMP

if [ $EXIT_CODE != 0 ]; then
	echo "UNKNOWN: Failed to fetch the data from ElasticSearch API, curl exit code $EXIT_CODE"
	exit $STATE_UNKNOWN
fi

if [ $COUNT -ge $CRITICAL ]; then
	echo "CRITICAL: $COUNT unparsed records are detected for the last 5 minutes|UnparsedRecords=$COUNT;;;"
	exit $STATE_CRITICAL
fi

if [ $COUNT -ge $WARNING ]; then
	echo "WARNING: $COUNT unparsed records are detected for the last 5 minutes|UnparsedRecords=$COUNT;;;"
	exit $STATE_WARNING
fi

echo "OK: $COUNT unparsed records are detected for the last 5 minutes|UnparsedRecords=$COUNT;;;"
exit $STATE_OK
