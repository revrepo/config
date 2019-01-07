#!/bin/bash

IP=`ifconfig eth0|grep inet|awk '{print $2}'|cut -f2 -d\:` ; echo $IP

dig +short $IP.geo.tools.nsone.net txt
