#!/bin/bash

cat /var/log/messages|grep nagios|grep "SERVICE ALERT"|grep SOFT|grep -v ';OK'| grep -v FRA02-BP01| cut -f9- -d" "|cut -f1-5 -d\;|sort|uniq -c|sort -rn | head -100

