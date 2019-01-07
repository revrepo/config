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
                nonce_validate_time:100,
                nonce: false
        },
	use_x_forwarded_for:true,
        is_multiple_collectors: false,
        is_https: true,
	process_res_timing: true,
        request_uuid: true,
        winston_syslog_level:"debug",
        key_path : '/opt/revsw-rum/config/ssl_certs/server.key',
        cert_path : '/opt/revsw-rum/config/ssl_certs/server.crt',
        ca_path : '/opt/revsw-rum/config/ssl_certs/ca_chain.crt',
        cube:[{
                protocol:"ws",domain:"TESTSJC20-CUBE01.REVSW.NET",port:"1080", client : null
        }],

        logging: {
                syslog_level:"debug", // allowed levels debug, info, notice, warning, error, crit, alert, emerg
                debug_log_file_path:"./log/rum.log"
        }
};
