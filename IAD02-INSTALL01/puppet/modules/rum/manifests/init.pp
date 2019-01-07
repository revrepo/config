
class rum::nodejs_app {

  include nodejs

  package { "npm":
    ensure => installed
  }

  package { 'forever':
    ensure   => installed,
    provider => 'npm',
  }

  package { "nodejs-legacy":
    ensure => installed
  }
}

class rum::rum_app {

  include nodejs

  package { "npm":
    ensure => installed
  }

  package { 'forever':
    ensure   => installed,
    provider => 'npm',
  }

  package { "nodejs-legacy":
    ensure => installed
  }

  $revsw_rum_package_file = "revsw-rum_2.0.5.deb"

  file { "/root/$revsw_rum_package_file":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/rum/$revsw_rum_package_file",
    notify => Exec['install_rum']
  }

   exec { "dpkg -i /root/$revsw_rum_package_file":
      alias => "install_rum",
      refreshonly => true,
      path        => ["/usr/bin", "/usr/sbin", "/usr/local/sbin", "/bin", "/sbin"],
      subscribe => File["/root/$revsw_rum_package_file"],
      require => File["/root/$revsw_rum_package_file"],
      before => Package["revsw-rum", "nodejs", "nodejs-legacy"]
   }

  package { "revsw-rum":
    provider => dpkg,
    ensure => installed,
    source => "/root/$revsw_rum_package_file",
    require => Package["nodejs-legacy"]
  }

    service { "revsw-rum":
        require    => Package['revsw-rum'],
#        ensure     => running,
        enable     => true,
        hasstatus => true,
    }


  file { "/opt/revsw-rum/config/ssl_certs" :
    ensure  => directory,
    source  =>      "puppet:///modules/rum/ssl_certs",
    recurse =>      true,
    purge   =>      true,
    require    => Package['revsw-rum'],
    notify => Service['revsw-rum'],
    owner  => root,
    group  => root,
    mode   => 600,
  }

  file { "/opt/revsw-rum/config/config.js":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/rum/config.js",
    notify => Service['revsw-rum'],
    require => [Package['revsw-rum'],File["/opt/revsw-rum/config/ssl_certs"]],
  }
}

class rum::rum_app_3_0 {

  include nodejs

  package { "npm":
    ensure => installed
  }

  package { 'forever':
    ensure   => installed,
    provider => 'npm',
  }

  package { "nodejs-legacy":
    ensure => installed
  }

  $revsw_rum_package_file = "revsw-rum_3.0.6.deb"

  file { "/root/$revsw_rum_package_file":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/rum/$revsw_rum_package_file",
    notify => Exec['install_rum']
  }

   exec { "dpkg -i /root/$revsw_rum_package_file":
      alias => "install_rum",
      refreshonly => true,
      path        => ["/usr/bin", "/usr/sbin", "/usr/local/sbin", "/bin", "/sbin"],
      subscribe => File["/root/$revsw_rum_package_file"],
      require => File["/root/$revsw_rum_package_file"],
      before => Package["revsw-rum", "nodejs", "nodejs-legacy"]
   }

  package { "revsw-rum":
    provider => dpkg,
    ensure => installed,
    source => "/root/$revsw_rum_package_file",
    require => Package["nodejs-legacy"]
  }

    service { "revsw-rum":
        require    => Package['revsw-rum'],
#        ensure     => running,
        enable     => true,
        hasstatus => true,
    }


  file { "/opt/revsw-rum/config/ssl_certs" :
    ensure  => directory,
    source  =>      "puppet:///modules/rum/ssl_certs",
    recurse =>      true,
    purge   =>      true,
    require    => Package['revsw-rum'],
    notify => Service['revsw-rum'],
    owner  => root,
    group  => root,
    mode   => 600,
  }

  file { "/opt/revsw-rum/config/config.js":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/rum/config.js.3.0",
    notify => Service['revsw-rum'],
    require => [Package['revsw-rum'],File["/opt/revsw-rum/config/ssl_certs"]],
  }
}

class rum::test_rum_app_3_0 {

  $revsw_rum_package_file = "revsw-rum_3.0.6.deb"

  $config_dir = "test_3.0.2"

#  file { "/root/$revsw_rum_package_file":
#    owner  => root,
#    group  => root,
#    mode   => 644,
#    source => "puppet:///modules/rum/$revsw_rum_package_file",
#    notify => Exec['install_rum']
#  }

#   exec { "dpkg -i /root/$revsw_rum_package_file":
#      alias => "install_rum",
#      refreshonly => true,
#      path        => ["/usr/bin", "/usr/sbin", "/usr/local/sbin", "/bin", "/sbin"],
#      subscribe => File["/root/$revsw_rum_package_file"],
#      require => File["/root/$revsw_rum_package_file"],
#      before => Package["revsw-rum", "nodejs", "nodejs-legacy"]
#   }

  package { "revsw-rum":
#    provider => dpkg,
    ensure => installed,
#    source => "/root/$revsw_rum_package_file",
    require => Package["nodejs-legacy"]
  }

    service { "revsw-rum":
        require    => Package['revsw-rum'],
#        ensure     => running,
        enable     => true,
        hasstatus => true,
    }


  file { "/opt/revsw-rum/config/ssl_certs" :
    ensure  => directory,
    source  =>      "puppet:///modules/rum/$config_dir/ssl_certs",
    recurse =>      true,
    purge   =>      true,
    require    => Package['revsw-rum'],
    notify => Service['revsw-rum'],
    owner  => root,
    group  => root,
    mode   => 600,
  }

  file { "/opt/revsw-rum/config/config.js":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/rum/$config_dir/config.js",
    notify => Service['revsw-rum'],
    require => [Package['revsw-rum'],File["/opt/revsw-rum/config/ssl_certs"]],
  }
}
