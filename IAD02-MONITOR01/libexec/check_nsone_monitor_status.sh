#!/bin/bash
#
# A Nagios script to check the number of NSONE monitors reporting hosts with DOWN status
#

STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4

TMP=`mktemp`

# Get the NSONE monitoring status 
curl -X GET -H 'X-NSONE-Key: LYvs2DdEm3rI8IdX0wuj' https://api.nsone.net/v1/monitoring/jobs -s > $TMP
ERROR_CODE=$?

if [ $ERROR_CODE -ne 0 -o -z "`cat $TMP | grep notify_list`" ]; then
	rm -f $TMP
	echo "CRITICAL: Failed to get the monitoring status from NSONE, curl error code $ERROR_CODE"
	exit $STATE_CRITICAL
fi

SUMMARY=`cat $TMP | sed -e 's/[{}]/''/g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | egrep -e "(status|host)"|grep -v '"status":"up"'|grep down -B1|sed s/\"//g|grep -v -- --`

# Count the number of hosts with failed checks
N=`cat $TMP | sed -e 's/[{}]/''/g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | egrep -e "(status|host)"|grep -v '"status":"up"'|grep down -B1|sed s/\"//g|grep -v -- -- | grep host|wc -l`

DOWN_HOSTS=`cat $TMP | sed -e 's/[{}]/''/g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | egrep -e "(status|host)"|grep -v '"status":"up"'|grep down -B1|sed s/\"//g|grep -v -- -- | grep host\: | cut -f2 -d\:|while read a; do echo -n "$a "; done`

rm -f $TMP

if [ $N -gt 0 ]; then
	echo "WARNING: NSONE detects $N down/failing hosts: $DOWN_HOSTS \n $SUMMARY | NSONEDownHosts=$N;;;;"
	exit $STATE_WARNING
fi

echo "OK: No down hosts are reported by NSONE | NSONEDownHosts=0;;;;"
exit $STATE_OK
