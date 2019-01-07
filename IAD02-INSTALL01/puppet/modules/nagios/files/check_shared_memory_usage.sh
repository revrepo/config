#!/bin/bash

#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
#

#
# A Nagios script to monitor the level of shared memory usage on BP proxy servers
#


WARNING=$1
CRITICAL=$2

# Nagios return codes
STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3


USED_SEGMENTS=`ipcs -m|tail -n +4|head -n -1|wc -l`
MAX_SEGMENTS=`sysctl kernel.shmmni|awk '{print $3}'`

if [ $MAX_SEGMENTS -eq 0 ]; then
        echo "OK: No shared memory is enabled on the server | UsageLevel=0;;; UsedSegements=0;;;"
        exit $STATE_OK
fi

let USAGE=USED_SEGMENTS*100/MAX_SEGMENTS

if [ $USAGE -ge $CRITICAL ]; then
        echo "CRITICAL: Shared memory usage is $USAGE% ($USED_SEGMENTS segments) | UsageLevel=$USAGE;;; UsedSegments=$USED_SEGMENTS;;;"
        exit $STATE_CRITICAL
fi

if [ $USAGE -ge $WARNING ]; then
        echo "WARNING: Shared memory usage is $USAGE% ($USED_SEGMENTS segments) | UsageLevel=$USAGE;;; UsedSegments=$USED_SEGMENTS;;;"
        exit $STATE_WARNING
fi

echo "OK: Shared memory usage is $USAGE% ($USED_SEGMENTS segments) | UsageLevel=$USAGE;;; UsedSegments=$USED_SEGMENTS;;;"
exit $STATE_OK
