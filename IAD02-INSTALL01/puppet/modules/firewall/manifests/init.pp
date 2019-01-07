class firewall::tarantool {
  package { "ufw":
    ensure => installed
  }

  file { "/opt/scripts/configure_tarantool_firewall.sh":
    owner  => root,
    group  => root,
    mode   => 700,
    source => "puppet:///modules/firewall/ufw_firewall_scripts/configure_tarantool_firewall.sh",
    require => Package['ufw'],
  }

   exec { '/usr/bin/yes | /opt/scripts/configure_tarantool_firewall.sh':
         path        => ["/usr/bin", "/usr/sbin"],
          subscribe   => File["/opt/scripts/configure_tarantool_firewall.sh"],
          refreshonly => true
   }
}

class firewall::elasticsearch_url {
  package { "ufw":
    ensure => installed
  }

  file { "/opt/scripts/configure_elasticsearch_url_firewall.sh":
    owner  => root,
    group  => root,
    mode   => 700,
    source => "puppet:///modules/firewall/ufw_firewall_scripts/configure_elasticsearch_url_firewall.sh",
    require => Package['ufw'],
  }

   exec { '/usr/bin/yes | /opt/scripts/configure_elasticsearch_url_firewall.sh':
         path        => ["/usr/bin", "/usr/sbin"],
          subscribe   => File["/opt/scripts/configure_elasticsearch_url_firewall.sh"],
          refreshonly => true
   }
}

class firewall::elasticsearch {
  package { "ufw":
    ensure => installed
  }

  file { "/opt/scripts/configure_elasticsearch_firewall.sh":
    owner  => root,
    group  => root,
    mode   => 700,
    source => "puppet:///modules/firewall/ufw_firewall_scripts/configure_elasticsearch_firewall.sh",
    require => Package['ufw'],
  }

   exec { '/usr/bin/yes | /opt/scripts/configure_elasticsearch_firewall.sh':
         path        => ["/usr/bin", "/usr/sbin"],
          subscribe   => File["/opt/scripts/configure_elasticsearch_firewall.sh"],
          refreshonly => true
   }
}

class firewall::website {
  package { "ufw":
    ensure => installed
  }

  file { "/opt/scripts/configure_website_firewall.sh":
    owner  => root,
    group  => root,
    mode   => 700,
    source => "puppet:///modules/firewall/ufw_firewall_scripts/configure_website_firewall.sh",
    require => Package['ufw'],
  }

   exec { '/usr/bin/yes | /opt/scripts/configure_website_firewall.sh':
         path        => ["/usr/bin", "/usr/sbin"],
          subscribe   => File["/opt/scripts/configure_website_firewall.sh"],
          refreshonly => true
   }
}

class firewall::rum {
  package { "ufw":
    ensure => installed
  }

  file { "/opt/scripts/configure_rum_firewall.sh":
    owner  => root,
    group  => root,
    mode   => 700,
    source => "puppet:///modules/firewall/ufw_firewall_scripts/configure_rum_firewall.sh",
    require => Package['ufw'],
  }

   exec { '/usr/bin/yes | /opt/scripts/configure_rum_firewall.sh':
         path        => ["/usr/bin", "/usr/sbin"],
          subscribe   => File["/opt/scripts/configure_rum_firewall.sh"],
          refreshonly => true
   }
}

class firewall::cube {
  package { "ufw":
    ensure => installed
  }

  file { "/opt/scripts/configure_cube_firewall.sh":
    owner  => root,
    group  => root,
    mode   => 700,
    source => "puppet:///modules/firewall/ufw_firewall_scripts/configure_cube_firewall.sh",
    require => Package['ufw'],
  }

   exec { '/usr/bin/yes | /opt/scripts/configure_cube_firewall.sh':
         path        => ["/usr/bin", "/usr/sbin"],
          subscribe   => File["/opt/scripts/configure_cube_firewall.sh"],
          refreshonly => true
   }
}

class firewall::rmdb {
  package { "ufw":
    ensure => installed
  }

  file { "/opt/scripts/configure_rmdb_firewall.sh":
    owner  => root,
    group  => root,
    mode   => 700,
    source => "puppet:///modules/firewall/ufw_firewall_scripts/configure_rmdb_firewall.sh",
    require => Package['ufw'],
  }

   exec { '/usr/bin/yes | /opt/scripts/configure_rmdb_firewall.sh':
         path        => ["/usr/bin", "/usr/sbin"],
          subscribe   => File["/opt/scripts/configure_rmdb_firewall.sh"],
          refreshonly => true
   }
}


class firewall::portal {
  package { "ufw":
    ensure => installed
  }

  file { "/opt/scripts/configure_portal_firewall.sh":
    owner  => root,
    group  => root,
    mode   => 700,
    source => "puppet:///modules/firewall/ufw_firewall_scripts/configure_portal_firewall.sh",
    require => Package['ufw'],
  }

   exec { '/usr/bin/yes | /opt/scripts/configure_portal_firewall.sh':
         path        => ["/usr/bin", "/usr/sbin"],
          subscribe   => File["/opt/scripts/configure_portal_firewall.sh"],
          refreshonly => true
   }
}


class firewall::manager {
  package { "ufw":
    ensure => installed
  }

  file { "/opt/scripts/configure_manager_firewall.sh":
    owner  => root,
    group  => root,
    mode   => 700,
    source => "puppet:///modules/firewall/ufw_firewall_scripts/configure_manager_firewall.sh",
    require => Package['ufw'],
  }

   exec { '/usr/bin/yes | /opt/scripts/configure_manager_firewall.sh':
         path        => ["/usr/bin", "/usr/sbin"],
          subscribe   => File["/opt/scripts/configure_manager_firewall.sh"],
          refreshonly => true
   }
}


class firewall::backup {
  package { "ufw":
    ensure => installed
  }

  file { "/opt/scripts/configure_backup_firewall.sh":
    owner  => root,
    group  => root,
    mode   => 700,
    source => "puppet:///modules/firewall/ufw_firewall_scripts/configure_backup_firewall.sh",
    require => Package['ufw'],
  }

   exec { '/usr/bin/yes | /opt/scripts/configure_backup_firewall.sh':
         path        => ["/usr/bin", "/usr/sbin"],
          subscribe   => File["/opt/scripts/configure_backup_firewall.sh"],
          refreshonly => true
   }
}


class firewall::api {
  package { "ufw":
    ensure => installed
  }

  file { "/opt/scripts/configure_api_firewall.sh":
    owner  => root,
    group  => root,
    mode   => 700,
    source => "puppet:///modules/firewall/ufw_firewall_scripts/configure_api_firewall.sh",
    require => Package['ufw'],
  }

   exec { '/usr/bin/yes | /opt/scripts/configure_api_firewall.sh':
         path        => ["/usr/bin", "/usr/sbin"],
          subscribe   => File["/opt/scripts/configure_api_firewall.sh"],
          refreshonly => true
   }
}


class firewall::graphite {
  package { "ufw":
    ensure => installed
  }

  file { "/opt/scripts/configure_graphite_firewall.sh":
    owner  => root,
    group  => root,
    mode   => 700,
    source => "puppet:///modules/firewall/ufw_firewall_scripts/configure_graphite_firewall.sh",
    require => Package['ufw'],
  }

   exec { '/usr/bin/yes | /opt/scripts/configure_graphite_firewall.sh':
 	 path        => ["/usr/bin", "/usr/sbin"],
	  subscribe   => File["/opt/scripts/configure_graphite_firewall.sh"],
	  refreshonly => true
   }
}

class firewall::monitor {
  package { "ufw":
    ensure => installed
  }

  file { "/opt/scripts/configure_monitor_firewall.sh":
    owner  => root,
    group  => root,
    mode   => 700,
    source => "puppet:///modules/firewall/ufw_firewall_scripts/configure_monitor_firewall.sh",
    require => Package['ufw'],
  }

  file { "/etc/ufw/sysctl.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/firewall/ufw_sysctl.conf",
    require => Package['ufw'],
  }

   exec { '/usr/bin/yes | /opt/scripts/configure_monitor_firewall.sh':
 	 path        => ["/usr/bin", "/usr/sbin"],
	  subscribe   => File["/opt/scripts/configure_monitor_firewall.sh", "/etc/ufw/sysctl.conf" ],
	  refreshonly => true
   }
}

class firewall::install {
  package { "ufw":
    ensure => installed
  }

  file { "/opt/scripts/configure_install_firewall.sh":
    owner  => root,
    group  => root,
    mode   => 700,
    source => "puppet:///modules/firewall/ufw_firewall_scripts/configure_install_firewall.sh",
    require => Package['ufw'],
  }

   exec { '/usr/bin/yes | /opt/scripts/configure_install_firewall.sh':
 	 path        => ["/usr/bin", "/usr/sbin"],
	  subscribe   => File["/opt/scripts/configure_install_firewall.sh"],
	  refreshonly => true
   }
}

class firewall::proxy {
  package { "ufw":
    ensure => installed
  }

  file { "/opt/scripts/configure_proxy_firewall.sh":
    owner  => root,
    group  => root,
    mode   => 700,
    source => "puppet:///modules/firewall/ufw_firewall_scripts/configure_proxy_firewall.sh",
    require => Package['ufw'],
  }

  file { "/etc/ufw/sysctl.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/firewall/ufw_sysctl.conf",
    require => Package['ufw'],
  }


   exec { '/usr/bin/yes | /opt/scripts/configure_proxy_firewall.sh':
         path        => ["/usr/bin", "/usr/sbin"],
          subscribe   => File["/opt/scripts/configure_proxy_firewall.sh", "/etc/ufw/sysctl.conf" ],
          refreshonly => true
   }
}

class firewall::set_max_conntrack {

     file { "/etc/sysctl.d/60-set_max_conntrack.conf":
    	    owner  => root,
	    group  => root,
	    mode   => 644,
	    source => "puppet:///modules/firewall/60-set_max_conntrack.conf",
            notify  => Exec["sysctl"],
     }

   exec { "service procps start":
      alias => "sysctl",
      refreshonly => true,
      path        => ["/usr/bin", "/usr/sbin"],
      subscribe => File["/etc/sysctl.d/60-set_max_conntrack.conf"],
   }
}

class firewall::enable_conntrack_liberal {

     file { "/etc/sysctl.d/61-enable_conntrack_liberal.conf":
    	    owner  => root,
	    group  => root,
	    mode   => 644,
	    source => "puppet:///modules/firewall/61-enable_conntrack_liberal.conf",
            notify  => Exec["sysctl"],
     }
}

class firewall::cmdb_servers {

  package { "ufw":
    ensure => installed
  }

  file { "/opt/scripts/configure_cmdb_firewall.sh":
    owner  => root,
    group  => root,
    mode   => 700,
    source => "puppet:///modules/firewall/ufw_firewall_scripts/configure_cmdb_firewall.sh",
    require => Package['ufw'],
  }

   exec { '/usr/bin/yes | /opt/scripts/configure_cmdb_firewall.sh':
 	 path        => ["/usr/bin", "/usr/sbin"],
	  subscribe   => File["/opt/scripts/configure_cmdb_firewall.sh"],
	  refreshonly => true
   }
}



class firewall::cds {
  package { "ufw":
    ensure => installed
  }

  file { "/opt/scripts/configure_cds_firewall.sh":
    owner  => root,
    group  => root,
    mode   => 700,
    source => "puppet:///modules/firewall/ufw_firewall_scripts/configure_cds_firewall.sh",
    require => Package['ufw'],
  }

   exec { '/usr/bin/yes | /opt/scripts/configure_cds_firewall.sh':
         path        => ["/usr/bin", "/usr/sbin"],
          subscribe   => File["/opt/scripts/configure_cds_firewall.sh"],
          refreshonly => true
   }
}

class firewall::logshipper {
  package { "ufw":
    ensure => installed
  }

  file { "/opt/scripts/configure_logshipper_firewall.sh":
    owner  => root,
    group  => root,
    mode   => 700,
    source => "puppet:///modules/firewall/ufw_firewall_scripts/configure_logshipper_firewall.sh",
    require => Package['ufw'],
  }

   exec { '/usr/bin/yes | /opt/scripts/configure_logshipper_firewall.sh':
         path        => ["/usr/bin", "/usr/sbin"],
          subscribe   => File["/opt/scripts/configure_logshipper_firewall.sh"],
          refreshonly => true
   }
}


class firewall::webtest {
  package { "ufw":
    ensure => installed
  }

  file { "/opt/scripts/configure_webtest_firewall.sh":
    owner  => root,
    group  => root,
    mode   => 700,
    source => "puppet:///modules/firewall/ufw_firewall_scripts/configure_webtest_firewall.sh",
    require => Package['ufw'],
  }

   exec { '/usr/bin/yes | /opt/scripts/configure_webtest_firewall.sh':
         path        => ["/usr/bin", "/usr/sbin"],
          subscribe   => File["/opt/scripts/configure_webtest_firewall.sh"],
          refreshonly => true
   }
}

class firewall::wpt-server {
  package { "ufw":
    ensure => installed
  }

  file { "/opt/scripts/configure_wpt-server_firewall.sh":
    owner  => root,
    group  => root,
    mode   => 700,
    source => "puppet:///modules/firewall/ufw_firewall_scripts/configure_wpt-server_firewall.sh",
    require => Package['ufw'],
  }

   exec { '/usr/bin/yes | /opt/scripts/configure_wpt-server_firewall.sh':
         path        => ["/usr/bin", "/usr/sbin"],
          subscribe   => File["/opt/scripts/configure_wpt-server_firewall.sh"],
          refreshonly => true
   }
}

