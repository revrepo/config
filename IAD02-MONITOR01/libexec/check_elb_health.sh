#!/bin/bash
#
#
#
#

SCRIPTNAME=$0
PID=$$

WARNING=1
CRITICAL=0


STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4

function usage () {
cat <<EOF

usage: $0 [ -h ] -e ELB_INSTANCE_NAME [ -w WARNING_THRESHOLD ] [ -c CRITICAL_THRESHOLD ]

EOF
exit 1
}

while getopts "he:w:c:" OPTION; do
  case "$OPTION" in
    h) usage ;;
    e) ELB_NAME=$OPTARG ;;
    w) WARNING=$OPTARG ;;
    c) CRITICAL=$OPTARG ;;
  esac
done

if [ -z "$ELB_NAME" ]; then
	usage
fi

TMP=`mktemp`

export HOME="/home/nagios"

/usr/local/bin/aws elb describe-instance-health --load-balancer-name "$ELB_NAME" > $TMP 2>&1

ERROR_CODE=$?

N=`cat $TMP | grep '"State": "InService"'|wc -l`

rm -f $TMP

if [ $ERROR_CODE -ne 0 ]; then
	echo "UNKNOWN: 'aws' command returned non-zero error code ($ERROR_CODE)"
	exit $STATE_UNKNOWN 
fi

if [ $N -le $CRITICAL ]; then
	echo "CRITICAL: For ELB $ELB_NAME only $N backend instances are 'In Service' state | InService=$N;;;"
	exit $STATE_CRITICAL
fi

if [ $N -le $WARNING ]; then
	echo "WARNING: For $ELB_NAME only $N backend instances are 'In Service' state | InService=$N;;;"
	exit $STATE_WARNING
fi

echo "OK: For ELB $ELB_NAME there are $N backend instances 'In Service' state | InService=$N;;;"
exit $STATE_OK
