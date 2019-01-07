#!/bin/bash

#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
#


usage() {
cat <<EOF

usage: $0 [ -h ] [ -u URL ] [ -g GRAPHITE_SERVER_IP ] [ -p GRAPHITE_PORT ]

EOF
exit 1
}

URL="http://localhost/pagespeed_admin/root/"
HOST=`hostname -s`
GRAPHITE="graphite.revsw.net"
PORT=2003

while getopts "dhu:g:p:" OPTION; do
  case "$OPTION" in
    d) DEBUG=1 ;;
    h) usage ;;
    u) URL=$OPTARG ;;
    g) GRAPHITE=$OPTARG ;;
    p) PORT=$OPTARG ;;
  esac
done

dateStamp=`date +%s`

TMP=`mktemp`

curl -s $URL > $TMP

if [ $? -ne 0 ]; then
	rm -f $TMP
	exit 1
fi

(
cat $TMP | sed -n '/\<pre\>/,/\<\/pre\>/p' | grep -v timestamp_ | grep -v "<pre>" | grep -v "</pre>" | sed s/":"/""/g | while read VAR VALUE; do

	echo $HOST.pagespeed.$VAR $VALUE $dateStamp

done

) | nc -q1 $GRAPHITE $PORT

rm -f $TMP
