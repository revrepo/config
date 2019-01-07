
class nagios::nagios_app {

  service { nagios:
    enable     => true,
    ensure     => running,
    start   => "/etc/init.d/nagios start",
    stop    => "/etc/init.d/nagios stop",
    status  => "/etc/init.d/nagios status",
    hasrestart => true
  }

}

class nagios::nrpe_agent {

  package { "nagios-nrpe-server":
    ensure => installed
  }

  package { "nagios-plugins":
    ensure => installed
  }

  file { "/etc/nagios/nrpe.cfg":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/nagios/nrpe.cfg",
    require => Package['nagios-nrpe-server'],
    notify => Service['nagios-nrpe-server']
  }

  service { nagios-nrpe-server:
    ensure     => running,
    hasrestart => true,
    require => Package['nagios-nrpe-server'],
  }

  file { "/usr/lib/nagios/plugins/check_wpt_agents.py":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/nagios/check_wpt_agents.py",
    require => Package['nagios-nrpe-server'],
  }

  file { "/usr/lib/nagios/plugins/check_mongodb":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/nagios/check_mongodb",
    require => Package['nagios-nrpe-server'],
  }

  file { "/usr/lib/nagios/plugins/check_listen_tcp_udp_port.sh":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/nagios/check_listen_tcp_udp_port.sh",
    require => Package['nagios-nrpe-server'],
  }

  file { "/usr/lib/nagios/plugins/check_forkrate.sh":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/nagios/check_forkrate.sh",
    require => Package['nagios-nrpe-server'],
  }

  file { "/usr/lib/nagios/plugins/check_md_raid.sh":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/nagios/check_md_raid.sh",
    require => Package['nagios-nrpe-server'],
  }

  file { "/usr/lib/nagios/plugins/check_proc_filehandles.pl":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/nagios/check_proc_filehandles.pl",
    require => Package['nagios-nrpe-server'],
  }

  file { "/usr/lib/nagios/plugins/check_apache_server-status.pl":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/nagios/check_apache_server-status.pl",
    require => Package['nagios-nrpe-server'],
  }

  file { "/usr/lib/nagios/plugins/check_puppet_agent":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/nagios/check_puppet_agent",
    require => Package['nagios-nrpe-server'],
  }

  file { "/usr/lib/nagios/plugins/check_inodes":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/nagios/check_inodes",
    require => Package['nagios-nrpe-server'],
  }

  file { "/usr/lib/nagios/plugins/check_sysctl":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/nagios/check_sysctl",
    require => Package['nagios-nrpe-server'],
  }

  file { "/usr/lib/nagios/plugins/check_nofile_limits.sh":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/nagios/check_nofile_limits.sh",
    require => Package['nagios-nrpe-server'],
  }

  file { "/usr/lib/nagios/plugins/check_mem.pl":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/nagios/check_mem.pl",
    require => Package['nagios-nrpe-server'],
  }

  file { "/usr/lib/nagios/plugins/check_snmp_procs.pl":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/nagios/check_snmp_procs.pl",
    require => Package['nagios-nrpe-server'],
  }

  file { "/usr/lib/nagios/plugins/check_snmp_load.pl":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/nagios/check_snmp_load.pl",
    require => Package['nagios-nrpe-server'],
  }

  file { "/usr/lib/nagios/plugins/check_ipmi_sensor":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/nagios/check_ipmi_sensor",
    require => Package['nagios-nrpe-server'],
  }

  file { "/usr/lib/nagios/plugins/check_cpu_stats.sh":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/nagios/check_cpu_stats.sh",
    require => Package['nagios-nrpe-server'],
  }

  file { "/usr/lib/nagios/plugins/check_ufw_status.sh":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/nagios/check_ufw_status.sh",
    require => Package['nagios-nrpe-server'],
  }

  file { "/usr/lib/nagios/plugins/check_kernel_version.sh":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/nagios/check_kernel_version.sh",
    require => Package['nagios-nrpe-server'],
  }

  file { "/usr/lib/nagios/plugins/check_puppetmaster":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/nagios/check_puppetmaster",
    require => Package['nagios-nrpe-server'],
  }

  file { "/etc/default/check_puppetmaster":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/nagios/check_puppetmaster.default",
    require => Package['nagios-nrpe-server'],
  }

  file { "/usr/lib/nagios/plugins/check_shared_memory_usage.sh":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/nagios/check_shared_memory_usage.sh",
    require => Package['nagios-nrpe-server'],
  }

  file { "/usr/lib/nagios/plugins/check_linux_context_switches.pl":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/nagios/check_linux_context_switches.pl",
    require => Package['nagios-nrpe-server'],
  }

  file { "/usr/lib/nagios/plugins/check_varnish_backend_health.py":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/nagios/check_varnish_backend_health.py",
    require => Package['nagios-nrpe-server'],
  }

  file { "/usr/lib/nagios/plugins/check_linux_interface.pl":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/nagios/check_linux_interface.pl",
    require => Package['nagios-nrpe-server'],
  }

  file { "/usr/lib/nagios/plugins/restart_cds_service.sh":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/nagios/restart_cds_service.sh",
    require => Package['nagios-nrpe-server'],
  }

  file { "/usr/lib/nagios/plugins/lib" :
    ensure  => directory,
    source  =>      "puppet:///modules/nagios/lib",
    recurse =>      true,
    purge   =>      true,
    require    => Package['nagios-nrpe-server'],
    owner  => root,
    group  => root,
    mode   => 644,
  }
}

