/*
#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
# 
*/

// Default configuration for development.
module.exports = {
  "mongo-host": "TESTSJC20-CMDB01.REVSW.NET",
  "mongo-port": 27017,
  "mongo-database": "revportal?replicaSet=CMDB-rs0&readPreference=secondaryPreferred",
  "mongo-username": null,
  "mongo-password": null,
  "http-port": 1081
};
