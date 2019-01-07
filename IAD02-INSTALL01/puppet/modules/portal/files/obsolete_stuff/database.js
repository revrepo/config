
/*
#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
# 
*/


module.exports = {
        "development" : {
                "driver" : "mongodb",
                "url"    : "mongodb://IAD02-CMDB01.REVSW.NET:27017/revportal?replicaSet=CMDB-rs0&readPreference=secondaryPreferred"
        },
        "test" : {
                "driver" : "memory"
        },
        "production" : {
                "driver" : "memory"
        }
};
