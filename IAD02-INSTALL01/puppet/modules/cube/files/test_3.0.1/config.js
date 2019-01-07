/*
#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
# 
*/


module.exports = {
        logging: {
                //is_debug_mode_on: false,
                syslog_level:"debug", // allowed levels debug, info, notice, warning, error, crit, alert, emerg
                debug_log_file_path:"/opt/revsw-cube/log/cube.log"
        }
};
