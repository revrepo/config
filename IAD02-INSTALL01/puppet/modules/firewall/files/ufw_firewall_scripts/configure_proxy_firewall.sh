#!/bin/bash

#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
#

#
# UFW configuration rules for BP/CO proxy servers
#


UFW=/usr/sbin/ufw

if [ ! -x $UFW ]; then
	echo "FATAL: Cannot find UFW utility at $UFW - aboring."
	exit 1
fi

ufw disable

# exit 0

ufw reset

ufw logging off

ufw default deny incoming

ufw default allow outgoing

# Allow SSH access from MONITOR servers (for SSH monitoring)
# Allow from SJC02-MONITOR02
ufw allow proto tcp from 54.193.118.76/32 to any port 22
# Allow from IAD02-MONITOR01
ufw allow proto tcp from 54.88.56.156/32 to any port 22

# Allow SSH access from MANAGER servers
# Allow from SJC02-MANAGER01
ufw allow proto tcp from 54.193.28.160/32 to any port 22
# Allow from IAD02-MANAGER01
ufw allow proto tcp from 54.84.12.149/32 to any port 22


# Allow SSH from the DEV environment for software deployment
ufw allow proto tcp from 184.105.140.178/32 to any port 22

# Allow SSH access from home IPs of Rev admins
# Allow from VICTOR-HOME-IP
ufw allow proto tcp from 73.223.31.210/32 to any port 22
# Allow from JON-HOME-IP-SONIC
ufw allow proto tcp from 157.131.200.6/32 to any port 22
# Allow from JON-HOME-IP-COMCAST
ufw allow proto tcp from 98.207.92.71/32 to any port 22
# Allow from JON2-HOME-IP
ufw allow proto tcp from 72.199.237.160/32 to any port 22


# Allow NRPE port only from monitoring servers
# Allow from SJC02-MONITOR02
ufw allow proto tcp from 54.193.118.76/32 to any port 5666
# Allow from IAD02-MONITOR01
ufw allow proto tcp from 54.88.56.156/32 to any port 5666


# Allow SNMP port only from monitor servers
# Allow from SJC02-MONITOR02
ufw allow proto udp from 54.193.118.76/32 to any port 161
# Allow from IAD02-MONITOR01
ufw allow proto udp from 54.88.56.156/32 to any port 161


# Allow 161/TCP for socat SNMP tunneling from monitor servers
# Allow from SJC02-MONITOR02
ufw allow proto tcp from 54.193.118.76/32 to any port 161
# Allow from IAD02-MONITOR01
ufw allow proto tcp from 54.88.56.156/32 to any port 161



# Allow HTTP and HTTPS ports from everywhere
ufw allow 80/tcp
ufw allow 443/tcp
# Allow QUIC port 443/UDP
ufw allow 443/udp

# Allow configuration and purge management requests from PORTAL and API servers
# Allow from IAD02-PORTAL03
ufw allow proto tcp from 54.164.145.187/32 to any port 8000:8002
# Allow from IAD02-PORTAL02
ufw allow proto tcp from 54.173.43.143/32 to any port 8000:8002
# Allow from IAD02-PORTAL01
ufw allow proto tcp from 54.86.57.22/32 to any port 8000:8002

# Allow from IAD02-API02
ufw allow proto tcp from 54.88.69.242/32 to any port 8000:8002
# Allow from IAD02-API01
ufw allow proto tcp from 54.165.134.123/32 to any port 8000:8002
# Allow from IAD02-API03
ufw allow proto tcp from 54.165.8.28/32 to any port 8000:8002
# Allow from IAD02-STATSAPI01
ufw allow proto tcp from 52.1.122.69/32 to any port 8000:8002

# Allow from IAD02-CDS01
ufw allow proto tcp from 52.20.185.21/32 to any port 8000:8002


# Allow CO ports
ufw allow 18000:18010/tcp
ufw allow 19000:19010/tcp

# Allow 9300/TCP from production ElasticSearch servers
# Allow from IAD02-ES08
ufw allow proto tcp from 52.179.186.250/32 to any port 9300
# Allow from IAD02-ES10
ufw allow proto tcp from 52.177.187.178/32 to any port 9300
# Allow from IAD02-ES11
ufw allow proto tcp from 52.179.159.77/32 to any port 9300
# Allow from IAD02-ES09
ufw allow proto tcp from 52.179.136.136/32 to any port 9300
# Allow from IAD02-ES12
ufw allow proto tcp from 52.225.128.250/32 to any port 9300


ufw enable

/sbin/sysctl -w net.netfilter.nf_conntrack_tcp_be_liberal=1