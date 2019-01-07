#!/bin/bash
#
# This script is used to monitor the reporting performance of Rev CUBE service - please see this page for more details:
#   https://revwiki.atlassian.net/wiki/display/OP/Nagios+Monitoring+for+RUM+and+CUBE+Workflow
#


SCRIPTNAME=$0
PID=$$

ORIGINAL_SCRIPT_PARAMETERS=$@

CUBE_DOMAIN="rum_workflow_test.revdn.net"
CUBE_HOST="cube-02-prod-sjc.revsw.net"
CUBE_PORT=1081
STOP_TIME=`date +%Y-%m-%dT%H:%M:%S.460Z`
START_TIME=`date +%Y-%m-%dT%H:%M:%S.460Z -d "30 days ago"`

CUBE_URL="/1.0/metric?expression=median(pl_info(networkTime).eq(domain,%27${CUBE_DOMAIN}%27))&start=${START_TIME}&stop=${STOP_TIME}&step=36e5"
CUBE="http://"$CUBE_HOST":"$CUBE_PORT${CUBE_URL}

/usr/local/nagios/libexec/check_http -p $CUBE_PORT -u $CUBE $ORIGINAL_SCRIPT_PARAMETERS
