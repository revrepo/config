#!/bin/bash
#
# UFW configuration script for management servers 
#


UFW=/usr/sbin/ufw

if [ ! -x $UFW ]; then
	echo "FATAL: Cannot find UFW utility at $UFW - aboring."
	exit 1
fi

ufw disable

ufw reset

ufw logging off

ufw default deny incoming

ufw default allow outgoing

# Allow SSH from everywhere (for now)
ufw allow ssh

# Allow NRPE port only from IAD02-MONITOR01 and SJC02-MONITOR02
ufw allow proto tcp from 54.88.56.156/32 to any port 5666
ufw allow proto tcp from 54.193.118.76/32 to any port 5666

# Allow SNMP port only from IAD02-MONITOR01
ufw allow proto udp from 54.88.56.156/32 to any port 161

# Allow rsyslog from everywhere (for now)
ufw allow 514/udp
ufw allow 5140/tcp

# Allow Puppet master access from everywhere (for now)
ufw allow 8140/tcp

# Allow HTTP and HTTPS ports from everywhere
ufw allow 80/tcp
ufw allow 443/tcp

# Allow Graphite server ports from everywhere (for now)
ufw allow 2003:2004/tcp

ufw enable
