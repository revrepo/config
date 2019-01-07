#!/bin/bash

#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
#

#
# UFW configuration script for INSTALL servers 
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


# Allow SSH from the DEV environment for software deployment
ufw allow proto tcp from 184.105.140.178/32 to any port 22

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


# Allow Puppet master access from all revsw servers
# Allow from ATL02-BP01
ufw allow proto tcp from 45.32.215.96/32 to any port 8140
# Allow from ATL02-BP04
ufw allow proto tcp from 108.61.193.90/32 to any port 8140
# Allow from TLV02-BP02
ufw allow proto tcp from 185.162.124.117/32 to any port 8140
# Allow from LGA02-BP02
ufw allow proto tcp from 209.177.145.102/32 to any port 8140
# Allow from SEA02-BP01.REVSW.NET
ufw allow proto tcp from 45.76.243.51/32 to any port 8140
# Allow from MAA02-BP01
ufw allow proto tcp from 103.6.87.246/32 to any port 8140
# Allow from ATL02-BP05.REVSW.NET
ufw allow proto tcp from 45.32.217.93/32 to any port 8140
# Allow from LGA02-BP08.REVSW.NET
ufw allow proto tcp from 207.148.19.47/32 to any port 8140
# Allow from SJC02-BP03.REVSW.NET
ufw allow proto tcp from 45.32.130.205/32 to any port 8140
# Allow from AMS02-TARANTOOL01
ufw allow proto tcp from 188.166.73.82/32 to any port 8140
# Allow from DEN02-BP01
ufw allow proto tcp from 192.73.242.94/32 to any port 8140
# Allow from AMS02-BP03.REVSW.NET
ufw allow proto tcp from 188.166.67.240/32 to any port 8140
# Allow from IAD02-WEBSITE02
ufw allow proto tcp from 54.174.17.23/32 to any port 8140
# Allow from SJC02-WEBSITE01
ufw allow proto tcp from 54.67.55.175/32 to any port 8140
# Allow from IAD02-WEBSITE01
ufw allow proto tcp from 54.165.244.7/32 to any port 8140
# Allow from SYD02-BP02
ufw allow proto tcp from 108.61.169.23/32 to any port 8140
# Allow from SEA02-BP02.REVSW.NET
ufw allow proto tcp from 104.238.156.56/32 to any port 8140
# Allow from HKG02-BP02
ufw allow proto tcp from 119.81.166.58/32 to any port 8140
# Allow from TYO02-BP02
ufw allow proto tcp from 108.61.182.158/32 to any port 8140
# Allow from IAD02-PORTAL03
ufw allow proto tcp from 54.164.145.187/32 to any port 8140
# Allow from IAD02-RUM03
ufw allow proto tcp from 54.172.30.224/32 to any port 8140
# Allow from IAD02-CUBE03
ufw allow proto tcp from 54.172.75.42/32 to any port 8140
# Allow from IAD02-RMDB03
ufw allow proto tcp from 54.85.218.223/32 to any port 8140
# Allow from IAD02-RMDB02
ufw allow proto tcp from 54.172.87.141/32 to any port 8140
# Allow from IAD02-CMDB03
ufw allow proto tcp from 54.173.56.218/32 to any port 8140
# Allow from IAD02-CMDB02
ufw allow proto tcp from 54.165.240.160/32 to any port 8140
# Allow from IAD02-INSTALL01
ufw allow proto tcp from 54.84.208.124/32 to any port 8140
# Allow from IAD02-CUBE02
ufw allow proto tcp from 54.173.83.181/32 to any port 8140
# Allow from IAD02-RUM02
ufw allow proto tcp from 54.86.35.32/32 to any port 8140
# Allow from IAD02-PORTAL02
ufw allow proto tcp from 54.173.43.143/32 to any port 8140
# Allow from IAD02-CUBE01
ufw allow proto tcp from 54.165.6.24/32 to any port 8140
# Allow from IAD02-RUM01
ufw allow proto tcp from 54.172.236.206/32 to any port 8140
# Allow from IAD02-RMDB01
ufw allow proto tcp from 54.165.210.42/32 to any port 8140
# Allow from SJC02-MANAGER01
ufw allow proto tcp from 54.193.28.160/32 to any port 8140
# Allow from SJC02-BACKUP01
ufw allow proto tcp from 54.183.60.157/32 to any port 8140
# Allow from IAD02-API02
ufw allow proto tcp from 54.88.69.242/32 to any port 8140
# Allow from IAD02-API01
ufw allow proto tcp from 54.165.134.123/32 to any port 8140
# Allow from ORD02-BP03.REVSW.NET
ufw allow proto tcp from 207.148.15.246/32 to any port 8140
# Allow from PHX02-BP01
ufw allow proto tcp from 216.55.176.207/32 to any port 8140
# Allow from IAD02-BP03.REVSW.NET
ufw allow proto tcp from 207.244.104.51/32 to any port 8140
# Allow from SEA02-TARANTOOL01
ufw allow proto tcp from 45.76.242.136/32 to any port 8140
# Allow from IAD02-CMDB01
ufw allow proto tcp from 54.164.33.195/32 to any port 8140
# Allow from IAD02-PORTAL01
ufw allow proto tcp from 54.86.57.22/32 to any port 8140
# Allow from SJC02-MONITOR02
ufw allow proto tcp from 54.193.118.76/32 to any port 8140
# Allow from IAD02-MANAGER01
ufw allow proto tcp from 54.84.12.149/32 to any port 8140
# Allow from IAD02-GRAPHITE01
ufw allow proto tcp from 54.88.166.168/32 to any port 8140
# Allow from IAD02-MONITOR01
ufw allow proto tcp from 54.88.56.156/32 to any port 8140
# Allow from LGA02-TARANTOOL01
ufw allow proto tcp from 159.65.232.100/32 to any port 8140
# Allow from SIN02-TARANTOOL01
ufw allow proto tcp from 128.199.233.174/32 to any port 8140
# Allow from IAD02-API03
ufw allow proto tcp from 54.165.8.28/32 to any port 8140
# Allow from FRA02-TARANTOOL01
ufw allow proto tcp from 185.17.144.70/32 to any port 8140
# Allow from YYZ02-BP01.REVSW.NET
ufw allow proto tcp from 159.89.126.113/32 to any port 8140
# Allow from FRA02-BP05.REVSW.NET
ufw allow proto tcp from 185.17.146.151/32 to any port 8140
# Allow from FRA02-BP07.REVSW.NET
ufw allow proto tcp from 185.17.146.153/32 to any port 8140
# Allow from IAD02-CUBE04
ufw allow proto tcp from 54.175.52.161/32 to any port 8140
# Allow from IAD02-RMDB04
ufw allow proto tcp from 54.174.225.29/32 to any port 8140
# Allow from VICTOR-HOME-IP
ufw allow proto tcp from 73.223.31.210/32 to any port 8140
# Allow from SEL02-BP01.REVSW.NET
ufw allow proto tcp from 52.79.218.223/32 to any port 8140
# Allow from PAR02-BP02
ufw allow proto tcp from 108.61.176.153/32 to any port 8140
# Allow from JON-HOME-IP-SONIC
ufw allow proto tcp from 157.131.200.6/32 to any port 8140
# Allow from PEK02-BP01.REVSW.NET
ufw allow proto tcp from 124.126.126.93/32 to any port 8140
# Allow from SYD02-BP01.REVSW.NET
ufw allow proto tcp from 139.99.178.74/32 to any port 8140
# Allow from MOW02-BP01
ufw allow proto tcp from 37.0.121.199/32 to any port 8140
# Allow from TLV02-BP01
ufw allow proto tcp from 193.182.144.67/32 to any port 8140
# Allow from MAD02-BP01
ufw allow proto tcp from 151.236.23.223/32 to any port 8140
# Allow from IAD02-BP01
ufw allow proto tcp from 199.38.183.15/32 to any port 8140
# Allow from SIN02-BP04
ufw allow proto tcp from 128.199.105.76/32 to any port 8140
# Allow from SAO02-BP02
ufw allow proto tcp from 148.163.220.73/32 to any port 8140
# Allow from ATL02-BP03
ufw allow proto tcp from 108.61.252.22/32 to any port 8140
# Allow from KNA02-BP01
ufw allow proto tcp from 37.235.52.136/32 to any port 8140
# Allow from AMS02-BP02
ufw allow proto tcp from 108.61.199.207/32 to any port 8140
# Allow from FRA02-BP01
ufw allow proto tcp from 104.238.158.63/32 to any port 8140
# Allow from DFW02-BP02
ufw allow proto tcp from 104.238.145.141/32 to any port 8140
# Allow from LGA02-BP01
ufw allow proto tcp from 104.207.134.117/32 to any port 8140
# Allow from SJC02-BP01
ufw allow proto tcp from 45.63.93.77/32 to any port 8140
# Allow from SIN02-BP02
ufw allow proto tcp from 139.59.233.43/32 to any port 8140
# Allow from AMS02-BP01
ufw allow proto tcp from 45.32.186.40/32 to any port 8140
# Allow from TLV02-WPT01
ufw allow proto tcp from 185.162.124.210/32 to any port 8140
# Allow from IAD02-CDS01
ufw allow proto tcp from 52.20.185.21/32 to any port 8140
# Allow from YYZ02-BP03
ufw allow proto tcp from 159.203.9.138/32 to any port 8140
# Allow from ATL02-BP02
ufw allow proto tcp from 45.76.248.177/32 to any port 8140
# Allow from MOW02-BP02
ufw allow proto tcp from 213.183.56.23/32 to any port 8140
# Allow from AMS02-WPT01
ufw allow proto tcp from 52.232.2.133/32 to any port 8140
# Allow from LGA02-BP05
ufw allow proto tcp from 104.156.250.76/32 to any port 8140
# Allow from FRA02-BP03
ufw allow proto tcp from 46.165.253.72/32 to any port 8140
# Allow from LGA02-BP06
ufw allow proto tcp from 45.63.15.243/32 to any port 8140
# Allow from LAX02-BP02
ufw allow proto tcp from 104.207.155.94/32 to any port 8140
# Allow from IAD02-STATSAPI01
ufw allow proto tcp from 52.1.122.69/32 to any port 8140
# Allow from IAD02-ESURL01
ufw allow proto tcp from 40.76.47.69/32 to any port 8140
# Allow from IAD02-LS01
ufw allow proto tcp from 40.76.90.119/32 to any port 8140
# Allow from PDX02-BP01
ufw allow proto tcp from 52.40.96.154/32 to any port 8140
# Allow from TYO02-BP01.REVSW.NET
ufw allow proto tcp from 45.76.199.222/32 to any port 8140
# Allow from MIL02-BP01
ufw allow proto tcp from 149.154.157.189/32 to any port 8140
# Allow from STO02-BP01
ufw allow proto tcp from 178.73.210.197/32 to any port 8140
# Allow from MIA02-BP02
ufw allow proto tcp from 104.207.146.230/32 to any port 8140
# Allow from LON02-BP02
ufw allow proto tcp from 108.61.197.157/32 to any port 8140
# Allow from SJC02-BP02
ufw allow proto tcp from 45.32.128.84/32 to any port 8140
# Allow from DEV-GATEWAY
ufw allow proto tcp from 184.105.140.178/32 to any port 8140
# Allow from IAD02-ESURL02
ufw allow proto tcp from 13.90.210.162/32 to any port 8140
# Allow from JNB02-BP01
ufw allow proto tcp from 154.127.60.162/32 to any port 8140
# Allow from LAS02-BP01
ufw allow proto tcp from 104.238.198.22/32 to any port 8140
# Allow from BLR02-BP01
ufw allow proto tcp from 139.59.11.9/32 to any port 8140
# Allow from SVX02-BP01
ufw allow proto tcp from 185.173.178.66/32 to any port 8140
# Allow from BLR02-BP02
ufw allow proto tcp from 139.59.42.75/32 to any port 8140
# Allow from BLR02-BP03
ufw allow proto tcp from 139.59.42.168/32 to any port 8140
# Allow from BLR02-BP04
ufw allow proto tcp from 139.59.38.233/32 to any port 8140
# Allow from SIN02-BP01
ufw allow proto tcp from 128.199.95.18/32 to any port 8140
# Allow from LON02-BP03.REVSW.NET
ufw allow proto tcp from 139.162.253.101/32 to any port 8140
# Allow from BLR02-BP06
ufw allow proto tcp from 139.59.60.109/32 to any port 8140
# Allow from BLR02-BP07
ufw allow proto tcp from 139.59.17.121/32 to any port 8140
# Allow from SIN02-BP03
ufw allow proto tcp from 128.199.115.161/32 to any port 8140
# Allow from SIN02-BP06
ufw allow proto tcp from 139.59.97.27/32 to any port 8140
# Allow from SIN02-BP05
ufw allow proto tcp from 139.59.116.185/32 to any port 8140
# Allow from BOM02-BP01
ufw allow proto tcp from 52.66.166.83/32 to any port 8140
# Allow from VIE02-BP01
ufw allow proto tcp from 158.255.211.3/32 to any port 8140
# Allow from IAD02-ES08
ufw allow proto tcp from 52.179.186.250/32 to any port 8140
# Allow from BLR02-BP05
ufw allow proto tcp from 139.59.15.4/32 to any port 8140
# Allow from LGA02-ESURL01
ufw allow proto tcp from 45.63.6.120/32 to any port 8140
# Allow from LGA02-BP07
ufw allow proto tcp from 45.63.4.39/32 to any port 8140
# Allow from FRA02-BP06.REVSW.NET
ufw allow proto tcp from 46.165.252.121/32 to any port 8140
# Allow from VIE02-BP02
ufw allow proto tcp from 149.154.152.46/32 to any port 8140
# Allow from MAA02-WPT01
ufw allow proto tcp from 13.71.121.136/32 to any port 8140
# Allow from ATL02-TARANTOOL01
ufw allow proto tcp from 45.32.212.76/32 to any port 8140
# Allow from LGA02-BP09.REVSW.NET
ufw allow proto tcp from 207.148.25.109/32 to any port 8140
# Allow from LAX02-BP01
ufw allow proto tcp from 45.77.68.109/32 to any port 8140
# Allow from SJC02-TARANTOOL01
ufw allow proto tcp from 45.77.187.69/32 to any port 8140
# Allow from BLR02-BP03.REVSW.NET
ufw allow proto tcp from 139.59.42.168/32 to any port 8140
# Allow from LGA02-BP03
ufw allow proto tcp from 67.205.184.172/32 to any port 8140
# Allow from FRA02-BP02
ufw allow proto tcp from 149.154.159.169/32 to any port 8140
# Allow from IAD02-ES10
ufw allow proto tcp from 52.177.187.178/32 to any port 8140
# Allow from DFW02-BP01
ufw allow proto tcp from 45.76.232.233/32 to any port 8140
# Allow from IAD02-ES11
ufw allow proto tcp from 52.179.159.77/32 to any port 8140
# Allow from IAD02-ES09
ufw allow proto tcp from 52.179.136.136/32 to any port 8140
# Allow from IAD02-ES12
ufw allow proto tcp from 52.225.128.250/32 to any port 8140
# Allow from ORD03-LS01
ufw allow proto tcp from 52.240.145.54/32 to any port 8140
# Allow from IAD02-BP02
ufw allow proto tcp from 207.244.68.192/32 to any port 8140
# Allow from GRZ02-BP01
ufw allow proto tcp from 151.236.30.26/32 to any port 8140
# Allow from HKG02-BP01
ufw allow proto tcp from 47.52.75.193/32 to any port 8140
# Allow from ORD02-BP02
ufw allow proto tcp from 45.76.28.203/32 to any port 8140
# Allow from SJC02-WT01
ufw allow proto tcp from 40.83.145.95/32 to any port 8140
# Allow from SJC02-WPT-SERVER01
ufw allow proto tcp from 13.64.159.148/32 to any port 8140
# Allow from SJC02-WPT01
ufw allow proto tcp from 13.64.79.16/32 to any port 8140
# Allow from FRA02-BP08.REVSW.NET
ufw allow proto tcp from 185.17.146.150/32 to any port 8140
# Allow from MIA02-BP01
ufw allow proto tcp from 45.77.162.26/32 to any port 8140
# Allow from SJC02-WPT02
ufw allow proto tcp from 13.91.2.9/32 to any port 8140
# Allow from ORD02-TARANTOOL01
ufw allow proto tcp from 45.63.65.149/32 to any port 8140
# Allow from DFW02-TARANTOOL01
ufw allow proto tcp from 23.239.29.32/32 to any port 8140
# Allow from IAD02-TARANTOOL01
ufw allow proto tcp from 207.244.103.147/32 to any port 8140
# Allow from SYD02-TARANTOOL01.REVSW.NET
ufw allow proto tcp from 207.148.83.228/32 to any port 8140
# Allow from JON-HOME-IP-COMCAST
ufw allow proto tcp from 98.207.92.71/32 to any port 8140
# Allow from FRA02-BP04.REVSW.NET
ufw allow proto tcp from 185.17.146.152/32 to any port 8140
# Allow from JON2-HOME-IP
ufw allow proto tcp from 72.199.237.160/32 to any port 8140
# Allow from PHX02-BP02.REVSW.NET
ufw allow proto tcp from 69.64.74.182/32 to any port 8140
# Allow from ZUH02-BP01.REVSW.NET
ufw allow proto tcp from 183.61.10.145/32 to any port 8140


# Allow HTTP and HTTPS ports from everywhere
ufw allow 80/tcp
ufw allow 443/tcp

ufw enable