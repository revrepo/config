

class proxy::taccessstat_script {

  file { "/usr/local/sbin/taccessstat.py":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/proxy/taccessstat.py"
  }
}

class proxy::manage_proxy_online_status_script {

  file { "/usr/local/sbin/manage_proxy_online_status.sh":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/proxy/manage_proxy_online_status.sh"
  }
}

#class proxy::custom_pcmp_rc_script {
#
#  file { "/etc/init.d/pcmp":
#    owner  => root,
#    group  => root,
#    mode   => 755,
#    source => "puppet:///modules/proxy/pcmp",
#    notify => Service['pcmp'],
#  }
#
#  service { pcmp:
#    hasrestart => true,
#  }
#}

#class proxy::blacklotus_resolv_conf {
#
#  file { "/etc/resolv.conf":
#    owner  => root,
#    group  => root,
#    mode   => 644,
#    source => "puppet:///modules/proxy/resolv.conf.blacklotus"
#  }
#}


class proxy::recursive_local_DNS_server {
  package { "bind9":
    ensure => installed
  }

  file { "/etc/resolv.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/resolv.conf"
  }

  file { "/etc/bind/named.conf.options":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/named.conf.options",
    notify => Service['bind9'],
    require => Package['bind9'],
  }

  file { "/etc/default/bind9":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/bind9",
    notify => Service['bind9'],
    require => Package['bind9'],
  }

  service { bind9:
    enable     => true,
    ensure     => running,
    hasrestart => true,
    require => Package['bind9'],
  }
}

class proxy::varnish-graphite {

  service { varnish-graphite:
    enable     => true,
    ensure     => running,
    require => File["/etc/init.d/varnish-graphite", "/opt/scripts/varnish-graphite.py"]
  }

  file { "/etc/init.d/varnish-graphite":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/proxy/varnish-graphite.rc",
    notify => Service['varnish-graphite'],
  }

  file { "/opt/scripts/varnish-graphite.py":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/proxy/varnish-graphite.py",
    notify => Service['varnish-graphite']
  }
}

class proxy::revsw_kernel_module {

	exec { 'add_revsw_module_at_boot':
		command   => 'echo tcp_revsw >> /etc/modules',
		cwd       => '/',
		unless    => 'grep -w "^tcp_revsw$" /etc/modules',
		path      => ['/usr/bin','/usr/sbin','/bin','/sbin']
	}

#	exec { 'load_revsw_module':
#		command   => 'modprobe tcp_revsw',
#		cwd       => '/',
#		unless    => 'lsmod | grep -w tcp_revsw',
#		path      => ['/usr/bin','/usr/sbin','/bin','/sbin']
#	}

     file { "/etc/sysctl.d/10-enable-revsw-tcp-module.conf":
            owner  => root,
            group  => root,
            mode   => 644,
            source => "puppet:///modules/proxy/10-enable-revsw-tcp-module.conf",
            notify  => Exec["sysctl"],
     }

     file { "/etc/sysctl.d/11-revsw-disable-safetynet.conf":
            owner  => root,
            group  => root,
            mode   => 644,
            source => "puppet:///modules/proxy/11-revsw-disable-safetynet.conf",
            notify  => Exec["sysctl"],
     }

}

#class proxy::nginx_logrotate {
#
#  file { "/etc/logrotate.d/nginx":
#    owner  => root,
#    group  => root,
#    mode   => 644,
#    source => "puppet:///modules/proxy/logrotate_nginx",
#    require => Package['nginx'],
#  }
#
#  file { "/etc/nginx/logrotate_nginx_access.conf":
#    owner  => root,
#    group  => root,
#    mode   => 644,
#    source => "puppet:///modules/proxy/logrotate_nginx_access.conf",
#    require => Package['nginx'],
#  }
#
#  file { "/etc/cron.d/logrotate_nginx_access":
#    owner  => root,
#    group  => root,
#    mode   => 644,
#    source => "puppet:///modules/proxy/logrotate_nginx_access.crontab",
#    require => Package['nginx'],
#  }
#
#}


#class proxy::nginx_logrotate_bp {
#
#  file { "/etc/logrotate.d/nginx":
#    owner  => root,
#    group  => root,
#    mode   => 644,
#    source => "puppet:///modules/proxy/logrotate_nginx",
#    require => Package['revsw-nginx-full'],
#  }
#
#  file { "/etc/nginx/logrotate_nginx_access.conf":
#    owner  => root,
#    group  => root,
#    mode   => 644,
#    source => "puppet:///modules/proxy/logrotate_nginx_access.conf",
#    require => Package['revsw-nginx-full'],
#  }
#
#  file { "/etc/cron.d/logrotate_nginx_access":
#    owner  => root,
#    group  => root,
#    mode   => 644,
#    source => "puppet:///modules/proxy/logrotate_nginx_access.crontab",
#    require => Package['revsw-nginx-full'],
#  }
#
#}


#class proxy::nginx_logrotate_co {
#
#  file { "/etc/logrotate.d/nginx":
#    owner  => root,
#    group  => root,
#    mode   => 644,
#    source => "puppet:///modules/proxy/logrotate_nginx",
#    require => Package['revsw-nginx-full'],
#  }
#
#  file { "/etc/nginx/logrotate_nginx_access.conf":
#    owner  => root,
#    group  => root,
#    mode   => 644,
#    source => "puppet:///modules/proxy/logrotate_nginx_access.conf",
#    require => Package['revsw-nginx-full'],
#  }
#
#  file { "/etc/cron.d/logrotate_nginx_access":
#    owner  => root,
#    group  => root,
#    mode   => 644,
#    source => "puppet:///modules/proxy/logrotate_nginx_access.crontab",
#    require => Package['revsw-nginx-full'],
#  }
#
#}


#class proxy::nginx_json_log {
#
#  package { "nginx":
#    ensure => installed
#  }
#
#  service { nginx:
#    enable     => true,
#    restart   => "/etc/init.d/nginx configtest && /etc/init.d/nginx reload",
#    require => Package['nginx'],
#  }
#
#  file { "/etc/nginx/conf.d/revsw-json-access-log-nginx.conf":
#    owner  => root,
#    group  => root,
#    mode   => 644,
#    source => "puppet:///modules/proxy/revsw-json-access-log-nginx.conf",
#    notify => Service['nginx'],
#    require => Package['nginx'],
#  }
#}

#class proxy::nginx_json_log_bp {
#
#  package { "revsw-nginx-full":
#    ensure => installed
#  }
#
#  service { revsw-nginx:
#    enable     => true,
#    restart   => "/etc/init.d/revsw-nginx configtest && /etc/init.d/revsw-nginx reload",
#    require => Package['revsw-nginx-full'],
#  }
#
#  file { "/etc/nginx/conf.d/revsw-json-access-log-nginx.conf":
#    owner  => root,
#    group  => root,
#    mode   => 644,
#    source => "puppet:///modules/proxy/revsw-json-access-log-nginx.conf",
#    notify => Service['revsw-nginx'],
#    require => Package['revsw-nginx-full'],
#  }
#}


#class proxy::nginx_json_log_co {
#
#  package { "revsw-nginx-full":
#    ensure => installed
#  }
#
#  service { revsw-nginx:
#    enable     => true,
#    restart   => "/etc/init.d/revsw-nginx configtest && /etc/init.d/revsw-nginx reload",
#    require => Package['revsw-nginx-full'],
#  }
#
#  file { "/etc/nginx/conf.d/revsw-json-access-log-nginx.conf":
#    owner  => root,
#    group  => root,
#    mode   => 644,
#    source => "puppet:///modules/proxy/revsw-json-access-log-nginx_co.conf",
#    notify => Service['revsw-nginx'],
#    require => Package['revsw-nginx-full'],
#  }
#}


class proxy::nginx_status_page {

  file { "/etc/nginx/conf.d/revsw-nginx-status-page.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/revsw-nginx-status-page.conf",
    notify => Service['nginx'],
    require => Package['nginx'],
  }
}

class proxy::nginx_status_page_bp {

  file { "/etc/nginx/conf.d/revsw-nginx-status-page.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/revsw-nginx-status-page.conf",
    notify => Service['revsw-nginx'],
    require => Package['revsw-nginx-full'],
  }
}

class proxy::nginx_status_page_co {

  file { "/etc/nginx/conf.d/revsw-nginx-status-page.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/revsw-nginx-status-page.conf",
    notify => Service['revsw-nginx'],
    require => Package['revsw-nginx-full'],
  }
}

#class proxy::nginx_catch_all_bp {
#
#  file { "/etc/nginx/conf.d/000-catch-all-bp_nginx.conf":
#    owner  => root,
#    group  => root,
#    mode   => 644,
#    source => "puppet:///modules/proxy/000-catch-all-bp_nginx.conf",
#    notify => Service['nginx'],
#    require => Package['nginx'],
#  }
#}

#class proxy::nginx_catch_all_bp2 {
#
#  file { "/etc/nginx/conf.d/000-catch-all-bp_nginx.conf":
#    owner  => root,
#    group  => root,
#    mode   => 644,
#    source => "puppet:///modules/proxy/000-catch-all-bp_nginx.conf",
#    notify => Service['revsw-nginx'],
#    require => Package['revsw-nginx-full'],
#  }
#}

#class proxy::nginx_additional_conf_bp {
#
#  file { "/etc/nginx/conf.d/revsw-bp.conf":
#    owner  => root,
#    group  => root,
#    mode   => 644,
#    source => "puppet:///modules/proxy/revsw-bp.conf",
#    notify => Service['revsw-nginx'],
#    require => Package['revsw-nginx-full'],
#  }
#}

#class proxy::nginx_additional_conf_co {
#
#  file { "/etc/nginx/conf.d/revsw-co.conf":
#    owner  => root,
#    group  => root,
#    mode   => 644,
#    source => "puppet:///modules/proxy/revsw-co.conf",
#    notify => Service['revsw-nginx'],
#    require => Package['revsw-nginx-full'],
#  }
#}
#
#class proxy::nginx_catch_all_co {
#
#  file { "/etc/nginx/conf.d/000-catch-all-co_nginx.conf":
#    owner  => root,
#    group  => root,
#    mode   => 644,
#    source => "puppet:///modules/proxy/000-catch-all-co_nginx.conf",
#    notify => Service['revsw-nginx'],
#    require => Package['revsw-nginx-full'],
#  }
#}

class proxy::report_apache_stats_to_graphite {

  file { "/opt/scripts/graphite_webstats.sh":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/proxy/graphite_webstats.sh",
  }

  file { "/etc/cron.d/graphite_webstats":
    owner  => root,
    group  => root,
    mode   => 644,
    ensure => absent
#    source => "puppet:///modules/proxy/graphite_webstats.crontab",
  }
}


class proxy::report_pagespeed_stats_to_graphite {

  file { "/opt/scripts/pagespeed_graphite_stats.sh":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/proxy/pagespeed_graphite_stats.sh",
  }

  file { "/etc/cron.d/pagespeed_graphite_stats":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/pagespeed_graphite_stats.crontab",
  }
}

class proxy::bp_maxmind_city_db {

  file { [ "/opt/revsw-config/maxmind" ]:
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 755,
  }

  file { [ "/opt/revsw-config/maxmind/GeoLite2-City.mmdb" ]:
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/GeoLite2-City.mmdb",
  }


  file { [ "/opt/revsw-config/maxmind/GeoLite2-City.dat" ]:
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/GeoLite2-City.dat",
  }
}


class proxy::bp_rev_shared_ssl_certs {

  file { [ "/opt/revsw-config/apache/generic-site", "/opt/revsw-config/apache/generic-site/certs" ]:
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 755,
  }

  file { "/opt/revsw-config/apache/generic-site/certs/server.crt":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/ssl_certs/server.crt"
  }

  file { "/opt/revsw-config/apache/generic-site/certs/server-chained.crt":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/ssl_certs/server-chained.crt"
  }

  file { "/opt/revsw-config/apache/generic-site/certs/server.key":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/ssl_certs/server.key"
  }

  file { "/opt/revsw-config/apache/generic-site/certs/ca-bundle.crt":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/ssl_certs/ca-bundle.crt"
  }

  file { "/opt/revsw-config/apache/generic-site/certs/ca-bundle-ocsp.crt":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/ssl_certs/ca-bundle-ocsp.crt"
  }

# New SSL location
 file { [ "/opt/revsw-config/certs", "/opt/revsw-config/certs/old" ]:
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 755,
  }

#  file { '/opt/revsw-config/certs/default':
#    ensure => 'link',
#    target => '/opt/revsw-config/certs/old',
#  }

  file { "/opt/revsw-config/certs/old/public.crt":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/ssl_certs/server-chained.crt"
  }

  file { "/opt/revsw-config/certs/old/private.key":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/ssl_certs/server.key"
  }
}

class proxy::helping_scripts {

  file { "/opt/scripts/delete_proxy_configuration.sh":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/delete_proxy_configuration.sh"
  }

  file { "/opt/scripts/extract_urls_from_nginx_log_file.pl":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/proxy/extract_urls_from_nginx_log_file.pl"
  }

  file { "/opt/scripts/extract_most_popular_urls.sh":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/proxy/extract_most_popular_urls.sh"
  }

  file { "/opt/scripts/proxy_warmup":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/proxy/proxy_warmup"
  }

  file { "/usr/local/sbin/taccess":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/proxy/taccess"
  }

  file { "/usr/local/sbin/taccess_co":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/proxy/taccess_co"
  }


  file { "/usr/local/sbin/terror":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/proxy/terror"
  }

  package { "gdb":
    ensure => installed
  }

  file { "/usr/local/sbin/collect_proxy_debug_info.sh":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/proxy/collect_proxy_debug_info.sh"
  }
}

class proxy::varnish_default_file {

  file { "/etc/default/revsw-varnish4":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/revsw-varnish4.default"
  }
}

class proxy::varnish_template {

  file { "/etc/revsw-apache/varnish.jinja":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/varnish.jinja"
  }
}

class proxy::bp_co_communication_ssl_certs {

  file { [ "/opt/revsw-config", "/opt/revsw-config/apache", "/opt/revsw-config/apache/co-certs" ]:
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 755,
  }

  file { "/opt/revsw-config/apache/co-certs/server.crt":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/co_ssl_certs/server.crt"
  }

  file { "/opt/revsw-config/apache/co-certs/server-chained.crt":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/co_ssl_certs/server-chained.crt"
  }

  file { "/opt/revsw-config/apache/co-certs/server.key":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/co_ssl_certs/server.key"
  }

  file { "/opt/revsw-config/apache/co-certs/ca-bundle.crt":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/co_ssl_certs/ca-bundle.crt"
  }
}

define line($file, $line, $ensure = 'present') {
    case $ensure {
        default : { err ( "unknown ensure value ${ensure}" ) }
        present: {
            exec { "/bin/echo '${line}' >> '${file}'":
                unless => "/bin/grep -qFx '${line}' '${file}'"
            }
        }
        absent: {
            exec { "/usr/bin/perl -ni -e 'print unless /^\\Q${line}\\E\$/' '${file}'":
                onlyif => "/bin/grep -qFx '${line}' '${file}'"
            }
        }
    }
}

class proxy::fix_mbeans_com_timeout {

	line { proxytimeout_5:
	    file => "/etc/apache2/sites-available/mbeans_com.conf",
	    line => "    ProxyTimeout 5",
	    ensure => absent,
	    notify => Service['revsw-apache2']
	}
}

class proxy::fix_thatsthem_com_timeout {

	line { proxytimeout_5_2:
	    file => "/etc/apache2/sites-available/staging_thatsthem_com.conf",
	    line => "    ProxyTimeout 5",
	    ensure => absent,
	    notify => Service['revsw-apache2']
	}
}



class proxy::install_ngxtop {

	package { "python-pip":
		ensure => installed
	}

	package {
		["ngxtop"]:
		ensure => present,
		provider => pip,
		require => Package['python-pip']
	}

	file { "/usr/local/sbin/rtop":
		ensure => present,
		owner  => root,
		group  => root,
		 mode   => 755,
		source => "puppet:///modules/proxy/rtop"
	}

	file { "/usr/local/sbin/rtop_co":
		ensure => present,
		owner  => root,
		group  => root,
		 mode   => 755,
		source => "puppet:///modules/proxy/rtop_co"
	}

	file { "/usr/local/sbin/rtop_co.py":
		ensure => present,
		owner  => root,
		group  => root,
		 mode   => 644,
		source => "puppet:///modules/proxy/rtop_co.py"
	}
}

class proxy::nginx_robots_denyall {

	file { [ "/var/www" ]:
		ensure => directory,
		owner  => root,
		group  => root,
		mode   => 755,
	}

	file { "/var/www/robots.txt":
		ensure => present,
		owner  => root,
		group  => root,
		 mode   => 644,
		source => "puppet:///modules/proxy/robots_denyall.txt"
	}
}



class proxy::nginx_cache {

  file { "/etc/nginx/conf.d/revsw-cache.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/revsw-cache.conf",
    notify => Service['revsw-nginx'],
    require => Package['revsw-nginx-full'],
  }
}


class proxy::fix_cedexis_radar_proxy_buffer {

        line { cedexis_radar_proxy_buffer:
            file => "/etc/nginx/sites-available/cedexis-radar_revdn_net.conf",
            line => "    proxy_buffering off;",
            ensure => absent,
            notify => Service['revsw-nginx']
        }
}




class proxy::custom_vcl {

  package { "revsw-varnish4":
  }

  service { revsw-varnish4:
    require => Package['revsw-varnish4'],
  }

#  file { "/etc/varnish/custom.vcl":
#    owner  => root,
#    group  => root,
#    mode   => 644,
#    source => "puppet:///modules/proxy/custom.vcl",
#    require => Package['revsw-varnish4'],
#  }
}

class proxy::bp_required_packages {
  package { "gcc":
    ensure => installed
  }

  package { "liblua5.1-0":
    ensure => installed
  }

  package { "libjemalloc1":
    ensure => installed
  }

  package { "libc6-dev":
    ensure => installed
  }

#  package { "libmhash-dev":
#    ensure => installed
#  }

  package { "libgd3":
    ensure => installed
  }

  package { "libxslt1.1":
    ensure => installed
  }

  package { "python-jinja2":
    ensure => installed
  }

  package { "python-jsonschema":
    ensure => installed
  }

  package { "python-dnspython":
    ensure => installed
  }

  package { "libwebsockets3":
    ensure => installed
  }

  package { "libwebsockets-dev":
    ensure => installed
  }

  package { "libmhash2":
    ensure => installed
  }

  package { "libyajl2":
    ensure => installed
  }

}

class proxy::co_required_packages {
  package { "libgd3":
    ensure => installed
  }
  
  package { "libxslt1.1":
    ensure => installed
  }

  package { "python-jinja2":
    ensure => installed
  }

  package { "python-jsonschema":
    ensure => installed
  }
  
  package { "python-dnspython":
    ensure => installed
  }
  
  package { "libwebsockets3":
    ensure => installed
  }
  
  package { "libwebsockets-dev":
    ensure => installed
  }
}


class proxy::nginx_sdk_config {

  file { "/etc/nginx/conf.d/revsw-sdk-config.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/revsw-sdk-config.conf",
    notify => Service['revsw-nginx'],
    require => Package['revsw-nginx-full'],
  }
}


class proxy::msft_azure_client_cert {

  file { "/opt/revsw-config/certs/msft-azure.crt":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/msft-azure.crt"
  }
}

class proxy::godaddy_stapling_cert {

  file { "/opt/revsw-config/certs/godaddy_stapling_cert.crt":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/godaddy_stapling_cert.crt"
  }
}

class proxy::redis-server {

  package { "redis-server":
    ensure => installed
  }

  service { redis-server:
    enable     => true,
    ensure     => running,
    hasrestart => true,
    require => Package['redis-server'],
  }

  file { "/etc/redis/redis.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/redis.conf",
    require => Package['redis-server'],
    notify => Service['redis-server']
  }
}

class proxy::revsw-varnish4 {

  # on Puppet master server the files should be placed in files/packages/ directory
  $libwurfl = "libwurfl-1.9.0.1-x86_64.deb"
  $varnish_wurfl_mod = "varnish-mod-wurfl-1.9.0.0.varnish-4.0.3.x86_64.deb"
  $revsw_varnish4 = "revsw-varnish4_4.0.3-37_amd64.deb"
  $revsw_varnish4_modules = "revsw-varnish4-modules_4.0.3-37_amd64.deb"
  $revsw_varnish4api = "revsw-libvarnish4api_4.0.3-37_amd64.deb"

  # libwurfl
  file { "/root/$libwurfl":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/packages/$libwurfl"
  }

  package { "libwurfl":
    provider => dpkg,
    ensure => installed,
    source => "/root/$libwurfl"
  }

  # varnish-mod-wurfl
  file { "/root/$varnish_wurfl_mod":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/packages/$varnish_wurfl_mod"
  }

  package { "varnish-mod-wurfl":
    provider => dpkg,
    ensure => installed,
    source => "/root/$varnish_wurfl_mod",
    require => Package['revsw-varnish4']
  }

  # revsw-varnish4api
  file { "/root/$revsw_varnish4api":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/packages/$revsw_varnish4api"
  }

  package { "revsw-libvarnish4api":
    provider => dpkg,
    ensure => installed,
    source => "/root/$revsw_varnish4api"
  }

  # revsw-varnish4
  file { "/root/$revsw_varnish4":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/packages/$revsw_varnish4"
  }

  package { "revsw-varnish4":
    provider => dpkg,
    ensure => installed,
    source => "/root/$revsw_varnish4",
    require => Package['revsw-libvarnish4api', 'libjemalloc1']
  }

  # revsw-varnish4-modules
  file { "/root/$revsw_varnish4_modules":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/packages/$revsw_varnish4_modules"
  }

  package { "revsw-varnish4-modules":
    provider => dpkg,
    ensure => installed,
    source => "/root/$revsw_varnish4_modules",
    require => Package['revsw-varnish4']
  }

}

class proxy::revsw-varnish4_1_10 {

  # on Puppet master server the files should be placed in files/packages/ directory
  $libwurfl = "libwurfl-1.9.0.1-x86_64.deb"
  $varnish_wurfl_mod = "varnish-mod-wurfl-1.9.0.0.varnish-4.0.3.x86_64.deb"
  $revsw_varnish4 = "revsw-varnish4_4.0.3-37_amd64.deb"
  $revsw_varnish4_modules = "revsw-varnish4-modules_4.0.3-37_amd64.deb"
  $revsw_varnish4api = "revsw-libvarnish4api_4.0.3-37_amd64.deb"

  # libwurfl
  file { "/root/$libwurfl":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/packages/$libwurfl"
  }

  package { "libwurfl":
    provider => dpkg,
    ensure => installed,
    source => "/root/$libwurfl"
  }

  # varnish-mod-wurfl
  file { "/root/$varnish_wurfl_mod":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/packages/$varnish_wurfl_mod"
  }

  package { "varnish-mod-wurfl":
    provider => dpkg,
    ensure => installed,
    source => "/root/$varnish_wurfl_mod",
    require => Package['revsw-varnish4']
  }

  # revsw-varnish4api
  file { "/root/$revsw_varnish4api":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/packages/$revsw_varnish4api"
  }

  package { "revsw-libvarnish4api":
    provider => dpkg,
    ensure => installed,
    source => "/root/$revsw_varnish4api"
  }

  # revsw-varnish4
  file { "/root/$revsw_varnish4":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/packages/$revsw_varnish4"
  }

  package { "revsw-varnish4":
    provider => dpkg,
    ensure => installed,
    source => "/root/$revsw_varnish4",
    require => Package['revsw-libvarnish4api', 'libjemalloc1']
  }

  # revsw-varnish4-modules
  file { "/root/$revsw_varnish4_modules":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/packages/$revsw_varnish4_modules"
  }

  package { "revsw-varnish4-modules":
    provider => dpkg,
    ensure => installed,
    source => "/root/$revsw_varnish4_modules",
    require => Package['revsw-varnish4']
  }
}


class proxy::test_revsw-varnish4_1_10 {

  # on Puppet master server the files should be placed in files/packages/ directory
  $libwurfl = "libwurfl-1.9.0.1-x86_64.deb"
  $varnish_wurfl_mod = "varnish-mod-wurfl-1.9.0.0.varnish-4.0.3.x86_64.deb"
  $revsw_varnish4 = "revsw-varnish4_4.0.3-37_amd64.deb"
  $revsw_varnish4_modules = "revsw-varnish4-modules_4.0.3-37_amd64.deb"
  $revsw_varnish4api = "revsw-libvarnish4api_4.0.3-37_amd64.deb"

  # libwurfl
  file { "/root/$libwurfl":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/packages/$libwurfl"
  }

  package { "libwurfl":
    provider => dpkg,
    ensure => installed,
    source => "/root/$libwurfl"
  }

  # varnish-mod-wurfl
  file { "/root/$varnish_wurfl_mod":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/packages/$varnish_wurfl_mod"
  }

  package { "varnish-mod-wurfl":
    provider => dpkg,
    ensure => installed,
    source => "/root/$varnish_wurfl_mod",
    require => Package['revsw-varnish4']
  }

  # revsw-varnish4api
  file { "/root/$revsw_varnish4api":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/packages/$revsw_varnish4api"
  }

  package { "revsw-libvarnish4api":
    provider => dpkg,
    ensure => installed,
    source => "/root/$revsw_varnish4api"
  }

  # revsw-varnish4
  file { "/root/$revsw_varnish4":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/packages/$revsw_varnish4"
  }

  package { "revsw-varnish4":
    provider => dpkg,
    ensure => installed,
    source => "/root/$revsw_varnish4",
    require => Package['revsw-libvarnish4api', 'libjemalloc1']
  }

  # revsw-varnish4-modules
  file { "/root/$revsw_varnish4_modules":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/packages/$revsw_varnish4_modules"
  }

  package { "revsw-varnish4-modules":
    provider => dpkg,
    ensure => installed,
    source => "/root/$revsw_varnish4_modules",
    require => Package['revsw-varnish4']
  }

}


class proxy::wallarm-packages {

#apt::source { 'wallarm':
#  location   => 'http://repo.wallarm.com/ubuntu/wallarm-node/',
#  repos      => 'trusty/',
#  key        => '72B865FD',
#  key_server => 'keys.gnupg.net',
#}

  file { "/etc/apt/sources.list.d/wallarm.list":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/wallarm.list"
  }

  exec { "add_wallarm_repo_key":
    command => "/usr/bin/apt-key adv --keyserver keys.gnupg.net --recv-keys 72B865FD",
    require =>  File["/etc/apt/sources.list.d/wallarm.list"],
    subscribe =>  File["/etc/apt/sources.list.d/wallarm.list"],
    refreshonly =>  true
  }

  exec { "apt-get_update_after_wallarm_repo_configuration":
    command => "/usr/bin/apt-get update",
    require => Exec["add_wallarm_repo_key"],
    subscribe => Exec["add_wallarm_repo_key"],
    refreshonly =>  true
  }

  package { "wallarm-common":
    ensure => installed,
    require => Exec["apt-get_update_after_wallarm_repo_configuration"]
  }

  package { "libtws0":
    ensure => installed,
    require => Package["wallarm-common"]
  }

  exec { "connect_node_production":
    command => "/usr/share/wallarm-common/addnode -b -u wallarm@nuubit.com -p 3LZTj7QjFA9GdmQwKZDk",
    subscribe => Package["wallarm-common"],
    require => Package["wallarm-common"],
    refreshonly => true
  }
}

class proxy::test_wallarm-packages {

#apt::source { 'wallarm':
#  location   => 'http://repo.wallarm.com/ubuntu/wallarm-node/',
#  repos      => 'trusty/',
#  key        => '72B865FD',
#  key_server => 'keys.gnupg.net',
#}

  file { "/etc/apt/sources.list.d/wallarm.list":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/wallarm.list"
  }

  exec { "add_wallarm_repo_key":
    command => "/usr/bin/apt-key adv --keyserver keys.gnupg.net --recv-keys 72B865FD",
    subscribe =>  File["/etc/apt/sources.list.d/wallarm.list"],
    refreshonly =>  true
  }

  exec { "apt-get_update_after_wallarm_repo_configuration":
    command => "/usr/bin/apt-get update",
    subscribe =>  File["/etc/apt/sources.list.d/wallarm.list"],
    require => [ File["/etc/apt/sources.list.d/wallarm.list"], Exec["add_wallarm_repo_key"] ],
    refreshonly =>  true
  }

  package { "wallarm-common":
    ensure => installed,
    require => [ File["/etc/apt/sources.list.d/wallarm.list"], Exec["add_wallarm_repo_key","apt-get_update_after_wallarm_repo_configuration"] ]
  }

  package { "libtws0":
    ensure => installed,
    require => Package["wallarm-common"]
  }

  exec { "connect_node":
    command => "/usr/share/wallarm-common/addnode -b -u victor@nuubit.com -p 4ZBwg9Dd2Qsf13cW72OZ",
    subscribe =>  Package["wallarm-common"],
    refreshonly =>  true
  }
}


class proxy::revsw-nginx {

  # on Puppet master server the files should be placed in files/packages/ directory
  $brotlilib_pkg_file = "libbrotli0_0.2.0+20151102a-0~eugenesan~trusty2_amd64.deb"
  $revsw_nginx_common = "revsw-nginx-common_1.9.6-227_all.deb"
  $revsw_nginx_naxsi = "revsw-nginx-naxsi_1.9.6-227_amd64.deb"
  $revsw_proxy_config = "revsw-proxy-config_1.0.356.deb"
  $revsw_quic_proxy = "revsw-quic-proxy_3.0.171_amd64.deb"

  # libbrotli
  file { "/root/$brotlilib_pkg_file":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/packages/$brotlilib_pkg_file"
  }

  package { "libbrotli0":
    provider => dpkg,
    ensure => installed,
    source => "/root/$brotlilib_pkg_file"
  }

  # revsw-nginx-common
  file { "/root/$revsw_nginx_common":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/packages/$revsw_nginx_common"
  }

  package { "revsw-nginx-common":
    provider => dpkg,
    ensure => installed,
    source => "/root/$revsw_nginx_common",
    require => Package['libbrotli0']
  }

  # revsw-nginx-naxsi
  file { "/root/$revsw_nginx_naxsi":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/packages/$revsw_nginx_naxsi"
  }

  package { "revsw-nginx-naxsi":
    provider => dpkg,
    ensure => installed,
    source => "/root/$revsw_nginx_naxsi",
    require => Package['revsw-nginx-common', 'liblua5.1-0']
  }

  service { revsw-nginx:
    enable     => true,
#    ensure     => running,
    hasrestart => true,
    require => Package['revsw-nginx-common'],
  }

  # revsw-proxy-config
  file { "/root/$revsw_proxy_config":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/packages/$revsw_proxy_config"
  }

  package { "revsw-proxy-config":
    provider => dpkg,
    ensure => installed,
    source => "/root/$revsw_proxy_config",
    require => Package['revsw-nginx-naxsi']
  }

  service { revsw-pcm-config:
    enable     => true,
    ensure     => running,
    hasrestart => true,
    require => Package['revsw-proxy-config'],
  }

  service { revsw-pcm-purge:
    enable     => true,
    ensure     => running,
    hasrestart => true,
    require => Package['revsw-proxy-config'],
  }

  # Install two additional certs
  file { "/opt/revsw-config/certs/msft-azure.crt":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/msft-azure.crt",
    require => Package['revsw-proxy-config']
  }

  file { "/opt/revsw-config/certs/godaddy_stapling_cert.crt":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/godaddy_stapling_cert.crt",
    require => Package['revsw-proxy-config']
  }

  file { "/opt/revsw-config/apache/generic-site/certs/ca-bundle-ocsp.crt":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/ssl_certs/ca-bundle-ocsp.crt"
  }

  # revsw-quic-proxy
  file { "/root/$revsw_quic_proxy":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/packages/$revsw_quic_proxy"
  }

  package { "revsw-quic-proxy":
    provider => dpkg,
    ensure => installed,
    source => "/root/$revsw_quic_proxy"
  }

  service { revsw-quic-proxy:
    enable     => true,
    hasrestart => true,
    ensure     => running,
    require => Package['revsw-quic-proxy'],
  }


  file { [ "/opt/revsw-config/apache/generic-site", "/opt/revsw-config/apache/generic-site/certs" ]:
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 755,
    require => Package['revsw-proxy-config']
  }

  file { "/opt/revsw-config/apache/generic-site/certs/server.crt":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/ssl_certs/server.crt"
  }

  file { "/opt/revsw-config/apache/generic-site/certs/server-chained.crt":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/ssl_certs/server-chained.crt"
  }

  file { "/opt/revsw-config/apache/generic-site/certs/server.key":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/ssl_certs/server.key"
  }

  file { "/opt/revsw-config/apache/generic-site/certs/ca-bundle.crt":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/ssl_certs/ca-bundle.crt"
  }

}

class proxy::revsw-nginx-wallarm {

  # on Puppet master server the files should be placed in files/packages/ directory
  $brotlilib_pkg_file = "libbrotli0_0.2.0+20151102a-0~eugenesan~trusty2_amd64.deb"
  $revsw_nginx_common = "revsw-nginx-common_1.12.2-16_all.deb"
  $revsw_nginx_naxsi = "revsw-nginx-naxsi_1.12.2-16_amd64.deb"
  $revsw_proxy_config = "revsw-proxy-config_1.0.360.deb"
  $revsw_quic_proxy = "revsw-quic-proxy_3.0.171_amd64.deb"

#  $revsw_nginx_common = "revsw-nginx-common_1.9.6-227_all.deb"
#  $revsw_nginx_naxsi = "revsw-nginx-naxsi_1.9.6-227_amd64.deb"
#  $revsw_proxy_config = "revsw-proxy-config_1.0.356.deb"

  # libbrotli
  file { "/root/$brotlilib_pkg_file":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/packages/$brotlilib_pkg_file"
  }

  package { "libbrotli0":
    provider => dpkg,
    ensure => installed,
    source => "/root/$brotlilib_pkg_file"
  }

  # revsw-nginx-common
  file { "/root/$revsw_nginx_common":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/packages/$revsw_nginx_common"
  }

  package { "revsw-nginx-common":
    provider => dpkg,
    ensure => installed,
    source => "/root/$revsw_nginx_common",
    require => Package['libbrotli0', 'wallarm-common']
  }

  # revsw-nginx-naxsi
  file { "/root/$revsw_nginx_naxsi":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/packages/$revsw_nginx_naxsi",
    require => Package['revsw-nginx-common']
  }

  package { "revsw-nginx-naxsi":
    provider => dpkg,
    ensure => installed,
    source => "/root/$revsw_nginx_naxsi",
    require => Package['revsw-nginx-common', 'liblua5.1-0']
  }

  service { revsw-nginx:
    enable     => true,
#    ensure     => running,
    hasrestart => true,
    require => Package['revsw-nginx-common'],
  }

  # revsw-proxy-config
  file { "/root/$revsw_proxy_config":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/packages/$revsw_proxy_config"
  }

  package { "revsw-proxy-config":
    provider => dpkg,
    ensure => installed,
    source => "/root/$revsw_proxy_config",
    require => Package['revsw-nginx-naxsi']
  }

  service { revsw-pcm-config:
    enable     => true,
    ensure     => running,
    hasrestart => true,
    require => Package['revsw-proxy-config'],
  }

  service { revsw-pcm-purge:
    enable     => true,
    ensure     => running,
    hasrestart => true,
    require => Package['revsw-proxy-config'],
  }

  # Install two additional certs
  file { "/opt/revsw-config/certs/msft-azure.crt":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/msft-azure.crt",
    require => Package['revsw-proxy-config']
  }

  file { "/opt/revsw-config/certs/godaddy_stapling_cert.crt":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/godaddy_stapling_cert.crt",
    require => Package['revsw-proxy-config']
  }

  file { "/opt/revsw-config/apache/generic-site/certs/ca-bundle-ocsp.crt":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/ssl_certs/ca-bundle-ocsp.crt"
  }

  # revsw-quic-proxy
  file { "/root/$revsw_quic_proxy":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/packages/$revsw_quic_proxy"
  }

  package { "revsw-quic-proxy":
    provider => dpkg,
    ensure => installed,
    source => "/root/$revsw_quic_proxy"
  }

  service { revsw-quic-proxy:
    enable     => true,
    hasrestart => true,
    ensure     => running,
    require => Package['revsw-quic-proxy'],
  }


  file { [ "/opt/revsw-config/apache/generic-site", "/opt/revsw-config/apache/generic-site/certs" ]:
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 755,
    require => Package['revsw-proxy-config']
  }

  file { "/opt/revsw-config/apache/generic-site/certs/server.crt":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/ssl_certs/server.crt"
  }

  file { "/opt/revsw-config/apache/generic-site/certs/server-chained.crt":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/ssl_certs/server-chained.crt"
  }

  file { "/opt/revsw-config/apache/generic-site/certs/server.key":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/ssl_certs/server.key"
  }

  file { "/opt/revsw-config/apache/generic-site/certs/ca-bundle.crt":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/ssl_certs/ca-bundle.crt"
  }

}


class proxy::test_revsw-nginx {

  # on Puppet master server the files should be placed in files/packages/ directory
  $brotlilib_pkg_file = "libbrotli0_0.2.0+20151102a-0~eugenesan~trusty2_amd64.deb"
  $revsw_nginx_common = "revsw-nginx-common_1.9.6-213_all.deb"
  $revsw_nginx_naxsi = "revsw-nginx-naxsi_1.9.6-213_amd64.deb"
  $revsw_proxy_config = "revsw-proxy-config_1.0.319.deb"
  $revsw_quic_proxy = "revsw-quic-proxy_3.0.171_amd64.deb"

  # libbrotli
  file { "/root/$brotlilib_pkg_file":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/packages/$brotlilib_pkg_file"
  }

  package { "libbrotli0":
    provider => dpkg,
    ensure => installed,
    source => "/root/$brotlilib_pkg_file"
  }

  # revsw-nginx-common
  file { "/root/$revsw_nginx_common":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/packages/$revsw_nginx_common"
  }

  package { "revsw-nginx-common":
    provider => dpkg,
    ensure => installed,
    source => "/root/$revsw_nginx_common",
    require => Package['libbrotli0']
  }

  # revsw-nginx-naxsi
  file { "/root/$revsw_nginx_naxsi":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/packages/$revsw_nginx_naxsi"
  }

  package { "revsw-nginx-naxsi":
    provider => dpkg,
    ensure => installed,
    source => "/root/$revsw_nginx_naxsi",
    require => Package['revsw-nginx-common', 'liblua5.1-0']
  }

  service { revsw-nginx:
    enable     => true,
#    ensure     => running,
    hasrestart => true,
    require => Package['revsw-nginx-common'],
  }

  # revsw-proxy-config
  file { "/root/$revsw_proxy_config":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/packages/$revsw_proxy_config"
  }

  package { "revsw-proxy-config":
    provider => dpkg,
    ensure => installed,
    source => "/root/$revsw_proxy_config",
    require => Package['revsw-nginx-naxsi']
  }

  service { revsw-pcm-config:
    enable     => true,
    ensure     => running,
    hasrestart => true,
    require => Package['revsw-proxy-config'],
  }

  service { revsw-pcm-purge:
    enable     => true,
    ensure     => running,
    hasrestart => true,
    require => Package['revsw-proxy-config'],
  }

  # Install two additional certs
  file { "/opt/revsw-config/certs/msft-azure.crt":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/msft-azure.crt",
    require => Package['revsw-proxy-config']
  }

  file { "/opt/revsw-config/certs/godaddy_stapling_cert.crt":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/godaddy_stapling_cert.crt",
    require => Package['revsw-proxy-config']
  }

  file { "/opt/revsw-config/apache/generic-site/certs/ca-bundle-ocsp.crt":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/ssl_certs/ca-bundle-ocsp.crt"
  }

  # revsw-quic-proxy
  file { "/root/$revsw_quic_proxy":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/packages/$revsw_quic_proxy"
  }

  package { "revsw-quic-proxy":
    provider => dpkg,
    ensure => installed,
    source => "/root/$revsw_quic_proxy"
  }

  service { revsw-quic-proxy:
    enable     => true,
    hasrestart => true,
    ensure     => running,
    require => Package['revsw-quic-proxy'],
  }


  file { [ "/opt/revsw-config/apache/generic-site", "/opt/revsw-config/apache/generic-site/certs" ]:
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 755,
    require => Package['revsw-proxy-config']
  }

  file { "/opt/revsw-config/apache/generic-site/certs/server.crt":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/ssl_certs/server.crt"
  }

  file { "/opt/revsw-config/apache/generic-site/certs/server-chained.crt":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/ssl_certs/server-chained.crt"
  }

  file { "/opt/revsw-config/apache/generic-site/certs/server.key":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/ssl_certs/server.key"
  }

  file { "/opt/revsw-config/apache/generic-site/certs/ca-bundle.crt":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 400,
    source => "puppet:///modules/proxy/ssl_certs/ca-bundle.crt"
  }
}

#
# Use the class to configure per-site IPs for local TARANTOOL servers
#
class proxy::configure-wallarm-tarantool-host {

  case $hostname {
    /^ATL02\-/: {
      $ip_address = "45.32.212.76"
    }
    /^SJC02\-/: {
      $ip_address = "45.77.187.69"
    }
    /^AMS02\-/: {
      $ip_address = "188.166.73.82"
    }
    /^ORD02\-/: {
      $ip_address = "45.63.65.149"
    }
    /^SEA02\-/: {
      $ip_address = "45.76.242.136"
    }
    /^DFW02\-/: {
      $ip_address = "23.239.29.32"
    }
    /^SIN02\-/: {
      $ip_address = "128.199.233.174"
    }
    /^LGA02\-/: {
      $ip_address = "159.65.232.100"
    }
    /^IAD02\-/: {
      $ip_address = "207.244.103.147"
    }
    /^FRA02\-/: {
      $ip_address = "185.17.144.70"
    }
    /^SYD02\-/: {
      $ip_address = "207.148.83.228"
    }
    default: {
      $ip_address = "127.0.0.1"
    }
  }

  line { tarantool_host:
    file => "/etc/hosts",
    line => "$ip_address TARANTOOL.REVSW.NET",
    ensure => present,
#    notify => Service['revsw-nginx'],
    require => Package['revsw-nginx-naxsi']
  }
}

class proxy::wallarm-tarantool {

  file { "/etc/apt/sources.list.d/wallarm.list":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/wallarm.list"
  }

  exec { "add_wallarm_repo_key":
    command => "/usr/bin/apt-key adv --keyserver keys.gnupg.net --recv-keys 72B865FD",
    require =>  File["/etc/apt/sources.list.d/wallarm.list"],
    subscribe =>  File["/etc/apt/sources.list.d/wallarm.list"],
    refreshonly =>  true
  }

  exec { "apt-get_update_after_wallarm_repo_configuration":
    command => "/usr/bin/apt-get update",
    require => Exec["add_wallarm_repo_key"],
    subscribe => Exec["add_wallarm_repo_key"],
    refreshonly =>  true
  }

  package { "wallarm-node-tarantool":
    ensure => installed,
    require => Exec["apt-get_update_after_wallarm_repo_configuration"]
  }

  exec { "connect_node_production":
    command => "/usr/share/wallarm-common/addnode --no-sync -b -u wallarm@nuubit.com -p 3LZTj7QjFA9GdmQwKZDk",
    require =>  Package["wallarm-node-tarantool"],
    refreshonly =>  true
  }

  file { "/etc/default/wallarm-tarantool":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/proxy/wallarm-tarantool",
    notify => Service["wallarm-tarantool"],
    require =>  Package["wallarm-node-tarantool"]
  }

  service { wallarm-tarantool:
    enable     => true,
    ensure     => running,
    hasrestart => true,
    require => Package['wallarm-node-tarantool']
  }
}
