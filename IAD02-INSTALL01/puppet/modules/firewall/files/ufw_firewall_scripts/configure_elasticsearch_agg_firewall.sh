#!/bin/bash

#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
#

#
# UFW configuration script for ElasticSearch Aggregation servers 
#


UFW=/usr/sbin/ufw

if [ ! -x $UFW ]; then
	echo "FATAL: Cannot find UFW utility at $UFW - aboring."
	exit 1
fi

ufw disable

iptables -F
iptables -X

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


# Allow ElasticSearch 9300/TCP from all ES (non-aggregation) servers
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


# Allow ElasticSearch 9300/TCP from all ES Aggregation servers



# Allow ElasticSearch 9300/TCP access from all MONITOR servers
# Allow from SJC02-MONITOR02
ufw allow proto tcp from 54.193.118.76/32 to any port 9300
ufw allow proto tcp from 54.193.118.76/32 to any port 9400
# Allow from IAD02-MONITOR01
ufw allow proto tcp from 54.88.56.156/32 to any port 9300
ufw allow proto tcp from 54.88.56.156/32 to any port 9400


# Allow ElasticSearch HTTP 9200/TCP port from monitoring servers
# Allow from SJC02-MONITOR02
ufw allow proto tcp from 54.193.118.76/32 to any port 9200
# Allow from IAD02-MONITOR01
ufw allow proto tcp from 54.88.56.156/32 to any port 9200


# Allow ElasticSearch HTTP 9200/TCP port from home IPs of Rev admins
# Allow from VICTOR-HOME-IP
ufw allow proto tcp from 73.223.31.210/32 to any port 9200
# Allow from JON-HOME-IP-SONIC
ufw allow proto tcp from 157.131.200.6/32 to any port 9200
# Allow from JON-HOME-IP-COMCAST
ufw allow proto tcp from 98.207.92.71/32 to any port 9200
# Allow from JON2-HOME-IP
ufw allow proto tcp from 72.199.237.160/32 to any port 9200


# HACK: Allow ElasticSearch 9300/TCP access from IAD02 VPC block 172.31.0.0/16
ufw allow proto tcp from 172.31.0.0/16 to any port 9300

ufw enable