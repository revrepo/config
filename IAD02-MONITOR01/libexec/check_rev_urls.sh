#!/bin/ksh
#
# A custom Nagios check script used to verify that all URLs mentioned in file $2
# can be fetched with expected status code from node $1
#

NODE=$1
FILE=$2


STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4

RETURNCODE=0

cat $FILE | grep -v "^#" | awk '{print $1, $2}' | while read URL EXPECTEDSTATUS ;do

	if [ -z "$URL" -a -z "$EXPECTEDSTATUS" ]; then
		continue
	fi

	if [ -z "$URL" ]; then
		echo "UNKNOWN: Empty URL name - possibly wrong format of $FILE file."
		exit $STATE_UNKNOWN
	fi

	if [ -z "$EXPECTEDSTATUS" ]; then
		echo "UNKNOWN: Empty expected status code - possibly wrong format of $FILE file."
		exit $STATE_UNKNOWN
	fi

	HOST=`echo $URL | cut -f3 -d/`
 	URI=`echo $URL | cut -f4- -d/`

	if [ `echo $URL | grep -i "^https:"` ]; then
		SSL="-S"	
	fi

	echo "== Testing URL $URL, expected code $EXPECTEDSTATUS"

	/usr/local/nagios/libexec/check_http $SSL -H $HOST -u "/$URI" -e "$EXPECTEDSTATUS"
	ERRORCODE=$?

	if [ $ERRORCODE != 0 ]; then
		RETURNCODE=$ERRORCODE	
	fi

done


exit $RETURNCODE
