#!/bin/bash

# A fucking hackish and absolutely wrong way to import NAXSI events

# TODO: need to check that the revsw-nxtool package is installed, logtail tool is present,
# /var/log/messages file exists

logtail -f /var/log/messages|grep NAXSI_FMT | tr -s ' ' |cut -f4,7- -d' ' | awk '{ host="\""$1"\""; $1=""; print $0,", proxy_name:", host}' | awk '{$1=$1}1'  > /opt/revsw-nxtool/events-to-import.log

# TODO: need to check the exit code and the size of resulting log file

cd /opt/revsw-nxtool/
./nxtool.py --es_host=IAD02-ES08.REVSW.NET:9200 --config=/opt/revsw-nxtool/nxapi.json --files /opt/revsw-nxtool/events-to-import.log # > /dev/null 2>&1

# ./nxtool.py --es_host=IAD02-ES05.REVSW.NET:9200 --config=/opt/revsw-nxtool/nxapi.json --files /opt/revsw-nxtool/events-to-import.log # > /dev/null 2>&1

# TODO: need to check the exist code and somehow keep/analyze the stderr output of the tool

rm -f /opt/revsw-nxtool/events-to-import.log
