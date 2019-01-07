#!/bin/bash

echo ""

ps -efL|grep /usr/sbin/apache2|grep -v grep|grep -v root|awk '{print $7}'|sort|uniq -c 

echo ""
