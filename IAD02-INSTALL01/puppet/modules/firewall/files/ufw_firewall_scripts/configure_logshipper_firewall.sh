#!/bin/bash
#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
#

#
# UFW configuration script for LogShipper servers 
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


# Allow SSH access from BACKUP server
# Allow from SJC02-BACKUP01
ufw allow proto tcp from 54.183.60.157/32 to any port 22


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


# Allow LogShipper API port 8443/TCP port from monitor servers
# Allow from SJC02-MONITOR02
ufw allow proto tcp from 54.193.118.76/32 to any port 8443
# Allow from IAD02-MONITOR01
ufw allow proto tcp from 54.88.56.156/32 to any port 8443



# Allow 5141/UDP log shipping packets from ES servers
# Allow from IAD02-ES08
ufw allow proto udp from 52.179.186.250/32 to any port 5141
# Allow from IAD02-ES10
ufw allow proto udp from 52.177.187.178/32 to any port 5141
# Allow from IAD02-ES11
ufw allow proto udp from 52.179.159.77/32 to any port 5141
# Allow from IAD02-ES09
ufw allow proto udp from 52.179.136.136/32 to any port 5141
# Allow from IAD02-ES12
ufw allow proto udp from 52.225.128.250/32 to any port 5141



ufw enable