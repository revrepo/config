#!/bin/bash

#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
#

#
# UFW configuration script for configuration MongoDB (CMDB) servers
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


# Allow MDB Access from other CMDB servers
# Allow from IAD02-CMDB03
ufw allow proto tcp from 54.173.56.218/32 to any port 27017
ufw allow proto tcp from 54.173.56.218/32 to any port 28017
# Allow from IAD02-CMDB02
ufw allow proto tcp from 54.165.240.160/32 to any port 27017
ufw allow proto tcp from 54.165.240.160/32 to any port 28017
# Allow from IAD02-CMDB01
ufw allow proto tcp from 54.164.33.195/32 to any port 27017
ufw allow proto tcp from 54.164.33.195/32 to any port 28017


# Allow MDB Access from API servers
# Allow from IAD02-API02
ufw allow proto tcp from 54.88.69.242/32 to any port 27017
ufw allow proto tcp from 54.88.69.242/32 to any port 28017
# Allow from IAD02-API01
ufw allow proto tcp from 54.165.134.123/32 to any port 27017
ufw allow proto tcp from 54.165.134.123/32 to any port 28017
# Allow from IAD02-API03
ufw allow proto tcp from 54.165.8.28/32 to any port 27017
ufw allow proto tcp from 54.165.8.28/32 to any port 28017
# Allow from IAD02-STATSAPI01
ufw allow proto tcp from 52.1.122.69/32 to any port 27017
ufw allow proto tcp from 52.1.122.69/32 to any port 28017


# Allow MDB Access from CDS servers
# Allow from IAD02-CDS01
ufw allow proto tcp from 52.20.185.21/32 to any port 27017
ufw allow proto tcp from 52.20.185.21/32 to any port 28017


# Allow MDB Access from PORTAL servers
# Allow from IAD02-PORTAL03
ufw allow proto tcp from 54.164.145.187/32 to any port 27017
ufw allow proto tcp from 54.164.145.187/32 to any port 28017
# Allow from IAD02-PORTAL02
ufw allow proto tcp from 54.173.43.143/32 to any port 27017
ufw allow proto tcp from 54.173.43.143/32 to any port 28017
# Allow from IAD02-PORTAL01
ufw allow proto tcp from 54.86.57.22/32 to any port 27017
ufw allow proto tcp from 54.86.57.22/32 to any port 28017


# Allow MDB Access from MONITOR servers
# Allow from SJC02-MONITOR02
ufw allow proto tcp from 54.193.118.76/32 to any port 27017
ufw allow proto tcp from 54.193.118.76/32 to any port 28017
# Allow from IAD02-MONITOR01
ufw allow proto tcp from 54.88.56.156/32 to any port 27017
ufw allow proto tcp from 54.88.56.156/32 to any port 28017


# Allow MDB Access from LS servers
# Allow from IAD02-LS01
ufw allow proto tcp from 40.76.90.119/32 to any port 27017
ufw allow proto tcp from 40.76.90.119/32 to any port 28017
# Allow from ORD03-LS01
ufw allow proto tcp from 52.240.145.54/32 to any port 27017
ufw allow proto tcp from 52.240.145.54/32 to any port 28017


ufw enable