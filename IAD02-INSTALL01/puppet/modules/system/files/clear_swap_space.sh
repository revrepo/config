#!/bin/bash
#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
#
#
# The script checks the level of swap space usage, if it is higher than the specified threshold 
# the script will try to clear the swap by turning it off and back on
#


SCRIPTNAME=$0
PID=$$

function log_message () {
	SEVERITY=$1
	MESSAGE=$2

	echo `date` "$SCRIPTNAME[$PID]: $SERERITY $MESSAGE"
	logger -t "$SCRIPTNAME[$PID]" $MESSAGE
}


while getopts ":t:" opt; do
  case $opt in
    t)
      THRESHOLD=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
  esac
done

if [ -z "$THRESHOLD" ]; then
	echo "Usage: clear_swap_space.sh -t THRESHOLD"
	exit 1
fi

TOTAL=`free -m|grep Swap | awk '{print $2}'`
USED=`free -m|grep Swap | awk '{print $3}'`

log_message INFO "Total swap space $TOTAL MB, used swap space $USED MB"

if [ $TOTAL -eq 0 ]; then
	log_message INFO "Swap space is not configured on the server"
	exit 1
fi

let USAGE_LEVEL=USED*100/TOTAL

if [ $USAGE_LEVEL -ge $THRESHOLD ]; then
	log_message INFO "Swap usage level $USAGE_LEVEL% is higher than threshold $THRESHOLD - clearing the swap space"
else
	exit 0
fi

SLEEP=`echo $[ 1 + $[ RANDOM % 12 ]]`

log_message INFO "Sleeping for $SLEEP minutes"

sleep ${SLEEP}m

log_message INFO "Turning swap off..."
swapoff -a

if [ $? -ne 0 ]; then
	log_message ERROR "Failed to execute 'swapoff -a' command - please investige"
	exit 1
fi

log_message INFO "Turning swap back on..."

swapon -a
if [ $? -ne 0 ]; then
	log_message ERROR "Failed to execute 'swapon -a' command - please investige"
	exit 1
fi

log_message INFO "Done"
