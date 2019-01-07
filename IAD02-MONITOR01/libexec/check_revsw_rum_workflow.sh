#!/bin/bash
#
# This script is used to monitor the whole RUM and CUBE workflow - please see the following page for more details:
#   https://revwiki.atlassian.net/wiki/display/OP/Nagios+Monitoring+for+RUM+and+CUBE+Workflow
#


SCRIPTNAME=$0
PID=$$

CUBE_DOMAIN="rum_workflow_test.revdn.net"
CUBE_HOST="cube-02-prod-sjc.revsw.net"
CUBE_PORT=1081
STOP_TIME=`date +%Y-%m-%dT%H:%M:%S.460Z`
START_TIME=`date +%Y-%m-%dT%H:%M:%S.460Z -d "10 minutes ago"`
WARNING=6
CRITICAL=5


STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4

function log_message () {
        SEVERITY=$1
        MESSAGE=$2
#         echo `date` "$SCRIPTNAME[$PID]: $SERERITY $MESSAGE"
        logger -t "$SCRIPTNAME[$PID]" $MESSAGE
}

function usage () {
cat <<EOF

usage: $0 [ -h ] [ -d TEST_DOMAIN ] [ -H CUBE_SERVER ] [ -p CUBE_PORT ] [ -w WARNING_THRESHOLD ] [ -c CRITICAL_THRESHOLD ]

Available options:
      TEST_DOMAIN         - the domain RUM data is test for (default value "$CUBE_DOMAIN")
      CUBE_SERVER         - the name of CUBE "evaluator" service the RUM data should be fetched from (default value "$CUBE_HOST")
      CUBE_PORT           - the TCP port of CUBE "evaluator" service (default value "$CUBE_PORT")
      WARNING_THRESHOLD   - Nagios warning threshold for number of RUM per-minute metrics reported for the last 10 minutes (default value "$WARNING")
      CRITICAL_THRESHOLD  - Nagios warning threshold for number of RUM per-minute metrics reported for the last 10 minutes (default value "$CRITICAL")
EOF
exit 1
}

while getopts "hd:H:p:w:c:" OPTION; do
  case "$OPTION" in
    h) usage ;;
    d) CUBE_DOMAIN=$OPTARG ;;
    H) CUBE_HOST=$OPTARG ;;
    p) CUBE_PORT=$OPTARG ;;
    w) WARNING=$OPTARG ;;
    c) CRITICAL=$OPTARG ;;
  esac
done

CUBE_URL="/1.0/metric?expression=median(pl_info(networkTime).eq(domain,%27${CUBE_DOMAIN}%27))&start=${START_TIME}&stop=${STOP_TIME}&step=6e4"
CUBE="http://"$CUBE_HOST":"$CUBE_PORT${CUBE_URL}


TMP=`mktemp`

curl -s "$CUBE" > $TMP
ERROR_CODE=$?
json=`cat $TMP`

rm -f $TMP

if [ $ERROR_CODE -ne 0 ]; then
	log_message INFO "Failed to fetch the CUBE data, curl exit code $ERROR_CODE"
	echo "CRITICAL: Failed to fetch the CUBE data, curl exit code $ERROR_CODE"	
	exit $STATE_CRITICAL
fi

METRICS=`echo "$json" | sed -e 's/[{}]/''/g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | grep value | wc -l`

if [ $METRICS -le $CRITICAL ]; then
	log_message CRITICAL "Received only $METRICS CUBE metrics"
	echo "CRITICAL: Received only $METRICS CUBE metrics | CubeMetrics=$METRICS;;;"
	exit $STATE_CRITICAL
fi

if [ $METRICS -le $WARNING  ]; then
	log_message WARNING "Received only $METRICS CUBE metrics"
	echo "WARNING: Received only $METRICS CUBE metrics | CubeMetrics=$METRICS;;;"
	exit $STATE_WARNING
fi

log_message INFO "Received $METRICS CUBE metrics"
echo "OK: Received $METRICS CUBE metrics | CubeMetrics=$METRICS;;;"
exit $STATE_OK
