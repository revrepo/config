#!/bin/bash

#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
#

 
# Check "nofile" limit for all running processes using lsof
 
MIN_COUNT=0 # default "nofile" limit is usually 1024, so no checking for 
        # processes with much less open fds needed
 
WARN_THRESHOLD=80   # default warning:  80% of file limit used
CRITICAL_THRESHOLD=90   # default critical: 90% of file limit used
 
while getopts "hw:c:" option; do
    case $option in
        w) WARN_THRESHOLD=$OPTARG;;
        c) CRITICAL_THRESHOLD=$OPTARG;; 
        h) echo "Syntax: $0 [-w <warning percentage>] [-c <critical percentage>]"; exit 1;;
    esac
done
 
results=$(
# Check global limit
global_max=$(cat /proc/sys/fs/file-nr 2>&1 |cut -f 3)
global_cur=$(cat /proc/sys/fs/file-nr 2>&1 |cut -f 1)
ratio=$(( $global_cur * 100 / $global_max))
 
if [ $ratio -ge $CRITICAL_THRESHOLD ]; then
    echo "CRITICAL global file usage $ratio% of $global_max used"
elif [ $ratio -ge $WARN_THRESHOLD ]; then
    echo "WARNING global file usage $ratio% of $global_max used"
fi
 
# We use the following lsof options:
#
# -n    to avoid resolving network names
# -b    to avoid kernel locks
# -w    to avoid warnings caused by -b
# +c15  to get somewhat longer process names
#
lsof -wbn +c15 2>/dev/null | awk '{print $1,$2}' | sort | uniq -c |\
while read count name pid remainder; do
    # Never check anything above a sane minimum
    if [ $count -gt $MIN_COUNT ]; then
        # Extract the soft limit from /proc
        limit=$(cat /proc/$pid/limits 2>/dev/null| grep 'open files' | awk '{print $4}')
 
        # Check if we got something, if not the process must have terminated
        if [ "$limit" != "" ]; then
            ratio=$(( $count * 100 / $limit ))
            if [ $ratio -ge $CRITICAL_THRESHOLD ]; then
                echo "CRITICAL $name (PID $pid) $ratio% of $limit used"
            elif [ $ratio -ge $WARN_THRESHOLD ]; then
                echo "WARNING $name (PID $pid) $ratio% of $limit used"
            fi
        fi
    fi
done
)
 
if echo $results | grep CRITICAL; then
    exit 2
fi
if echo $results | grep WARNING; then
    exit 1
fi
 
echo "All processes are fine."
