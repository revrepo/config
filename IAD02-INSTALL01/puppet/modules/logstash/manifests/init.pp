
class logstash::logstash_app {

#    package { "openjdk-7-jre-headless": 
#        ensure => installed 
#    }

  $pkg_file = "logstash_1.5.6-1_all.deb"

  file { "/root/$pkg_file":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/logstash/$pkg_file",
    notify => Exec['install_logstash']
  }

   exec { "dpkg -i /root/$pkg_file":
      alias => "install_logstash",
      refreshonly => true,
      path        => ["/usr/bin", "/usr/sbin", "/usr/local/sbin", "/bin", "/sbin"],
      subscribe => File["/root/$pkg_file"],
      require => File["/root/$pkg_file"],
      before => Package["logstash"]
   }

  package { "logstash":
    provider => dpkg,
    ensure => installed,
    source => "/root/$pkg_file"
#    require => Package["openjdk-7-jre-headless"]
  }

    service { "logstash":
        require    => Package['logstash'],
#        ensure     => running,
        enable     => true,
        hasstatus => true,
    }

#    service { "logstash-web":
#        require    => Package['logstash'],
#        ensure     => stopped,
#        enable     => false,
#        hasstatus => true,
#    }

#  file { "/etc/init/logstash.conf":
#    owner  => root,
#    group  => root,
#    mode   => 755,
#    source => "puppet:///modules/logstash/logstash_upstart.conf",
#    require => Package["logstash"],
#    notify => Service["logstash"],
#  }

#  file { "/etc/init/logstash.conf":
#    ensure => absent
#  }

  file { "/etc/default/logstash":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/logstash/logstash.default",
    require => Package["logstash"],
    notify => Service["logstash"],
  }

  file { "/etc/logstash/logstash-forwarder.key":
    owner  => logstash,
    group  => logstash,
    mode   => 400,
    source => "puppet:///modules/logstash/logstash-forwarder.key",
    require => Package["logstash"],
    notify => Service["logstash"],
  }

  file { "/etc/logstash/logstash-forwarder.crt":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/logstash/logstash-forwarder.crt",
    require => Package["logstash"],
    notify => Service["logstash"],
  }

  file { "/etc/logstash/conf.d/01-lumberjack-input.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/logstash/01-lumberjack-input.conf",
    require => Package["logstash"],
    notify => Service["logstash"],
  }

#  file { "/opt/logstash/patterns/grok-patterns":
#    owner  => root,
#    group  => root,
#    mode   => 644,
#    source => "puppet:///modules/logstash/grok-patterns",
#    require => Package["logstash"],
#    notify => Service["logstash"],
#  }

  file { 'MaxMind Database for Logstash GeoIP module':
    path => '/opt/logstash/vendor/bundle/jruby/1.9/gems/logstash-filter-geoip-1.1.2/vendor',
    source => "puppet:///modules/logstash/maxmind",
    recurse => true,
    purge => true
  }

}


class logstash::test_logstash_app {


  $pkg_file = "logstash_1.5.6-1_all.deb"
  $config_dir = "test_1.4.2"

  file { "/root/$pkg_file":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/logstash/$pkg_file",
    notify => Exec['install_logstash']
  }

   exec { "dpkg -i /root/$pkg_file":
      alias => "install_logstash",
      refreshonly => true,
      path        => ["/usr/bin", "/usr/sbin", "/usr/local/sbin", "/bin", "/sbin"],
      subscribe => File["/root/$pkg_file"],
      require => File["/root/$pkg_file"],
      before => Package["logstash"]
   }

  package { "logstash":
    provider => dpkg,
    ensure => installed,
    source => "/root/$pkg_file",
    require => Package["openjdk-7-jre-headless"]
  }

    service { "logstash":
        require    => Package['logstash'],
        ensure     => running,
        enable     => true,
        hasstatus => true,
    }

#    service { "logstash-web":
#        require    => Package['logstash'],
#        ensure     => stopped,
#        enable     => false,
#        hasstatus => true,
#    }

  file { "/etc/init/logstash.conf":
    ensure => absent
  }

  file { "/etc/default/logstash":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/logstash/$config_dir/logstash.default",
    require => Package["logstash"],
    notify => Service["logstash"],
  }

  file { "/etc/logstash/logstash-forwarder.key":
    owner  => logstash,
    group  => logstash,
    mode   => 400,
    source => "puppet:///modules/logstash/$config_dir/logstash-forwarder.key",
    require => Package["logstash"],
    notify => Service["logstash"],
  }

  file { "/etc/logstash/logstash-forwarder.crt":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/logstash/$config_dir/logstash-forwarder.crt",
    require => Package["logstash"],
    notify => Service["logstash"],
  }

  file { "/etc/logstash/conf.d/01-lumberjack-input.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/logstash/$config_dir/01-lumberjack-input.conf",
    require => Package["logstash"],
    notify => Service["logstash"],
  }

#  file { "/opt/logstash/patterns/grok-patterns":
#    owner  => root,
#    group  => root,
#    mode   => 644,
#    source => "puppet:///modules/logstash/$config_dir/grok-patterns",
#    require => Package["logstash"],
#    notify => Service["logstash"],
#  }

  file { 'MaxMind Database for Logstash GeoIP module':
    path => '/opt/logstash/vendor/bundle/jruby/1.9/gems/logstash-filter-geoip-1.1.2/vendor',
    source => "puppet:///modules/logstash/$config_dir/maxmind",
    recurse => true,
    purge => true
  }
}


class logstash::logstash_geoip_database_20150123 {

  $date="20150123"

  file { "/opt/logstash/vendor/geoip/GeoIPASNum.dat":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/logstash//geoip-database/$date/GeoIPASNum.dat",
    require => Package["logstash"],
    notify => Service["logstash"],
  }

  file { "/opt/logstash/vendor/geoip/GeoLiteCity.dat":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/logstash//geoip-database/$date/GeoLiteCity.dat",
    require => Package["logstash"],
    notify => Service["logstash"],
  }
}


class logstash::logstash-forwarder {

  file { "/root/logstash-forwarder_0.3.1_amd64.deb":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/logstash/logstash-forwarder_0.3.1_amd64.deb",
    notify => Exec['install_logstash-forwarder']
  }

   exec { "dpkg -i /root/logstash-forwarder_0.3.1_amd64.deb":
      alias => "install_logstash-forwarder",
      refreshonly => true,
      path        => ["/usr/bin", "/usr/sbin", "/usr/local/sbin", "/bin", "/sbin"],
      subscribe => File["/root/logstash-forwarder_0.3.1_amd64.deb"],
      require => File["/root/logstash-forwarder_0.3.1_amd64.deb"],
      before => Package["logstash-forwarder"]
   }

  package { "logstash-forwarder":
    provider => dpkg,
    ensure => installed,
    source => "/root/logstash-forwarder_0.3.1_amd64.deb",
  }

    service { "logstash-forwarder":
        require    => Package['logstash-forwarder'],
#        ensure     => running,
        enable     => true,
        hasstatus => true,
    }

  file { "/etc/logstash-forwarder":
    owner  => root,
    group  => root,
    mode   => 644,
    ensure => "directory",
  }

  file { "/etc/default/logstash-forwarder":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/logstash/logstash-forwarder.default",
    require => Package["logstash-forwarder"],
    notify => Service["logstash-forwarder"],
  }

  file { "/etc/logstash-forwarder/logstash-forwarder.crt":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/logstash/logstash-forwarder.crt",
    require => [ Package["logstash-forwarder"], File["/etc/logstash-forwarder"]],
    notify => Service["logstash-forwarder"],
  }

  file { "/etc/logstash-forwarder/logstash-forwarder.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/logstash/logstash-forwarder.conf",
    require => [ Package["logstash-forwarder"], File["/etc/logstash-forwarder"]],
    notify => Service["logstash-forwarder"],
  }
}

class logstash::logstash-forwarder_0_4_0 {

  $pkg_file = "logstash-forwarder_0.4.0_amd64.deb"
  $config_dir = "logstash_forwarder_0.4.0"

  file { "/root/$pkg_file":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/logstash/$pkg_file",
    notify => Exec['install_logstash-forwarder']
  }

   exec { "dpkg -i /root/$pkg_file":
      alias => "install_logstash-forwarder",
      refreshonly => true,
      path        => ["/usr/bin", "/usr/sbin", "/usr/local/sbin", "/bin", "/sbin"],
      subscribe => File["/root/$pkg_file"],
      require => File["/root/$pkg_file"],
      before => Package["logstash-forwarder"]
   }

  package { "logstash-forwarder":
    provider => dpkg,
    ensure => installed,
    source => "/root/$pkg_file",
  }

    service { "logstash-forwarder":
        require    => Package['logstash-forwarder'],
        ensure     => running,
        enable     => true,
        hasstatus => true,
    }

  file { "/etc/logstash-forwarder":
    owner  => root,
    group  => root,
    mode   => 644,
    ensure => "directory",
  }

  file { "/etc/default/logstash-forwarder":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/logstash/$config_dir/logstash-forwarder.default",
    require => Package["logstash-forwarder"],
    notify => Service["logstash-forwarder"],
  }

  file { "/etc/logstash-forwarder/logstash-forwarder.crt":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/logstash/$config_dir/logstash-forwarder.crt",
    require => [ Package["logstash-forwarder"], File["/etc/logstash-forwarder"]],
    notify => Service["logstash-forwarder"],
  }

  file { "/etc/logstash-forwarder/logstash-forwarder.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/logstash/$config_dir/logstash-forwarder.conf",
    require => [ Package["logstash-forwarder"], File["/etc/logstash-forwarder"]],
    notify => Service["logstash-forwarder"],
  }

  # Old configuration file provided by the package - it is not used by application
  file { "/etc/logstash-forwarder.conf":
    ensure => absent
  }

  # By default logstash-forwarded package adds group logstash-forwarder with ID 999 which
  # is used by group sysadmin - need to change the ID to 3999
  group { "logstash-forwarder":
    gid => 3999,
    require => [ Package["logstash-forwarder"]]
  }
}



class logstash::test_logstash-forwarder {

  $config_dir = "test_logstash_forwarder"

  file { "/root/logstash-forwarder_0.4.0_amd64.deb":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/logstash/logstash-forwarder_0.4.0_amd64.deb",
    notify => Exec['install_logstash-forwarder']
  }

   exec { "dpkg -i /root/logstash-forwarder_0.4.0_amd64.deb":
      alias => "install_logstash-forwarder",
      refreshonly => true,
      path        => ["/usr/bin", "/usr/sbin", "/usr/local/sbin", "/bin", "/sbin"],
      subscribe => File["/root/logstash-forwarder_0.4.0_amd64.deb"],
      require => File["/root/logstash-forwarder_0.4.0_amd64.deb"],
      before => Package["logstash-forwarder"]
   }

  package { "logstash-forwarder":
    provider => dpkg,
    ensure => installed,
    source => "/root/logstash-forwarder_0.4.0_amd64.deb",
  }

    service { "logstash-forwarder":
        require    => Package['logstash-forwarder'],
        ensure     => running,
        enable     => true,
        hasstatus => true,
    }

  file { "/etc/logstash-forwarder":
    owner  => root,
    group  => root,
    mode   => 644,
    ensure => "directory",
  }

  file { "/etc/default/logstash-forwarder":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/logstash/$config_dir/logstash-forwarder.default",
    require => Package["logstash-forwarder"],
    notify => Service["logstash-forwarder"],
  }

  file { "/etc/logstash-forwarder/logstash-forwarder.crt":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/logstash/$config_dir/logstash-forwarder.crt",
    require => [ Package["logstash-forwarder"], File["/etc/logstash-forwarder"]],
    notify => Service["logstash-forwarder"],
  }

  file { "/etc/logstash-forwarder/logstash-forwarder.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/logstash/$config_dir/logstash-forwarder.conf",
    require => [ Package["logstash-forwarder"], File["/etc/logstash-forwarder"]],
    notify => Service["logstash-forwarder"],
  }

  group { "logstash-forwarder":
    gid => 3999,
    require => [ Package["logstash-forwarder"]]
  }
}

class logstash::pin_logstash_verson_1_4_2 {
  file { "/etc/apt/preferences.d/pin-logstash-version-1_4_2-1-2c0f5a1":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/logstash/pin-logstash-version-1_4_2-1-2c0f5a1",
#    require => Package["elasticsearch"]
  }
}
