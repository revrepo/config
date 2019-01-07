
class system::test_qa_lab_apt_cache_conf {
	file { "/etc/apt/apt.conf.d/02apt-cache-hq-qa-lab":
	    ensure => "file",
	    owner  => "root",
	    group  => "root",
	    mode   => 644,	
       	    source => "puppet:///modules/system/02apt-cache-hq-qa-lab"
	}
}

class system::opt_scripts_directory {
	file { "/opt/scripts":
	    ensure => "directory",
	    owner  => "root",
	    group  => "root",
	    mode   => 755,	
	}
}

class system::var_crash_directory {
        file { "/var/crash":
            ensure => "directory",
            owner  => "root",
            group  => "root",
            mode   => 3777,
        }
}

class system::basic_packages {

    package { "vim": 
        ensure => installed 
    }

    package { "pbzip2": 
        ensure => installed 
    }

    package { "telnet": 
        ensure => installed 
    }

    package { "tcpdump": 
        ensure => installed 
    }

    package { "man-db": 
        ensure => installed 
    }

    package { "mailutils": 
        ensure => installed 
    }

    package { "apport": 
        ensure => installed 
    }

    package { "libipc-run-perl": 
        ensure => installed 
    }

    package { "curl": 
        ensure => installed 
    }

    package { "httrack": 
        ensure => installed 
    }

    package { "virt-what": 
        ensure => installed 
    }

    package { "libjson-perl": 
        ensure => installed 
    }

    package { "ethtool": 
        ensure => installed 
    }

    package { "ksh": 
        ensure => installed 
    }

    package { "command-not-found": 
        ensure => installed 
    }

    package { "landscape-common": 
        ensure => installed 
    }

    package { "software-properties-common": 
        ensure => installed 
    }

    package { "httping": 
        ensure => installed 
    }

    package { "sysstat": 
        ensure => installed 
    }

    package { "liblwp-useragent-determined-perl": 
        ensure => installed 
    }

    package { "mtr": 
        ensure => installed 
    }

    package { "iptraf": 
        ensure => installed 
    }

    package { "iotop": 
        ensure => installed 
    }

    package { "tshark": 
        ensure => installed 
    }

    package { "whois": 
        ensure => installed 
    }

    package { "traceroute": 
        ensure => installed 
    }

    package { "bash-completion": 
        ensure => installed 
    }

    package { "unzip": 
        ensure => installed 
    }

    package { "lsof": 
        ensure => installed 
    }

    package { "libnagios-plugin-perl": 
        ensure => installed 
    }

#    package { "python-pip": 
#        ensure => installed 
#    }

}

class system::remove_packages {
    package { "rpcbind": 
        ensure => absent 
    }

    package { "at": 
        ensure => absent 
    }
}

class system::remove_samba_packages {
    package { "samba-common":
        ensure => absent
    }

    package { "samba-common-bin":
        ensure => absent
    }

    package { "samba-libs":
        ensure => absent
    }
    package { "smbclient":
        ensure => absent
    }

    package { "python-samba":
        ensure => absent
    }

    package { "libsmbclient":
        ensure => absent
    }

    package { "cifs-utils":
        ensure => absent
    }
}

class system::ntp {
    package { "ntp": 
        ensure => installed 
    }

    service { "ntp":
	require    => Package['ntp'],
        ensure 	   => running,
    }

 if $fqdn == 'WAW02-BP01.REVSW.NET' {
    file { "/etc/ntp.conf":
       mode   => 644,
       owner  => root,
       group  => root,
       source => "puppet:///modules/system/ntp.conf.waw02-bp01",
       notify => Service['ntp']
    }
 }
}

class system::sudoers_sysadmin {
	file { "/etc/sudoers.d/sysadmin":
	    mode   => 440,
	    owner  => root,
	    group  => root,
	    source => "puppet:///modules/system/sudoers.sysadmin"
	}
}

class system::sudoers_nagios {
	file { "/etc/sudoers.d/nagios":
	    mode   => 440,
	    owner  => root,
	    group  => root,
	    source => "puppet:///modules/system/sudoers.nagios"
	}
}

class system::puppet-agent {
  package { "puppet":
    ensure => installed
  }

  file { "/etc/default/puppet":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/system/puppet_default",
    notify => Service['puppet']
  }

  file { "/etc/puppet/puppet.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/system/puppet.conf",
    notify => Service['puppet']
  }

  service { puppet:
    ensure     => running,
    hasrestart => true,
    require => Package['puppet'],
  }
}

class system::ssh {
  package { "openssh-server":
    ensure => installed
  }

  file { "/etc/ssh/sshd_config":
    owner  => root,
    group  => root,
    mode   => 600,
    source => "puppet:///modules/system/sshd_config",
  }

  service { ssh:
    enable     => true,
    ensure     => running,
    hasrestart => true,
    require    => Package['openssh-server'],
    subscribe  => File["/etc/ssh/sshd_config"]
  }
}


class system::rsyslog_logrotate_server {

  file { "/etc/rsyslog_tls/cert.pem":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/system/rsyslog_tls/cert.pem"
  }

  file { "/etc/rsyslog_tls/key.pem":
    owner  => root,
    group  => root,
    mode   => 600,
    source => "puppet:///modules/system/rsyslog_tls/key.pem"
  }

  file { "/etc/logrotate.d/rsyslog":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/system/rsyslog.logrotate.server"
  }
}

class system::rsyslog {
  package { "rsyslog":
    ensure => installed
  }

  package { "rsyslog-gnutls":
    ensure => installed
  }

    if $fqdn == 'IAD02-MONITOR01.REVSW.NET' {
    	$rsyslog_config_file = "puppet:///modules/system/rsyslog.conf.server"
    }
    else {
    	$rsyslog_config_file = "puppet:///modules/system/rsyslog.conf"
    }

  file { "/etc/rsyslog_tls":
    ensure => "directory",
    owner  => "root",
    group  => "root",
    mode   => 755,
  }

  file { "/etc/rsyslog_tls/ca.pem":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/system/rsyslog_tls/ca.pem"
  }


  file { "/etc/rsyslog.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "$rsyslog_config_file"
  }

  service { rsyslog:
    enable     => true,
    ensure     => running,
    hasrestart => true,
    require    => Package['rsyslog'],
    subscribe  => File["/etc/rsyslog.conf"]
  }
}

class system::create_lastlog_file {
    exec {'Create /var/log/lastlog file if it does not exist':
        command         => "touch /var/log/lastlog",
        user            => root,
        onlyif          => "test ! -f /var/log/lastlog",
        path            => ['/usr/bin','/usr/sbin','/bin','/sbin']
    }
}

class system::create_messages_file {
    exec {'Create /var/log/messages file if it does not exist':
        command         => "touch /var/log/messages; chown syslog:adm /var/log/messages",
        user            => root,
        onlyif          => "test ! -f /var/log/messages",
        path            => ['/usr/bin','/usr/sbin','/bin','/sbin']
    }
}



class system::remove_tty1_if_hvc0_absent {
    exec {'Remove /etc/init/tty1.conf if the file mentions hvc0 and the device does not exist':
        command         => "stop tty1; rm -f /etc/init/tty1.conf",
        user            => root,
        onlyif          => "test -f /etc/init/tty1.conf && test ! -f /dev/hvc0 && grep hvc0 /etc/init/tty1.conf",
        path            => ['/usr/bin','/usr/sbin','/bin','/sbin']
    }
}



class system::timezone_UTC {

  file { "/etc/localtime":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/system/localtime.UTC"
  }

  file { "/etc/timezone":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/system/timezone.UTC"
  }
}



class system::sendmail {
    package { "sendmail":
        ensure => installed
    }

    service { "sendmail":
	require    => Package['sendmail'],
        ensure => running,
	hasstatus => false,
	enable     => true
    }

 file { "/etc/aliases":
    owner  => root,
    group  => root,
    mode   => 644,
    require    => Package['sendmail'],
    source => "puppet:///modules/system/aliases"
  } 

  exec { "/usr/sbin/newaliases": 
	subscribe =>  File["/etc/aliases"],
	refreshonly =>  true
  }

}


class system::snmpd {
  package { "snmpd":
    ensure => installed
  }

  package { "snmp":
    ensure => installed
  }

  package { "libnet-snmp-perl":
    ensure => installed
  }

  file { "/etc/snmp/snmpd.conf":
    owner  => root,
    group  => root,
    mode   => 600,
    require    => Package['snmpd'],
    source => "puppet:///modules/system/snmpd.conf",
  }

  file { "/etc/default/snmpd":
    owner  => root,
    group  => root,
    mode   => 644,
    require    => Package['snmpd'],
    source => "puppet:///modules/system/snmpd",
  }

  service { snmpd:
    enable     => true,
    ensure     => running,
    hasrestart => true,
    require    => Package['snmpd'],
    subscribe  => File["/etc/snmp/snmpd.conf","/etc/default/snmpd"]
  }
}

class system::history_timestamp {

  file { "/etc/profile.d/history_timestamp.sh":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/system/history_timestamp.sh",
  }
}

class system::collectl {
  package { "collectl":
    ensure => installed
  }

  file { "/etc/collectl.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    require    => Package['collectl'],
    source => "puppet:///modules/system/collectl.conf",
  }

  file { "/usr/share/collectl/graphite.ph":
    owner  => root,
    group  => root,
    mode   => 644,
    require    => Package['collectl'],
    source => "puppet:///modules/system/graphite.ph",
  }

  service { collectl:
    enable     => true,
    ensure     => running,
    hasrestart => true,
    hasstatus  => false,
    require    => Package['collectl'],
    subscribe  => File["/etc/collectl.conf","/usr/share/collectl/graphite.ph"]
  }
}

class system::lockrun {

  file { "/usr/local/bin/lockrun":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/system/lockrun",
  }
}



class system::disable_ipv6 {

     file { "/etc/sysctl.d/61-disable_ipv6.conf":
            owner  => root,
            group  => root,
            mode   => 644,
            source => "puppet:///modules/system/61-disable_ipv6.conf",
            notify  => Exec["sysctl"],
     }

#   exec { "service procps start":
#      alias => "sysctl",
#      refreshonly => true,
#      path        => ["/usr/bin", "/usr/sbin"],
#      subscribe => File["/etc/sysctl.d/61-disable_ipv6.conf"],
#   }
}

class system::report_fresh_core_files {

     file { "/opt/scripts/report_fresh_core_dumps.sh":
            owner  => root,
            group  => root,
            mode   => 755,
            source => "puppet:///modules/system/report_fresh_core_dumps.sh",
     }

     file { "/etc/cron.d/report_fresh_core_dumps":
            owner  => root,
            group  => root,
            mode   => 644,
            source => "puppet:///modules/system/report_fresh_core_dumps.crontab",
	    require => File["/opt/scripts/report_fresh_core_dumps.sh"]
     }
}

class system::clear_swap_space {

     file { "/opt/scripts/clear_swap_space.sh":
            owner  => root,
            group  => root,
            mode   => 755,
            source => "puppet:///modules/system/clear_swap_space.sh",
     }

     file { "/etc/cron.d/clear_swap_space":
            owner  => root,
            group  => root,
            mode   => 644,
            source => "puppet:///modules/system/clear_swap_space.crontab",
	    require => File["/opt/scripts/clear_swap_space.sh"]
     }
}

class system::disable_unattended_package_upgrades {

     file { "/etc/apt/apt.conf.d/10periodic":
            owner  => root,
            group  => root,
            mode   => 644,
            source => "puppet:///modules/system/10periodic",
     }

     file { "/etc/cron.weekly/update-notifier-common":
            ensure => absent
     }

     file { "/etc/apt/apt.conf.d/20auto-upgrades":
            ensure => absent
     }
}

class system::revsw-modify-network-settings {

     file { "/etc/init.d/revsw-modify-network-settings":
            owner  => root,
            group  => root,
            mode   => 755,
            source => "puppet:///modules/system/revsw-modify-network-settings",
     }

     service { revsw-modify-network-settings:
            enable     => true,
            require    => File['/etc/init.d/revsw-modify-network-settings'],
     }
}

class system::default_sysctl_conf {

     file { "/etc/sysctl.conf":
            owner  => root,
            group  => root,
            mode   => 644,
            source => "puppet:///modules/system/sysctl.conf",
            notify  => Exec["sysctl"],
     }

#   exec { "service procps start":
#      alias => "sysctl",
#      refreshonly => true,
#      path        => ["/usr/bin", "/usr/sbin"],
#      subscribe => File["/etc/sysctl.d/61-disable_ipv6.conf"],
#   }
}

class system::helping_scripts {

     file { "/opt/scripts/fix_ntp.sh":
            owner  => root,
            group  => root,
            mode   => 755,
            source => "puppet:///modules/system/fix_ntp.sh",
     }


  file { "/usr/local/sbin/tmessages":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/system/tmessages"
  }

  file { "/usr/local/sbin/tmongodb":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/system/tmongodb"
  }

  file { "/usr/local/bin/tapi":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/system/tapi"
  }

  file { "/usr/local/sbin/collect_debug_info.sh":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/system/collect_debug_info.sh"
  }
}


class system::report_sysctl_stats_to_graphite {

  file { "/opt/scripts/sysctl-graphite.sh":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/system/sysctl-graphite.sh",
  }

  file { "/opt/scripts/sysctl-graphite.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/system/sysctl-graphite.conf",
  }


  file { "/etc/cron.d/sysctl-graphite":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/system/sysctl-graphite.crontab",
  }
}


class system::resolv_conf_8_8_8_8 {

  $resolver_config_file = "puppet:///modules/system/resolv.conf_8_8_8_8"

  file { "/etc/resolv_new.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "$resolver_config_file",
  }

  file { "/opt/scripts/deploy_new_resolv_conf_file.sh":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/system/deploy_new_resolv_conf_file.sh",
  }

  exec { "/opt/scripts/deploy_new_resolv_conf_file.sh":
        subscribe =>  File["/etc/resolv_new.conf", "/opt/scripts/deploy_new_resolv_conf_file.sh"],
        refreshonly =>  true
  }
}

class system::resolv_conf_management {

    if $fqdn =~ /^SJC02-/ {
        $resolver_config_file = "puppet:///modules/system/resolv.conf_SJC02"
    }
    else {
        $resolver_config_file = "puppet:///modules/system/resolv.conf_IAD02"
    }

  file { "/etc/resolv_new.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "$resolver_config_file",
  }

  file { "/opt/scripts/deploy_new_resolv_conf_file.sh":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/system/deploy_new_resolv_conf_file.sh",
  }

  exec { "/opt/scripts/deploy_new_resolv_conf_file.sh": 
	subscribe =>  File["/etc/resolv_new.conf", "/opt/scripts/deploy_new_resolv_conf_file.sh"],
	refreshonly =>  true
  }
}

class system::run_apt_get_update {
	exec { "apt-get update":
		command => "/usr/bin/apt-get update",
		onlyif => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /var/cache/apt -name pkgcache.bin -mtime +4 | /bin/grep . > /dev/null'",
	}
}

class system::aoetools { 
  package { "aoetools":
    ensure => installed
  }

  file { "/etc/default/aoetools":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/system/aoetools.default",
    require    => Package['aoetools'],
    notify => Service["aoetools"]
  }

  service { aoetools:
    enable     => true,
    hasrestart => true,
    require    => Package['aoetools'],
  }
}


class system::test_xen_master {

  package { "xen-hypervisor-4.4-amd64":
    ensure => installed
  }

  package { "xen-tools":
    ensure => installed
  }

  file { "/etc/xen-tools/xen-tools.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/system/xen-tools.conf",
    require    => Package['xen-tools'],
  }
}

class system::run_update_locale {
    exec {'Running update-locale tool if file /etc/default/locale does not exist':
        command         => "/usr/sbin/update-locale",
        user            => root,
        onlyif          => "test ! -f /etc/default/locale",
        path            => ['/usr/bin','/usr/sbin','/bin','/sbin']
    }
}

