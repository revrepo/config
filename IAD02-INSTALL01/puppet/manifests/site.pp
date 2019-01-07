#
# Test infrastructure
#

node /^testsjc20-xen(01|02|03|04|05|08|09).revsw.net$/ {
	include test_xen_servers
}

node /^testsjc20-build02\.revsw\.net$/ {
	include default_server
	include build::basic_packages
	include users::qa_users
	include system::test_qa_lab_apt_cache_conf
#	include test_bp_nginx_servers2
}

node /^testsjc20-build(01|02)\.revsw\.net$/ {
	include default_server
	include build::basic_packages
	include users::qa_users
	include system::test_qa_lab_apt_cache_conf
}

node 'SJC02-WPT-SERVER01.REVSW.NET' {
	include wpt-server_servers
}

node 'dev-gateway.revsw.net' {
	include default_server
	include amanda::client_configuration
}

node 'sjc02-wt01.revsw.net' {
	include webtest_servers
}

node /^testsjc20-ls01\.revsw\.net$/ {
	include test_logshipper_servers
}

node /^testsjc20-statsapi01\.revsw\.net$/ {
	include test_stats_api_servers
}

node /^testsjc20-portal01\.revsw\.net$/ {
	include test_portal_servers
}

node /^testsjc20-rum(01|02|03)\.revsw\.net$/ {
	include test_rum_servers
}

node /^testsjc20-cube(01|02|03)\.revsw\.net$/ {
	include test_cube_servers
}

node /^testsjc20-api(01|02)\.revsw\.net$/ {
	include test_api_servers
	include revsw-api::test_revsw-api
}

node /^testsjc20-cds(01|02)\.revsw\.net$/ {
        include test_cds_servers
}

node /^testsjc20-cmdb(01|02|03).revsw.net$/ {
	include test_cmdb_servers
	include amanda::client_configuration
}

node /^testsjc20-rmdb(01|02|03).revsw.net$/ {
	include test_rmdb_servers
	include amanda::client_configuration
}

node /^testsjc20-es(01|02|03).revsw.net$/ {
	include test_es_servers
}

node /^testsjc20-esurl(01|02|03).revsw.net$/ {
	include test_esurl_servers
}

node 'testsjc20-jenkins01.revsw.net' {
	include test_jenkins_servers
}

node /^testsjc20-bp(01|02|03|04|06|07)\.revsw\.net$/ {
        include test_bp_nginx_servers2
}

node /^testsjc20-bp(01|02|03|04|05|06|07|08|09|10)\.revsw\.net$/ {
        include test_bp_nginx_servers2
}

node /^testsjc20-website01.revsw.net$/ {
	include test_website_servers
}

node /^testsjc20-website02.revsw.net$/ {
	include test_website_servers_new
}

node /^testsjc20-victordev01.revsw.net$/ {
	include default_server
	include users::qa_users
}

node /^testsjc20-install01.revsw.net$/ {
	include default_server
	include users::qa_users
	include users::robot
}

node /^testsjc20-manager01.revsw.net$/ {
	include default_server
	include users::qa_users
	include users::robot
}

node /^testsjc20-monitor01.revsw.net$/ {
	include default_server
	include users::qa_users
	include users::robot
}


#
# Production servers
#

node /^(atl02|sjc02|ams02|sea02|ord02|lga02|dfw02|sin02|iad02|fra02|syd02)-tarantool(01|02|03|04|05|08|09).revsw.net$/ {
	include tarantool_servers
}

node /^iad02-statsapi01\.revsw\.net$/ {
	include stats_api_servers
}

node 'sjc02-backup01.revsw.net' {
        include amanda_backup_servers
}

node /^(iad02|ord03)-ls(01|02).revsw.net$/ {
        include logshipper_servers
}

node /^iad02-cds(01|02).revsw.net$/ {
	include cds_servers
}

node /^iad02-api(01|02|03).revsw.net$/ {
	include api_servers
}

node /^iad02-es(05|06).revsw.net$/ {
	include default_server
	include firewall::elasticsearch
	include logstash::logstash_app
}

node /^iad02-es(08|09|10|11|12).revsw.net$/ {
	include logstash::logstash_app
        include es_servers
}

node /^(iad02)-esurl(01|02|03|04).revsw.net$/ {
        include esurl_servers
}

node /^(iad02|sjc02)-website(01|02|03).revsw.net$/ {
       include website_servers
}

node /^iad02-rum(01|02).revsw.net$/ {
	include rum_servers
        include rum::rum_app_3_0
}

node /^iad02-rum(03).revsw.net$/ {
	include rum_servers
	include rum::rum_app
}

node /^iad02-cube(01|02|03|04).revsw.net$/ {
	include cube_servers
	include cube::cube_app
}

node /^iad02-rmdb04.revsw.net$/ {
       include default_server
	include mongodb::report_mongodb_stats_to_graphite
	include system::resolv_conf_management
}

node /^iad02-rmdb(01|02|03).revsw.net$/ {
       include rmdb_servers
}

#node /^lga02-bp02\.revsw\.net$/ {
#        include bp_nginx_servers4_1_10
#}

node /^(zuh02|pek02|pus02|pty02|qro02|grz02|vie02|bom02|del02|blr02|las02|jnb02|sxb02|kna02|lax02|lon02|dfw02|ord02|tlv02|atl02|mad02|syd02|den02|par02|waw02|sea02|fra02|sao02|iad02|sjc02|hkg02|mia02|lga02|yyz02|ams02|sin02|tyo02|phx02|mow02|maa02|pdx02|sel02|ist02|mil02|sto02|svx02)-bp(01|02|03|04|05|06|07|08|09|10)\.revsw\.net$/ {
	include bp_nginx_servers4
}

node /^iad02-cmdb(01|02|03).revsw.net$/ {
	include cmdb_servers
}

node  /^iad02-portal(01|02|03).revsw.net$/ {
	include portal_servers
}

node 'IAD02-INSTALL01.REVSW.NET' {
	include install_servers
        include users::robot
}

node 'IAD02-GRAPHITE01.REVSW.NET' {
	include graphite_servers
}

node 'IAD02-MANAGER01.REVSW.NET' {
	include manager_servers
        include users::robot
}

node 'SJC02-MANAGER01.REVSW.NET' {
	include manager_servers
}

node 'IAD02-MONITOR01.REVSW.NET' {
	include monitor_servers
	include logcheck
        include sec::sec_app
	include system::rsyslog_logrotate_server
}
node 'SJC02-MONITOR02.REVSW.NET' {
	include default_server
	include firewall::monitor
	include amanda::client_configuration
	include system::resolv_conf_management
	include nagios::nagios_app
}

class bp_nginx_servers4 {
        include default_server
        include proxy::bp_required_packages
        include system::remove_tty1_if_hvc0_absent
        include proxy::recursive_local_DNS_server
        include firewall::proxy
        include proxy::varnish-graphite
        include proxy::report_apache_stats_to_graphite
        include proxy::manage_proxy_online_status_script
      #  include proxy::bp_rev_shared_ssl_certs
        include proxy::helping_scripts
        include proxy::taccessstat_script
        include proxy::revsw_kernel_module
        include proxy::install_ngxtop
        include logstash::logstash-forwarder_0_4_0
        include users::robot
      #  include proxy::msft_azure_client_cert
      #  include proxy::godaddy_stapling_cert
        include proxy::redis-server
        include proxy::revsw-varnish4
        include proxy::revsw-nginx-wallarm
        include proxy::wallarm-packages
	include proxy::configure-wallarm-tarantool-host
}

class test_bp_nginx_servers2 {
        include default_server
	include proxy::bp_required_packages
        include system::remove_tty1_if_hvc0_absent
        include proxy::recursive_local_DNS_server
        include proxy::varnish-graphite
        include proxy::report_apache_stats_to_graphite
        include proxy::manage_proxy_online_status_script
#        include proxy::bp_rev_shared_ssl_certs
        include proxy::helping_scripts
        include proxy::taccessstat_script
        include logstash::test_logstash-forwarder 
        include proxy::revsw_kernel_module
##        include proxy::bp_maxmind_city_db
##        include proxy::nginx_json_log_bp
##        include proxy::nginx_status_page_bp
##        include proxy::nginx_catch_all_bp2
#        include proxy::nginx_generic_config_bp2
##        include proxy::nginx_logrotate_bp
        include proxy::install_ngxtop
##        include proxy::nginx_robots_denyall
##        include proxy::nginx_cache
#        include proxy::fix_cedexis_radar_proxy_buffer
	include users::robot
	include users::qa_users
	include system::test_qa_lab_apt_cache_conf
##	include proxy::nginx_additional_conf_bp
##	include proxy::nginx_sdk_config
#	include proxy::msft_azure_client_cert
#	include proxy::godaddy_stapling_cert
	include proxy::redis-server
        include proxy::test_wallarm-packages
        include proxy::test_revsw-nginx
}

class install_servers {
	include default_server
	include firewall::install
	include amanda::client_configuration
	include system::resolv_conf_management
}

class amanda_backup_servers {
	include default_server
	include firewall::backup
	include amanda::server_configuration
	include amanda::client_configuration
	include system::resolv_conf_management
}

class website_servers {
	include default_server
	include firewall::website
	include system::resolv_conf_management
	include website::website
	include website::boomerang-js
	include website::monitor-origin
	include website::portal-maintenance-page
	include website::swagger-ui
}

class test_website_servers {
	include default_server
	include website::website
	include website::test_boomerang-js
#	include website::test_monitor-origin
	include website::test_portal-maintenance-page
	include users::robot
	include users::qa_users
}

class test_website_servers_new {
        include default_server
        include users::robot
        include users::qa_users
}

class manager_servers {
	include default_server
	include firewall::manager
	include amanda::client_configuration
	include system::resolv_conf_management
}

class graphite_servers {
	include default_server
	include firewall::graphite
	include amanda::client_configuration
	include system::resolv_conf_management
}

class api_servers {
	include default_server
	include firewall::api
	include amanda::client_configuration
	include system::resolv_conf_management
	include users::robot
	include revsw-api::revsw-api
}

class test_api_servers {
	include default_server
#	include amanda::client_configuration
#	include system::resolv_conf_management
#	include purge_api::nodejs_app
#	include purge_api::test_purge_api_app_2_0_7
	include users::robot
	include users::qa_users
}

class logshipper_servers {
        include default_server
        include firewall::logshipper
#        include amanda::client_configuration
#        include system::resolv_conf_management
        include revsw-logshipper::nodejs_app
        include revsw-logshipper::revsw-logshipper
        include users::robot
}

class test_logshipper_servers {
        include default_server
        include revsw-logshipper::nodejs_app
        include revsw-logshipper::test_revsw-logshipper
        include users::robot
        include users::qa_users
}

class cds_servers {
        include default_server
        include firewall::cds
        include amanda::client_configuration
        include system::resolv_conf_management
	include revsw-cds::nodejs_app
	include revsw-cds::revsw-cds
	include users::robot
}

class test_cds_servers {
        include default_server
        include revsw-cds::nodejs_app
	include revsw-cds::test_revsw-cds
        include users::robot
        include users::qa_users
}

class stats_api_servers {
        include default_server
        include revsw-stats-api::nodejs_app
	include revsw-stats-api::required_packages
	include revsw-stats-api::revsw-stats-api
	include firewall::api
	include system::resolv_conf_management
	include users::robot
}

class test_stats_api_servers {
        include default_server
        include revsw-stats-api::nodejs_app
	include revsw-stats-api::required_packages
	include revsw-stats-api::test_revsw-stats-api
        include users::robot
        include users::qa_users
}


class cmdb_servers {
	include default_server
	include firewall::cmdb_servers
	include mongodb::report_mongodb_stats_to_graphite
	include amanda::client_configuration
	include system::resolv_conf_management
	include cmdb::mongodb
}

class test_cmdb_servers {
        include default_server
        include mongodb::report_mongodb_stats_to_graphite
        include cmdb::mongodb
	include users::qa_users
}

class rmdb_servers {
	include default_server
	include firewall::rmdb
	include mongodb::report_mongodb_stats_to_graphite
	include amanda::client_configuration
	include system::resolv_conf_management
	include rmdb::mongodb
}

class test_rmdb_servers {
	include default_server
	include mongodb::report_mongodb_stats_to_graphite
#	include amanda::client_configuration
	include rmdb::mongodb
	include users::qa_users
}

class rum_servers {
	include default_server
	include firewall::rum
	include amanda::client_configuration
	include system::resolv_conf_management
}

class test_rum_servers {
	include default_server
	include rum::nodejs_app
	include rum::test_rum_app_3_0
	include users::robot
	include users::qa_users
}

class cube_servers {
	include default_server
	include firewall::cube
	include amanda::client_configuration
	include system::resolv_conf_management
	include cube::cube_app
}

class test_cube_servers {
        include default_server
	include cube::nodejs_app
        include cube::test_cube_app_3_0_1
	include users::robot
	include users::qa_users
}

class portal_servers {
	include default_server
	include firewall::portal
	include amanda::client_configuration
	include system::resolv_conf_management
	include users::robot
        include portal::portal_app_5_0_1
}

class test_portal_servers {
        include default_server
        include users::qa_users
	include users::robot
        include portal::test_portal_app_5_0_1
}

class es_servers {
	include default_server
	include firewall::elasticsearch
#	include amanda::client_configuration
	include system::resolv_conf_management
	include elasticsearch::elasticsearch_app
# Removing logstash classes from es_servers and adding them manually to 05/06/07 nodes
## 	include logstash::logstash_app
##	include logstash::pin_logstash_verson_1_4_2

#	include logstash::logstash_geoip_database_20150123
	include elasticsearch::pin_elasticsearch_verson_1_5_2
	include elasticsearch::crontab_remove_old_es_logs
}

class test_es_servers {
	include default_server
	include elasticsearch::test_elasticsearch_app
	include logstash::test_logstash_app
#	include logstash::pin_logstash_verson_1_4_2
#	include logstash::logstash_geoip_database_20150123
	include users::qa_users
	include elasticsearch::pin_elasticsearch_verson_1_5_2
	include elasticsearch::crontab_remove_old_es_logs
}

class esurl_servers {
        include default_server
        include firewall::elasticsearch_url
#       include amanda::client_configuration
#       include system::resolv_conf_management
#        include elasticsearch::elasticsearch_app
#        include logstash::logstash_app
#       include logstash::logstash_geoip_database_20150123
	include elasticsearch::pin_elasticsearch_verson_1_7_3
	include elasticsearch::esurl_remove_old_indexes
	include elasticsearch::crontab_remove_old_es_logs
}


class test_esurl_servers {
	include default_server
#	include elasticsearch::test_elasticsearch_app
#	include logstash::test_logstash_app
#	include logstash::logstash_geoip_database_20150123
	include users::qa_users
	include elasticsearch::pin_elasticsearch_verson_1_7_3
	include elasticsearch::esurl_remove_old_indexes
	include elasticsearch::crontab_remove_old_es_logs
}


class monitor_servers {
	include default_server
	include proxy::recursive_local_DNS_server
	include firewall::monitor
	include amanda::client_configuration
	include users::robot
	include nagios::nagios_app
}

class webtest_servers {
	include default_server
	include system::resolv_conf_8_8_8_8
	include firewall::webtest
# 	include revsw-webtest::nodejs_app
	include revsw-webtest::revsw-webtest
	include users::robot
}

class test_jenkins_servers {
	include default_server
	include amanda::client_configuration
	include users::qa_users
	include system::test_qa_lab_apt_cache_conf
}

class wpt-server_servers {
	include default_server
	include amanda::client_configuration
	include firewall::wpt-server
}

class test_xen_servers {
	include default_server
	include system::test_xen_master
	include users::qa_users
}

class tarantool_servers {
        include default_server
        include firewall::tarantool
        include proxy::wallarm-tarantool
        include users::robot
}

class default_server {
	include system::default_sysctl_conf
	include system::disable_ipv6
	include system::opt_scripts_directory
	include nagios::nrpe_agent
#	include system::collectl
	include collectl::collectl_4_2_0
	include system::lockrun
	include system::basic_packages
        include system::ntp
	include users::default_admins
	include system::sudoers_sysadmin
	include system::sudoers_nagios
	include system::puppet-agent
	include system::ssh
	include system::rsyslog
	include system::timezone_UTC
	include system::sendmail 
	include system::create_lastlog_file
	include system::create_messages_file
	include system::snmpd
	include system::remove_packages
	include system::history_timestamp
	include firewall::set_max_conntrack 
	include firewall::enable_conntrack_liberal
	include system::clear_swap_space
	include system::disable_unattended_package_upgrades
	include system::revsw-modify-network-settings
	include system::helping_scripts
	include system::report_sysctl_stats_to_graphite
	include system::run_apt_get_update
#	include system::var_crash_directory
	include system::run_update_locale
	include system::remove_samba_packages
	include system::report_fresh_core_files
}
