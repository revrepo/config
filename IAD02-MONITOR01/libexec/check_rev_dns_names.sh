#!/bin/ksh
#
# A custom Nagios check script used to verify that all domains mentioned in file $1
# can be properly resolved to the closest BP instance
#

FILE=$1

BP=209.177.157.11

STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4

RETURNCODE=0

cat $FILE | grep -v "^#" | awk '{print $1}' | cut -f3 -d/ | while read DOMAIN; do

	if [ -z "$DOMAIN" ]; then
		continue
	fi
	
	echo "INFO: Checking domain $DOMAIN..."

	/usr/local/nagios/libexec/check_dns -H $DOMAIN --querytype='A'
	ERRORCODE=$?

	if [ $ERRORCODE != 0 ]; then
		RETURNCODE=$ERRORCODE	
	fi

done


exit $RETURNCODE
