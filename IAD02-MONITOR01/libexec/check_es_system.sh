#!/bin/bash 
################################################################################
# Script:       check_es_system.sh                                              #
# Author:       Claudio Kuenzler www.claudiokuenzler.com                       #
# Purpose:      Monitor ElasticSearch Store (Disk) Usage                       #
# Licence:      GPLv2                                                          #
# Licence :     GNU General Public Licence (GPL) http://www.gnu.org/           #
# This program is free software; you can redistribute it and/or                #
# modify it under the terms of the GNU General Public License                  #
# as published by the Free Software Foundation; either version 2               #
# of the License, or (at your option) any later version.                       #
#                                                                              #
# This program is distributed in the hope that it will be useful,              #
# but WITHOUT ANY WARRANTY; without even the implied warranty of               #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                #
#                                                                              #
# GNU General Public License for more details.                                 #
#                                                                              #
# You should have received a copy of the GNU General Public License            #
# along with this program; if not, write to the Free Software                  #
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA                #
# 02110-1301, USA.                                                             #
#                                                                              #
# History:                                                                     #
# 20160429: Started programming plugin                                         #
# 20160601: Continued programming. Working now as it should =)                 #
# 20160906: Added memory usage check, check types option (-t)                  #
# 20160906: Renamed plugin from check_es_store to check_es_system              #
# 20160907: Change internal referenced variable name for available size        #
# 20160907: Output now contains both used and available sizes                  #
################################################################################
#Variables and defaults
STATE_OK=0              # define the exit code if status is OK
STATE_WARNING=1         # define the exit code if status is Warning
STATE_CRITICAL=2        # define the exit code if status is Critical
STATE_UNKNOWN=3         # define the exit code if status is Unknown
export PATH=$PATH:/usr/local/bin:/usr/bin:/bin # Set path
port=9200
httpscheme=http
unit=G
warning=80
critical=95
################################################################################
#Functions 
help () {
echo -e "$0  (c) 2016-$(date +%Y) Claudio Kuenzler (published under GPL licence)

Usage: ./check_es_system.sh -H ESNode [-p port] [-S] [-u user] [-p pass] -d available [-o unit] [-w warn] [-c crit]

Options: 

   * -H Hostname or ip address of ElasticSearch Node
     -P Port (defaults to 9200)
     -S Use https
     -u Username if authentication is required
     -p Password if authentication is required
   * -d Available size of disk or memory (ex. 20)
   * -t Type of check (disk|mem)
     -o Disk space unit (K|M|G) (defaults to G)
     -w Warning threshold in percent (default: 80)
     -c Critical threshold in percent (default: 95)
     -h Help!

*mandatory options

Requirements: curl, jshon, expr" 
exit $STATE_UNKNOWN;
}

authlogic () {
if [[ -z $user ]] && [[ -z $pass ]]; then echo "ES SYSTEM UNKNOWN - Authentication required but missing username and password"; exit $STATE_UNKNOWN
elif [[ -n $user ]] && [[ -z $pass ]]; then echo "ES SYSTEM UNKNOWN - Authentication required but missing password"; exit $STATE_UNKNOWN
elif [[ -n $pass ]] && [[ -z $user ]]; then echo "ES SYSTEM UNKNOWN - Missing username"; exit $STATE_UNKNOWN
fi
}

unitcalc() {
# ES presents the currently used disk space in Bytes
if [[ -n $unit ]]; then 
  case $unit in 
    K) availsize=$(expr $available \* 1024); outputsize=$(expr ${size} / 1024);;
    M) availsize=$(expr $available \* 1024 \* 1024); outputsize=$(expr ${size} / 1024 / 1024);;
    G) availsize=$(expr $available \* 1024 \* 1024 \* 1024); outputsize=$(expr ${size} / 1024 / 1024 / 1024);;
  esac
  if [[ -n $warning ]] ; then
    warningsize=$(expr $warning \* ${availsize} / 100) 
  fi
  if [[ -n $critical ]] ; then
    criticalsize=$(expr $critical \* ${availsize} / 100) 
  fi
  usedpercent=$(expr $size \* 100 / $availsize)
else echo "UNKNOWN - Shouldnt exit here. No units given"; exit $STATE_UNKNOWN
fi
}
################################################################################
# Check requirements
for cmd in curl jshon expr; do 
 if ! `which ${cmd} 1>/dev/null`; then
   echo "UNKNOWN: ${cmd} does not exist, please check if command exists and PATH is correct"
   exit ${STATE_UNKNOWN}
 fi
done
################################################################################
# Check for people who need help - aren't we all nice ;-)
if [ "${1}" = "--help" -o "${#}" = "0" ]; then help; exit $STATE_UNKNOWN; fi
################################################################################
# Get user-given variables
while getopts "H:P:Su:p:d:o:w:c:t:" Input;
do
  case ${Input} in
  H)      host=${OPTARG};;
  P)      port=${OPTARG};;
  S)      httpscheme=https;;
  u)      user=${OPTARG};;
  p)      pass=${OPTARG};;
  d)      available=${OPTARG};;
  o)      unit=${OPTARG};;
  w)      warning=${OPTARG};;
  c)      critical=${OPTARG};;
  t)      checktype=${OPTARG};;
  *)      help;;
  esac
done

# Check for mandatory opts
if [ -z ${host} ] || [ -z ${available} ]; then help; exit $STATE_UNKNOWN; fi
################################################################################
# Do the check
esurl="${httpscheme}://${host}:${port}/_cluster/stats"
esstatus=$(curl -k -s $esurl)

#if [[ -n $(echo $esstatus | grep -i authentication) ]]; then
#  # Authentication required
#  authlogic
#  esstatus=$(curl -s --basic -u ${user}:${pass} $esurl)
#  if [[ -n $(echo $esstatus | grep -i authentication) ]]; then
#    echo "ES SYSTEM CRITICAL - Unable to authenticate user $user for REST request"
#    exit $STATE_CRITICAL
#  fi

case $checktype in
disk) # Check disk usage
  size=$(echo $esstatus | jshon -e indices -e store -e "size_in_bytes")
  unitcalc
  if [ -n "${warning}" ] || [ -n "${critical}" ]; then 
    # Handle tresholds
    if [ $size -ge $criticalsize ]; then 
      echo "ES SYSTEM CRITICAL - Disk usage is at ${usedpercent}% ($outputsize $unit from $available $unit)|es_disk=${size}B;${warningsize};${criticalsize};;"
      exit $STATE_CRITICAL
    elif [ $size -ge $warningsize ]; then 
      echo "ES SYSTEM WARNING - Disk usage is at ${usedpercent}% ($outputsize $unit from $available $unit)|es_disk=${size}B;${warningsize};${criticalsize};;"
      exit $STATE_CRITICAL
    else
      echo "ES SYSTEM OK - Disk usage is at ${usedpercent}% ($outputsize $unit from $available $unit)|es_disk=${size}B;${warningsize};${criticalsize};;"
      exit $STATE_OK
    fi
  else 
    # No thresholds
    echo "ES SYSTEM OK - Disk usage is at ${usedpercent}% ($outputsize $unit from $available $unit)|es_disk=${size}B;;;;"
    exit $STATE_OK
  fi
  ;;

mem) # Check memory usage
  size=$(echo $esstatus | jshon -e nodes -e jvm -e mem -e "heap_used_in_bytes")
  unitcalc
  if [ -n "${warning}" ] || [ -n "${critical}" ]; then 
    # Handle tresholds
    if [ $size -ge $criticalsize ]; then 
      echo "ES SYSTEM CRITICAL - Memory usage is at ${usedpercent}% ($outputsize $unit) from $available $unit|es_memory=${size}B;${warningsize};${criticalsize};;"
      exit $STATE_CRITICAL
    elif [ $size -ge $warningsize ]; then 
      echo "ES SYSTEM WARNING - Memory usage is at ${usedpercent}% ($outputsize $unit from $available $unit)|es_memory=${size}B;${warningsize};${criticalsize};;"
      exit $STATE_CRITICAL
    else
      echo "ES SYSTEM OK - Memory usage is at ${usedpercent}% ($outputsize $unit from $available $unit)|es_memory=${size}B;${warningsize};${criticalsize};;"
      exit $STATE_OK
    fi
  else 
    # No thresholds
    echo "ES SYSTEM OK - Memory usage is at ${usedpercent}% ($outputsize $unit from $available $unit)|es_memory=${size}B;;;;"
    exit $STATE_OK
  fi
  ;;

*) help
esac
       

fi

