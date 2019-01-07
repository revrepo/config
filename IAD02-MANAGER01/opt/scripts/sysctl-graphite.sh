#!/bin/bash

#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
#


usage() {
cat <<EOF

usage: $0 [ -h ] [ -g GRAPHITE_SERVER_IP ] [ -p GRAPHITE_PORT ] [ -c CONFIG_FILE ]

EOF
exit 1
}

HOST=`hostname -s`
GRAPHITE="graphite.revsw.net"
PORT=2003
CONFIG_FILE="/opt/scripts/sysctl-graphite.conf"

while getopts "hc:g:p:" OPTION; do
  case "$OPTION" in
    h) usage ;;
    c) CONFIG_FILE=$OPTARG ;;
    g) GRAPHITE=$OPTARG ;;
    p) PORT=$OPTARG ;;
  esac
done

if [ ! -s "$CONFIG_FILE" ] ; then
	echo "CRITICAL: Specified configuration file $CONFIG_FILE is empty or does not exit - aboting"
	exit 1
fi

dateStamp=`date +%s`

TMP=`mktemp`

cat $CONFIG_FILE | grep -v "^#" | grep -v "^$" | while read s; do
	VALUE=`sysctl --ignore $s | grep "=" | awk '{print $3}'`
	if [ ! -z "$VALUE" ]; then
		echo $HOST.sysctl.$s $VALUE $dateStamp >> $TMP
	fi

done

if [ -s "$TMP" ]; then
	cat $TMP | nc -q1 $GRAPHITE $PORT
fi

rm -f $TMP
