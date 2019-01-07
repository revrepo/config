#!/bin/bash

R=`netstat -s|grep 'segments retransmited'|awk '{print $1}'`
S=`netstat -s|grep 'segments send out'|awk '{print $1}'`

echo "scale=3; $R / $S * 100" | bc

