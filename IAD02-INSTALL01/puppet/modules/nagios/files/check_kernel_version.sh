#!/bin/bash

#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
#


STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4

EXPECTEDVERSION=$1

if [ -z "$EXPECTEDVERSION" ]; then
	echo "UNKNOWN: Wrong script usage - please specify the expected kernel version as the only paramater of the script"
	exit $STATE_UNKNOWN
fi

KERNELVERSION=`uname -r`

if [ -z "$KERNELVERSION" ]; then
	echo "UNKNOWN: Failed to read the current kernel version"
	exit $STATE_UNKNOWN
fi

if [ "$KERNELVERSION" != "$EXPECTEDVERSION" ]; then

	if [ `echo $KERNELVERSION | grep "revsw$"` ]; then
		echo "WARNING: The server runs a Rev kernel ($KERNELVERSION) but not the expected version $EXPECTEDVERSION"
		exit $STATE_WARNING
	else
		echo "CRITICAL: The server runs a wrong kernel. Current version $KERNELVERSION, expected version $EXPECTEDVERSION"
		exit $STATE_CRITICAL
	fi

else
	echo "OK: The server runs expected kernel version $EXPECTEDVERSION"
	exit $STATE_OK
fi


