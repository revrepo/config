#!/bin/bash

#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
#

# Check for fresh files in /var/crash directory and send email report to the sysadmin. The script should be executed
# from crontab every 30 minutes.
#

SYSADMIN_EMAIL=ops@revsw.com
HOSTNAME=`hostname -s`

DIR=/var/crash
FRESHNESS=30  # report core files which are less than 30 minutes old

REPORT=`find $DIR -type f ! -name .lock -cmin -$FRESHNESS -ls`

if [ ! -z "$REPORT" ]; then
	echo "$REPORT" | mail -s "Fresh core file(s) on server $HOSTNAME" $SYSADMIN_EMAIL
fi
