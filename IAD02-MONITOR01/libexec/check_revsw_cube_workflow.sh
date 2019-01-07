#!/bin/bash
#
# This scripts monitors the performance and functionality of Rev CUBE service
# For a descriptiob of the script please see  TBD
#

SCRIPTNAME=$0
PID=$$

CUBE_TIMEOUT=1

RMDB_SERVER=IAD02-RMDB01.REVSW.NET
STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4

function usage () {
cat <<EOF

usage: $0 [ -h ] -s CUBE_SERVER [ -o CUBE_TIMEOUT ] [ -d RMDB_SERVER ]

Available options:
      CUBE_TIMEOUT       - total time allowed for the CUBE submissions process to complete (default value "$CUBE_TIMEOUT")
      RMDB_SERVER        - RMDB server to look for results at (default value "$RMDB_SERVER")
EOF
exit 1
}

while getopts "hs:o:w:c:d:" OPTION; do
  case "$OPTION" in
    h) usage ;;
    s) CUBE_SERVER=$OPTARG ;;
    o) CUBE_TIMEOUT=$OPTARG ;;
    d) RMDB_SERVER=$OPTARG ;;
  esac
done

if [ -z "$CUBE_SERVER" ]; then
	usage
	exit $STATE_UNKNOWN
fi

TIME=`date +%Y%m%d-%H%M%S`

JSON='[
{
    "type": "pl_info",
    "time": "2011-09-12T21:33:12Z",
   "data": {
  "user_ip": "50.240.197.150",
  "nt_red_cnt": "0",
  "nt_nav_type": "0",
  "nt_nav_st": "1414530967512",
  "nt_red_st": "0",
  "nt_red_end": "0",
  "nt_unload_st": "0",
  "nt_unload_end": "0",
  "nt_spdy": "0",
  "nt_first_paint": "0",
  "v": "0.9.1396020860",
        "domain": "@CUBE_SERVER@",
        "geography": "US",
        "region": "CA",
        "city": "SanMateo",

  "u": "http://@CUBE_SERVER@/@TIMESTAMP@" }
}
]'


JSON2=`echo $JSON | sed s/@CUBE_SERVER@/$CUBE_SERVER/g | sed s/@TIMESTAMP@/$TIME/g`

TMP=`mktemp`

# Submit the prepared CUBE JSON object to the specified CUBE server
curl -s --fail -X POST http://$CUBE_SERVER:1080/1.0/event/put -d "$JSON2" > $TMP

ERROR_CODE=$?

RESPONSE=`cat $TMP`

rm -f $TMP

if [ $ERROR_CODE -ne 0 -o "$RESPONSE" != "{}" ]; then
	echo "CRITICAL: Failed to submit CUBE request, curl status code $ERROR_CODE"
	exit $STATE_CRITICAL
fi

sleep $CUBE_TIMEOUT

QUERY="db.pl_info_events.find({\"d.u\":\"http://$CUBE_SERVER/$TIME\"}).count()"

COUNT=`mongo --quiet --eval $QUERY $RMDB_SERVER:27017/cube_development`

ERROR_CODE=$?

if [ $ERROR_CODE -ne 0 ]; then
	echo "CRITICAL: Failed to communicate with RUM MDB, 'mongo' error code $ERROR_CODE"
	exit $STATE_CRITICAL
fi

if [ "$COUNT" != "1" ]; then
	echo "CRITICAL: Failed to find the expected CUBE record in the database"
	exit $STATE_CRITICAL
fi

echo "OK: Found expected timestamp $TIME for CUBE server $CUBE_SERVER"
exit $STATE_OK
