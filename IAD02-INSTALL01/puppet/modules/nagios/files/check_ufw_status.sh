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

WARNING=9
CRITICAL=6

if [ -z "`which ufw`" ]; then
	echo "UNKNOWN: Cannot find 'ufw' tool"
	exit $STATE_UNKNOWN
fi

TMP=`mktemp`

ufw status > $TMP

if ! grep 'Status: active' $TMP > /dev/null ; then
	echo "CRITICAL: UFW firewall is not active"
	rm -f $TMP
	exit $STATE_CRITICAL
fi

RULES=`egrep -e "(ALLOW|DENY)" $TMP |wc -l`

rm -f $TMP

if [ $RULES -le $CRITICAL ]; then
	echo "CRITICAL: The number of UFW rules is less than $CRITICAL ($RULES) | FirewallRules=$RULES;;;"
	exit $STATE_CRITICAL
fi

if [ $RULES -le $WARNING ]; then
	echo "WARNING: The number of UFW rules is less than $WARNING ($RULES) | FirewallRules=$RULES;;;"
	exit $STATE_WARNING
fi

echo "OK: UFW firewall is active with $RULES rules | FirewallRules=$RULES;;;"
exit $STATE_OK
