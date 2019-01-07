#!/bin/bash
#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
#

# Copyright bitly, Aug 2011 
# written by Jehiah Czebotar

DATAFILE="/var/tmp/nagios_check_forkrate.dat"
VALID_INTERVAL=600

OK=0
WARNING=1
CRITICAL=2
UNKNOWN=-1

function usage()
{
    echo "usage: $0 --warn=<int> --critical=<int>"
    echo "this script checks the rate processes are created"
    echo "and alerts when it goes above a certain threshold"
    echo "it saves the value from each run in $DATAFILE"
    echo "and computes a delta on the next run. It will ignore"
    echo "any values that are older than --valid-interval=$VALID_INTERVAL (seconds)"
    echo "warn and critical values are in # of new processes per second"
}

while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
        -w | --warn)
            WARN_THRESHOLD=$VALUE
            ;;
        -c | --critical)
            CRITICAL_THRESHOLD=$VALUE
            ;;
        --valid-interval)
            VALID_INTERVAL=$VALUE
            ;;
        -h | --help)
            usage
            exit 0;
            ;;
    esac
    shift
done

if [ -z "$WARN_THRESHOLD" ] || [ -z "$CRITICAL_THRESHOLD" ]; then
    echo "error: --warn and --critical parameters are required"
    exit $UNKNOWN
fi
if [[ $WARN_THRESHOLD -ge $CRITICAL_THRESHOLD ]]; then
    echo "error: --warn ($WARN_THRESHOLD) can't be greater than --critical ($CRITICAL_THRESHOLD)"
    exit $UNKNOWN
fi

NOW=`date +%s`
min_valid_ts=$(($NOW - $VALID_INTERVAL))
current_process_count=`awk '/processes/ {print $2}' /proc/stat`

if [ ! -f $DATAFILE ]; then
    mkdir -p $(dirname $DATAFILE)
    echo -e "$NOW\t$current_process_count" > $DATAFILE
    echo "Missing $DATAFILE; creating"
    exit $UNKNOWN
fi

# now compare this to previous
mv $DATAFILE{,.previous}
while read ts process_count; do
    if [[ $ts -lt $min_valid_ts ]]; then
        continue
    fi
    if [[ $ts -ge $NOW ]]; then
        # we can't use data from the same second
        continue
    fi
    # calculate the rate
    process_delta=$(($current_process_count - $process_count))
    ts_delta=$(($NOW - $ts))
    current_fork_rate=`echo "$process_delta / $ts_delta" | bc`
    echo -e "$ts\t$process_count" >> $DATAFILE
done < $DATAFILE.previous
echo -e "$NOW\t$current_process_count" >> $DATAFILE

echo "fork rate is $current_fork_rate processes/second (based on the last $ts_delta seconds) |fork_rate=$current_fork_rate;;"
if [[ $current_fork_rate -ge $CRITICAL_THRESHOLD ]]; then
    exit $CRITICAL
fi
if [[ $current_fork_rate -ge $WARN_THRESHOLD ]]; then
    exit $WARNING
fi
exit $OK
