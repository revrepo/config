#!/bin/bash

#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
#

N=$1

if [ -z "$N" ]; then
        echo "ERROR: Specify the number of top popular URLs to extract as the only parameter of the script"
        exit 1
fi

/opt/scripts/extract_urls_from_nginx_log_file.pl | grep -v rum01.revsw.net | grep -v monitor.revsw.net |grep -v "pulse-.*.revdn.net" | sort | uniq -c | sort -nr| head -n $N | awk '{print $2}'
