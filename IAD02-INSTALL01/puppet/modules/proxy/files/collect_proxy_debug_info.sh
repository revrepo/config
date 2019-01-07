#!/bin/bash
#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
#

#
# This script should be used to collect proxy debug information to be used by R&D
#

DIR=/root/proxy_debug
EMAILS="ajit@revsw.com sorin@revsw.com"

if [ "$USER" != "root" ]; then
	echo "Please run the script as user 'root' - aborting"
	exit 1
fi

mkdir -p $DIR

if [ $? -ne 0 ]; then
	echo "Failed to create directory $DIR - aborting"
	exit 1
fi

if ! dpkg -s gdb >/dev/null 2>&1 ; then
    echo -e "You need GDB. Please install it by running:\n    apt-get update; apt-get install gdb" >&2
    exit 1
fi

logfile="$DIR/proxy-debug-report.`date +%Y%m%d-%H%M%S`"

echo Saving debug details to file $logfile
echo "The file will be automatically removed after seven days" | mailx -s "Please review proxy debug information stored in file $logfile on server `hostname`" $EMAILS

exec > $logfile 2>&1

echo "# RUNNING PROCESSES"
ps aux

echo
echo "# INSTALLED REV APPS"
dpkg -l | grep revsw

echo
echo "# SHARED MEMORY SEGMENTS"
ipcs -m | tail -n +3

echo "# PER-SEGMENT DATA"

for shm in `ipcs -m | tail -n +4 | cut -f2 -d' '`; do
    ipcs -m -i $shm
done

echo "# SEGMENT FILES"

ls -l /var/run/apache2/*.shm

echo
echo "# CONTENT OF SEGMENT FILES"

for f in `ls /var/run/apache2/*.shm`; do
    echo "$f:"
    cat $f | od -x
done

echo
echo "# APACHE CORE FILES"

for p in `pidof apache2`; do
	echo
	echo "# PID $p BEGIN"
	rm /tmp/apachecore*
	gcore -o /tmp/apachecore $p >/dev/null 2>&1
	cat /tmp/apachecore* | base64
	echo "# PID $p END"
done

echo "Gzipping log file $logfile..."
gzip $logfile

