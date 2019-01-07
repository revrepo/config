#!/bin/ksh

SCRIPTNAME=$0
PID=$$

log_message () {
        SEVERITY=$1
        MESSAGE=$2

        echo `date` "$SCRIPTNAME[$PID]: $SERERITY $MESSAGE"
        logger -t "$SCRIPTNAME[$PID]" $MESSAGE
}


URL_FILE=/etc/nagios/objects/urls_to_test.txt 
NAGIOS_CONFIG_FILE=/etc/nagios/objects/url_tests.cfg

if [ ! -s $URL_FILE ]; then
	echo "File $URL_FILE does not exist or is empty - aborting."
	exit 1
fi

t=$(tempfile -m 0644) 
trap "rm -f -- '$t'" EXIT

echo "Using temporary file $t"

(
echo "#"
echo "# DON'T MODIFY THE FILE MANUALLY. THE FILE IS GENERATED AUTOMATICALLY BY LOCAL"
echo "# SCRIPT /etc/nagios/services/generate_url_test_file.sh."
echo "#"
echo "#"

) >> $t



cat $URL_FILE | grep -v "^#" | awk '{print $1, $2}' | while read URL EXPECTEDSTATUS ;do

	SSL=""

        if [ -z "$URL" -a -z "$EXPECTEDSTATUS" ]; then
                continue
        fi

        if [ -z "$URL" ]; then
                echo "UNKNOWN: Empty URL name - possibly wrong format of $URL_FILE file."
                exit 1
        fi

        if [ -z "$EXPECTEDSTATUS" ]; then
                echo "UNKNOWN: Empty expected status code - possibly wrong format of $URL_FILE file."
                exit 1
        fi

        HOST=`echo $URL | cut -f3 -d/`
        URI=`echo $URL | cut -f4- -d/`

        if [ ! -z "`echo $URL | grep -i "^https:"`" ]; then
                SSL="-S"        
        fi

	echo "Generating Nagios config section for URL $URL, expected status code $EXPECTEDSTATUS..."

	(

	echo ""
	echo "define service {"
	echo "       use                             generic-service,graphed-service"
	echo "       hostgroup_name                  bp-servers,!validation-proxy-servers,!wallarm-servers"
	echo "       service_description             HTTP Test: $URL"
	echo "       check_command                   check_http! -k \"Accept-Encoding:gzip, deflate, sdch\" -H $HOST  -t 5 -w 3 -c 4 $SSL -u \"/$URI\" -e \"$EXPECTEDSTATUS\""
	echo "       contact_groups                  admins-email"
	echo "       notifications_enabled           0"
	echo "}"	
	echo ""

	) >> $t

done

if [ -s $t ]; then
	mv $t $NAGIOS_CONFIG_FILE
fi

rm -f -- "$t"
trap - EXIT
