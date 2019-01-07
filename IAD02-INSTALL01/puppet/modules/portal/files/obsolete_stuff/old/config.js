/*
#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
# 
*/

//for ssl certificates
exports.ssl_certificates = {
        is_https:true,
        key:"/opt/revsw-portal/config/ssl/server.key",
        cert:"/opt/revsw-portal/config/ssl/server.crt",
        ca:"/opt/revsw-portal/config/ssl/ca_chain.crt"
}


//for mongo constants
exports.mongo = {
        url: "IAD02-RMDB01.REVSW.NET",
        port:"27017",
        database:"cube_development?replicaSet=RMDB-rs0&readPreference=secondaryPreferred",
        username: "revuser_prod",
        password: "1QaZTech135",
        event_collection:'pl_info_events'
}

//for forgot password
exports.forgot_pwd = {
        url:"https://portal.revsw.net/forgot_pwd.html",
        validate_time:10,
}

exports.settings = {
        // Network time
        nw_time : "1.0/metric?expression=median(pl_info(networkTime))",
        // BrowserTime
        br_time : "1.0/metric?expression=median(pl_info(browserTime))",
        // BackendTime
        bd_time : "1.0/metric?expression=median(pl_info(backendTime))",
        // PageLoadTime
        page_load_time : "1.0/metric?expression=median(pl_info(pageloadTime))",

        step :{ "10sec": "1e4",
                    "1min" : "6e4",
                        "5min" : "3e5",
                        "1hr"  : "36e5",
                        "1day" : "864e5"
                  }
};

//for device browser cron log directory path
exports.deviceBrowsersLog = {
        path:"/opt/revsw-portal/log/deviceBrowsersErr.log"
}
//for heatmap cron log directory path
module.exports.heatMapLog = {
        path:"/opt/revsw-portal/log/heatmapErr.log"
};

module.exports.tokenArr = {
        "tokens":[
                 {'name':'portal-qa.revsw.net','token':'12345678'},
                 {'name':'portal-internal.revsw.net','token':'12345678'},
                 {'name':'portal.revsw.net','token':'12345678'},
                 {'name':'portal.dev.revsw.net','token':'12345678'}
                 ]
};
