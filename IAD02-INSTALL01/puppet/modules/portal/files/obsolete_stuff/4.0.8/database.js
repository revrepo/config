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
                // CMDB04
                // "url"    : "mongodb://54.88.229.205:27017/revportal", 
                // for replica set
                "url"    : "mongodb://IAD02-CMDB01.REVSW.NET:27017/revportal,mongodb://IAD02-CMDB02.REVSW.NET:27017/revportal,mongodb://IAD02-CMDB03.REVSW.NET:27017/revportal",
                "rs"     : true,
                "replicaSet":"CMDB-rs0",
                "aditional_params":"slaveOK=true&readPreference=secondaryPreferred&connectWithNoPrimary=true",
                "safe":true,
                // both journal and fsync should nt be true. either of them should be true
                "journal":true, 
                "fsync":false,
                "w":1,
        },

        "test" : {
                "driver" : "memory"
        },
        "production" : {
                "driver" : "memory"
        }
};
