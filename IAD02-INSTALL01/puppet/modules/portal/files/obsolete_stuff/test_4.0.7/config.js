/*
#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
# 
*/

//for heatmap cron log directory path
exports.HeatMapJob = {
    err_log_path:"/opt/revsw-portal/log/heatmapErr.log",
    heatmap_job_collection:'HeatMapJobDetail',
    heatmap_job_time_out:10, // this should be in hours
    heatmap_fail_job_time_out:30, // this should be in minutes
    heatmap_job_sleep_time:20 // this s hould be in seconds
}

//for device browsers cron log directory path
exports.deviceBrowsersLog = {
    path:"/opt/revsw-portal/log/deviceBrowsersErr.log"
}

// for elastic search
exports.elastic_search_adapter = {
    url:"http://testsjc20-es01.revsw.net:9200/"
}

// for default values
exports.default_details = {
    default_rum_url:"https://testsjc20-rum01.revsw.net/service",
    default_evalutor_url:"http://testsjc20-cube01.revsw.net:1081/",
    default_bp_servers:"testsjc20-bp01.revsw.net,testsjc20-bp02.revsw.net",
    default_co_servers:"testsjc20-co01.revsw.net"
}

//for ssl certificates
exports.ssl_certificates = {
    is_https:true,
    key:"/opt/revsw-portal/config/ssl/server.key",
    cert:"/opt/revsw-portal/config/ssl/server.crt",
    ca:"/opt/revsw-portal/config/ssl/ca_chain.crt"
}

// For DNS API
exports.dns_api = {
    url: "https://dns-api.revsw.net",
    usr_pwd:"portal:Sy9vFXnUeVn9"
}

//for mongo constants
exports.mongo = {
    url:["TESTSJC20-RMDB01.REVSW.NET","TESTSJC20-RMDB02.REVSW.NET"],
    port:[27017,27017,27017],
    is_replica_set: true,
    replica_set_name:"RMDB-rs0",
    database:"cube_development",
    is_auth_required: false,
    username: "revuser_prod",
    password: "1QaZTech135",
    event_collection:'pl_info_events'
}

exports.portalMongo = {
    url:["TESTSJC20-CMDB01.REVSW.NET","TESTSJC20-CMDB02.REVSW.NET"],
    port:[27017,27017,27017],
    is_replica_set: true,
    replica_set_name:"CMDB-rs0",
    database:"revportal",
    //full_connection_string:"mongodb://54.164.198.250:27017,54.164.31.156:27017,54.173.83.184:27017/cube_development?replicaSet=diabloreplica&slaveOK=true&readPreference=secondaryPreferred&connectWithNoPrimary=true&safe=true&journal=true&fsync=false&w=1",
    aditional_params:"slaveOk=true&connectWithNoPrimary=true&secondaryPreferred=true",
    is_auth_required: false,
    username: "revuser_prod",
    password: "1QaZTech135",
}


//for forgot password and email
exports.forgot_pwd = {
    url:"https://testsjc20-portal01.revsw.net/forgot_pwd.html",
    validate_time:10,
    portal_url:"https://testsjc20-portal01.revsw.net/",
    support_url:"support@revsw.com",
    email_from:"no-reply@revsw.com",
    heatmap_from:"techrevsw@gmail.com",
    pswd_techmail:"techvrevsw"
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

module.exports.tokenArr = {
        "tokens":[
                     {'name':'portal-qa.revsw.net','token':'12345678'},
                     {'name':'portal-internal.revsw.net','token':'12345678'},
                     {'name':'portal.revsw.net','token':'12345678'},
                     {'name':'portal.dev.revsw.net','token':'12345678'}
                 ]
};

module.exports.logging = {

        logging: {
                syslog_level:"debug", // allowed levels debug, info, notice, warning, error, crit, alert, emerg
                debug_log_file_path:"/opt/revsw-portal/log/portal.log"
        }
};

// generic settings
exports.general = {
  master_password: '8cdea34a9c582e10940da5beb29b4597'
}
