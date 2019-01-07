#!/bin/bash

#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
#

FILE=/etc/resolv_new.conf

if [ ! -f $FILE ]; then
	echo "CRITICAL: File $FILE does not exist - aborting"
	exit 1
fi	

chattr -i /etc/resolv.conf
rm -f /etc/resolv.conf

cp $FILE /etc/resolv.conf

chattr +i /etc/resolv.conf

