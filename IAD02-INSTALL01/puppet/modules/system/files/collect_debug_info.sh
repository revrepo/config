#!/bin/bash
#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
#

#
# This script can be used to collect from the local server a lot of debug information to be used by the Engineering team
#

DIR=/var/debug_information/`date +%Y%m%d-%H%M%S`

EMAILS="victor@revsw.com ajit@revsw.com sorin@revsw.com prashant@revsw.com"

if [ "$USER" != "root" ]; then
	echo "Please run the script as user 'root' - aborting"
	exit 1
fi

mkdir -p $DIR

if [ $? -ne 0 ]; then
	echo "Failed to create directory $DIR - aborting"
	exit 1
fi

#if ! dpkg -s gdb >/dev/null 2>&1 ; then
#    echo -e "You need GDB. Please install it by running:\n    apt-get update; apt-get install gdb" >&2
#    exit 1
#fi

function print_header () {
	TEXT="$1"

	echo "" >> $logfile 2>&1
	echo "#" >> $logfile 2>&1
	echo "# $TEXT" >> $logfile 2>&1
	echo "# $TEXT"
	echo "#" >> $logfile 2>&1
}

logfile="$DIR/debug-report"

echo Saving debug details to file $logfile

echo "# Report start date: "`date` >> $logfile 2>&1

print_header "RUNNING PROCESSES: ps aux"
ps aux >> $logfile 2>&1

print_header "NETSTAT REPORT: netstat -nal -p"
netstat -nal -p >> $logfile 2>&1

print_header "LSOF REPORT: lsof -n"
lsof -n >> $logfile 2>&1

print_header "MEMORY USAGE STATUS: free"
free >> $logfile 2>&1

print_header "DISK USAGE STATUS: df -h"
df -h >> $logfile 2>&1

print_header "DISK INODE STATUS: df -i"
df -i >> $logfile 2>&1

print_header "INSTALLED REV APPS: dpkg -l | grep revsw"
dpkg -l | grep revsw >> $logfile 2>&1

print_header "INSTALLED ALL APPS: dpkg -l"
dpkg -l >> $logfile 2>&1

print_header "SHARED MEMORY SEGMENTS"
ipcs -m >> $logfile 2>&1

echo "Copying /etc directory to $DIR..."
cp -r /etc $DIR/

print_header "LAST 500 LINES FROM /var/log/messages"
tail -500 /var/log/messages >> $logfile 2>&1

if [ -f /var/log/apache2/other_vhosts_access.log ]; then
	print_header "LAST 500 LINES FROM /var/log/apache2/other_vhosts_access.log"
	tail -500 /var/log/apache2/other_vhosts_access.log >> $logfile 2>&1
fi

if [ -f /var/log/apache2/error.log ]; then
	print_header "LAST 500 LINES FROM /var/log/apache2/error.log"
	tail -500 /var/log/apache2/error.log >> $logfile 2>&1
fi


echo "Gzipping directory $DIR to file $DIR.tgz..."
tar cfz $DIR.tgz $DIR

echo "Removing directory $DIR..."
rm -rf $DIR

echo "The file will be automatically removed after seven days" | mailx -s "Please review server debug information stored in file $DIR.tgz on server `hostname`" $EMAILS
