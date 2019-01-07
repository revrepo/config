#!/bin/bash

#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
#


usage() {
cat <<EOF

usage: $0 [ -d ] [ -h ] [ -u URL ] [ -g GRAPHITE_SERVER_IP ]

EOF
exit 1
}

URL="http://monitor-apache-status.revsw.net/rev-status?auto"
HOST=`hostname -s`
GRAPHITE="graphite.revsw.net"

if [ ! -z "`echo $HOST|grep -- '-CO'`" ]; then
	URL="http://localhost/server-status?auto"
fi


while getopts "dhu:g:" OPTION; do
  case "$OPTION" in
    d) DEBUG=1 ;;
    h) usage ;;
    u) URL=$OPTARG ;;
    g) GRAPHITE=$OPTARG ;;
  esac
done

dateStamp=`date +%s`

TMP=`mktemp`

curl -s $URL > $TMP

#<p>Scoreboard Key:<br />
#"<b><code>_</code></b>" Waiting for Connection, 
#"<b><code>S</code></b>" Starting up, 
#"<b><code>R</code></b>" Reading Request,<br />
#"<b><code>W</code></b>" Sending Reply, 
#"<b><code>K</code></b>" Keepalive (read), 
#"<b><code>D</code></b>" DNS Lookup,<br />
#"<b><code>C</code></b>" Closing connection, 
#"<b><code>L</code></b>" Logging, 
#"<b><code>G</code></b>" Gracefully finishing,<br /> 
#"<b><code>I</code></b>" Idle cleanup of worker, 
#"<b><code>.</code></b>" Open slot with no current process</p>


waiting=`cat $TMP | sed '$!d' | tr -d 'Scoreboard: ' | grep -o '_' | tr -d '\n' | wc -m`
starting=`cat $TMP | sed '$!d' | tr -d 'Scoreboard: ' | grep -o 'S' | tr -d '\n' | wc -m`
reading=`cat $TMP | sed '$!d' | tr -d 'Scoreboard: ' | grep -o 'R' | tr -d '\n' | wc -m`
sendingreply=`cat $TMP | sed '$!d' | tr -d 'Scoreboard: ' | grep -o 'W' | tr -d '\n' | wc -m`
keepalive=`cat $TMP | sed '$!d' | tr -d 'Scoreboard: ' | grep -o 'K' | tr -d '\n' | wc -m`
dnslookup=`cat $TMP | sed '$!d' | tr -d 'Scoreboard: ' | grep -o 'D' | tr -d '\n' | wc -m`
closing=`cat $TMP | sed '$!d' | tr -d 'Scoreboard: ' | grep -o 'C' | tr -d '\n' | wc -m`
logging=`cat $TMP | sed '$!d' | tr -d 'Scoreboard: ' | grep -o 'L' | tr -d '\n' | wc -m`
finishing=`cat $TMP | sed '$!d' | tr -d 'Scoreboard: ' | grep -o 'G' | tr -d '\n' | wc -m`
openslot=`cat $TMP | sed '$!d' | tr -d 'Scoreboard: ' | grep -o '\.' | tr -d '\n' | wc -m`
total=`cat $TMP | sed '$!d' | tr -d 'Scoreboard: ' | tr -d '\n' | wc -m`

msglinkaudio=`cat $TMP | grep '<b>W</b>' -A2 | grep messagelinkaudio | wc -l | tr -d '\n'`
bsworkers=`cat $TMP | grep BusyWorkers | sed 's/.*\ //'`
bytesperrequest=`cat $TMP | grep BytesPerReq | sed 's/.*\ //'`
bytespersecond=`cat $TMP | grep BytesPerSec | sed 's/.*\ //'`
requestspersecond=`cat $TMP | grep ReqPerSec | sed 's/.*\ //'`
idleworkers=`cat $TMP | grep IdleWorkers | sed 's/.*\ //'`


waitingvars="$HOST.apache.scoreboard.waiting_for_connection "$waiting" "$dateStamp
startingvars="$HOST.apache.scoreboard.starting_up "$starting" "$dateStamp
readingvars="$HOST.apache.scoreboard.reading_request "$reading" "$dateStamp
sendingreplyvars="$HOST.apache.scoreboard.sending_reply "$sendingreply" "$dateStamp
keepalivevars="$HOST.apache.scoreboard.keepalive "$keepalive" "$dateStamp
dnslookupvars="$HOST.apache.scoreboard.dnslookup "$dnslookup" "$dateStamp
closingvars="$HOST.apache.scoreboard.closing_connection "$closing" "$dateStamp
loggingvars="$HOST.apache.scoreboard.logging "$logging" "$dateStamp
finishingvars="$HOST.apache.scoreboard.gracefully_finishing "$finishing" "$dateStamp
openslotvars="$HOST.apache.scoreboard.open_slot "$openslot" "$dateStamp
totalvars="$HOST.apache.scoreboard.total "$total" "$dateStamp

msglinkvars="$HOST.apache.messagelinkaudio_mp3_php "$msglinkaudio" "$dateStamp 
bsworkersvars="$HOST.apache.busy_workers "$bsworkers" "$dateStamp
bytesperrequestvars="$HOST.apache.bytes_per_request "$bytesperrequest" "$dateStamp
bytespersecondvars="$HOST.apache.bytes_per_second "$bytespersecond" "$dateStamp
requestspersecondvars="$HOST.apache.requests_per_second "$requestspersecond" "$dateStamp
idleworkersvars="$HOST.apache.idle_workers "$idleworkers" "$dateStamp

rm -f $TMP

if [[ $DEBUG ]]; then 

echo $waitingvars
echo $startingvars
echo $readingvars
echo $sendingreplyvars
echo $keepalivevars
echo $dnslookupvars
echo $closingvars
echo $loggingvars
echo $finishingvars
echo $openslotvars
echo $totalvars
echo " "
echo $msglinkvars
echo $bsworkersvars
echo $bytesperrequestvars
echo $bytespersecondvars
echo $requestspersecondvars
echo $idleworkersvars

else

#nc is not exiting, so i set the -q timeout and then background it
( echo $waitingvars
echo $startingvars
echo $readingvars
echo $sendingreplyvars
echo $keepalivevars
echo $dnslookupvars
echo $closingvars
echo $loggingvars
echo $finishingvars
echo $openslotvars 
echo $totalvars
echo $msglinkvars
echo $bsworkersvars
echo $bytesperrequestvars
echo $bytespersecondvars
echo $requestspersecondvars
echo $idleworkersvars ) | nc -q1 $GRAPHITE 2003

fi
