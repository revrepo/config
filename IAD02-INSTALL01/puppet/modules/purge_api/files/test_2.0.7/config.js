/*
#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
# 
*/

module.exports = {
        service: {
                url: "0.0.0.0",
                https_port:443,
                http_port:80,
        },
        is_https: true,
	key_path:"/opt/revsw-api/config/ssl_certs/server.key",
	cert_path:"/opt/revsw-api/config/ssl_certs/server.crt",
	ca_path:"/opt/revsw-api/config/ssl_certs/ca_chain.crt",
        use_x_forwarded_for:true,
        portal_mongo:{
                url: "TESTSJC20-CMDB01.REVSW.NET",
                port:"27017",
                database:"revportal?replicaSet=CMDB-rs0",
                is_auth_required: false,
                username: "revuser_prod",
                password: "1QaZTech135",
                user_collection:'User',
                domain_collection:'Domain'
        },
        local_mongo:{
                url: "TESTSJC20-CMDB01.REVSW.NET",
                port:"27017",
                database:"purgejobs?replicaSet=CMDB-rs0",
                is_auth_required: false,
                username: "revuser_prod",
                password: "1QaZTech135",
                purge_jobs_collection:'purge_jobs'
        },
	logging: {
                syslog_level:"debug", // allowed levels debug, info, notice, warning, error, crit, alert, emerg
                debug_log_file_path:"/opt/revsw-api/log/api.log"
        }
};
