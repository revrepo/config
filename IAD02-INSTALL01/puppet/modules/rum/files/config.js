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
        key_path : '/opt/revsw-rum/config/ssl_certs/server.key',
        cert_path : '/opt/revsw-rum/config/ssl_certs/server.crt',
        ca_path : '/opt/revsw-rum/config/ssl_certs/ca_chain.crt',
        cube:[{
                protocol:"ws",domain:"cube.revdn.net",port:"1080", client : null
        }]
};
