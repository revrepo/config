/*
#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
# 
*/


module.exports = {
  "mongo-host": ["TESTSJC20-RMDB01.REVSW.NET"],
  "mongo-port": [27017],
  "is_replica_set": true,
  "replica_set_name":"RMDB-rs0",
  "aditional_params":"slaveOK=true&readPreference=secondaryPreferred&connectWithNoPrimary=true",
//  "full_connection_string":"mongodb://54.173.88.238:27017/cube_development?replicaSet=rs0&slaveOK=true&readPreference=secondaryPreferred&connectWithNoPrimary=true&safe=true&journal=true&w=2",
  "mongo-database": "cube_development",
  "safe_mode":true,
  "auto_reconnect":true,
  "mongo-username": "revuser_prod",
  "mongo-password": "1QaZTech135",
  "http-port": 1081
};
