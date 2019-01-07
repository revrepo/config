#!/bin/bash
#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
#

#
# UFW configuration script for CUBE servers 
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


# Allow CUBE 1080/TCP port from RUM servers
# Allow from IAD02-RUM03
ufw allow proto tcp from 54.172.30.224/32 to any port 1080
# Allow from IAD02-RUM02
ufw allow proto tcp from 54.86.35.32/32 to any port 1080
# Allow from IAD02-RUM01
ufw allow proto tcp from 54.172.236.206/32 to any port 1080


# Allow CUBE 1081/TCP port from PORTAL servers
# Allow from IAD02-PORTAL03
ufw allow proto tcp from 54.164.145.187/32 to any port 1081
# Allow from IAD02-PORTAL02
ufw allow proto tcp from 54.173.43.143/32 to any port 1081
# Allow from IAD02-PORTAL01
ufw allow proto tcp from 54.86.57.22/32 to any port 1081


# Allow CUBE 1080/TCP and 1081/TCP ports from MONITOR servers
# Allow from SJC02-MONITOR02
ufw allow proto tcp from 54.193.118.76/32 to any port 1080
ufw allow proto tcp from 54.193.118.76/32 to any port 1081
# Allow from IAD02-MONITOR01
ufw allow proto tcp from 54.88.56.156/32 to any port 1080
ufw allow proto tcp from 54.88.56.156/32 to any port 1081


# Open access to 1080/TCP and 1081/TCP from the VPC subnet 172.31.0.0/16 so ELB could monitor the CUBE services
ufw allow proto tcp from 172.31.0.0/16 to any port 1080:1081

ufw enable