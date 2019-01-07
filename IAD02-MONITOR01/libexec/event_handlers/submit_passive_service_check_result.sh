#!/bin/bash


# Write a command to the Nagios command file to cause
# it to process a service check result

echocmd="/bin/echo"

CommandFile="/usr/local/nagios/var/rw/nagios.cmd"


# get the current date/time in seconds since UNIX epoch

datetime=`date +%s`


# create the command line to add to the command file

cmdline="[$datetime] PROCESS_SERVICE_CHECK_RESULT;$1;$2;$3;$4"
 

# append the command to the end of the command file

`$echocmd $cmdline >> $CommandFile`
