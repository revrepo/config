#!/bin/bash
#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
#

# curator daily cronjob, removing old indices
#/usr/local/bin/curator --dry-run delete indices --older-than 3 --time-unit days --prefix logstash --timestring '%Y.%m.%d' >> /var/log/elasticsearch/esurl_curator.log
/usr/local/bin/curator delete indices --older-than 3 --time-unit days --prefix logstash --timestring '%Y.%m.%d' >> /var/log/elasticsearch/esurl_curator.log
