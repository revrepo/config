/*
#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
# 
*/


//for heatmap cron log directory path
exports.heatMapLog = {
    path:"/opt/revsw-portal/log/heatmapErr.log"
}

//for device browsers cron log directory path
exports.deviceBrowsersLog = {
    path:"/opt/revsw-portal/log/deviceBrowsersErr.log"
}

// for elastic search
exports.elastic_search_adapter = {
    url:"http://iad02-es-api.revsw.net:9200/"
}

// for default values
exports.default_details = {
    default_rum_url:"https://rum01.revsw.net/service",
    default_evalutor_url:"http://cube-02-prod-sjc.revsw.net:1081/",
    default_bp_servers:"sjc02-bp01.revsw.net,sea02-bp01.revsw.net,ord02-bp01.revsw.net,dfw02-bp01.revsw.net,lga02-bp01.revsw.net,mia02-bp01.revsw.net,lon02-bp01.revsw.net,ams02-bp01.revsw.net,par02-bp01.revsw.net,fra02-bp01.revsw.net,maa02-bp01.revsw.net,sao02-bp01.revsw.net,lax03-bp01.revsw.net,lax02-bp01.revsw.net,yyz02-bp01.revsw.net,den02-bp01.revsw.net,phx02-bp01.revsw.net,atl02-bp01.revsw.net,tyo02-bp02.revsw.net,hkg02-bp02.revsw.net,sin02-bp02.revsw.net,syd02-bp02.revsw.net,iad02-bp02.revsw.net",
    default_co_servers:"ord02-co01.revsw.net,dfw02-co01.revsw.net,phx02-co01.revsw.net,sjc02-co01.revsw.net,lax02-co01.revsw.net,lon02-co01.revsw.net,lga02-co01.revsw.net,ams02-co01.revsw.net,iad02-co02.revsw.net,hkg02-co02.revsw.net"
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
    url:["IAD02-RMDB01.REVSW.NET","IAD02-RMDB01.REVSW.NET","IAD02-RMDB01.REVSW.NET"],
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
    url:["IAD02-CMDB01.REVSW.NET","IAD02-CMDB01.REVSW.NET","IAD02-CMDB01.REVSW.NET"],
    port:[27017,27017,27017],
    is_replica_set: true,
    replica_set_name:"CMDB-rs0",
    database:"revportal",
    //full_connection_string:"mongodb://54.164.198.250:27017,54.164.31.156:27017,54.173.83.184:27017/cube_development?replicaSet=diabloreplica&slaveOK=true&readPreference=secondaryPreferred&connectWithNoPrimary=true&safe=true&journal=true&fsync=false&w=1",
    aditional_params:"slaveOk=true&connectWithNoPrimary=true&secondaryPreferred=true",
    is_auth_required: false,
    username: "revuser_prod",
    password: "1QaZTech135",
    heatmap_job_collection:'HeatMapJobDetail',
    heatmap_job_time_out:10, // this should be in hours
    heatmap_fail_job_time_out:10, // this should be in minutes
    heatmap_job_sleep_time:5 // this s hould be in seconds
}


//for forgot password and email
exports.forgot_pwd = {
    url:"https://portal.revsw.net/forgot_pwd.html",
    validate_time:10,
    portal_url:"https://portal.revsw.net/",
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