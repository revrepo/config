#!/bin/bash

#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
#

#
# A simple script to enable/disable a BP server in GLB rules by enabling/disabling monitor.revsw.net domain
#

OPS=$1

log_message () {
	SEVERITY=$1
	MESSAGE="$2"
	echo `date`  $SEVERITY: $MESSAGE	

}

FILE=/etc/apache2/sites-available/monitor_revsw_net.conf

if [ ! -f $FILE ]; then
	log_message ERROR "File $FILE does not exist - aborting."
	exit 1
fi

if [ "$OPS" == "online" ]; then

	log_message INFO "Enabling domain monitor.revsw.net"

	a2ensite monitor_revsw_net 

elif [ "$OPS" == "offline" ]; then

	log_message INFO "Disabling domain monitor.revsw.net"

	a2dissite monitor_revsw_net 

else
	log_message ERROR "Wrong parameter: use 'online' or 'offline'"	
	exit 1
fi

/etc/init.d/revsw-apache2 reload

exit 0

