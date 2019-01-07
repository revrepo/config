
class purge_api::purge_api_app_1_2_4 {

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

  $revsw_api_package_file = "revsw-api_1.2.4.deb"

  $config_dir = "1.2.4"

  file { "/root/$revsw_api_package_file":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/purge_api/$revsw_api_package_file",
    notify => Exec['install_api']
  }

   exec { "dpkg -i /root/$revsw_api_package_file":
      alias => "install_api",
      refreshonly => true,
      path        => ["/usr/bin", "/usr/sbin", "/usr/local/sbin", "/bin", "/sbin"],
      subscribe => File["/root/$revsw_api_package_file"],
      require => File["/root/$revsw_api_package_file"],
      before => Package["revsw-api", "nodejs", "nodejs-legacy"]
   }

  package { "revsw-api":
    provider => dpkg,
    ensure => installed,
    source => "/root/$revsw_api_package_file",
    require => Package["nodejs-legacy"]
  }

    service { "revsw-api":
        require    => Package['revsw-api'],
#        ensure     => running,
        enable     => true,
        hasstatus => true,
    }


  file { "/opt/revsw-api/config/ssl_certs" :
    ensure  => directory,
    source  =>      "puppet:///modules/purge_api/$config_dir/ssl_certs",
    recurse =>      true,
    purge   =>      true,
    require    => Package['revsw-api'],
    notify => Service['revsw-api'],
    owner  => root,
    group  => root,
    mode   => 600,
  }

  file { "/opt/revsw-api/config/config.js":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/purge_api/$config_dir/config.js",
    notify => Service['revsw-api'],
    require => [Package['revsw-api'],File["/opt/revsw-api/config/ssl_certs"]],
  }
}



class purge_api::purge_api_app_1_2_3 {

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

  $revsw_api_package_file = "revsw-api_1.2.3.deb"

  $config_dir = "1.2.3"

  file { "/root/$revsw_api_package_file":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/purge_api/$revsw_api_package_file",
    notify => Exec['install_api']
  }

   exec { "dpkg -i /root/$revsw_api_package_file":
      alias => "install_api",
      refreshonly => true,
      path        => ["/usr/bin", "/usr/sbin", "/usr/local/sbin", "/bin", "/sbin"],
      subscribe => File["/root/$revsw_api_package_file"],
      require => File["/root/$revsw_api_package_file"],
      before => Package["revsw-api", "nodejs", "nodejs-legacy"]
   }

  package { "revsw-api":
    provider => dpkg,
    ensure => installed,
    source => "/root/$revsw_api_package_file",
    require => Package["nodejs-legacy"]
  }

    service { "revsw-api":
        require    => Package['revsw-api'],
#        ensure     => running,
        enable     => true,
        hasstatus => true,
    }


  file { "/opt/revsw-api/config/ssl_certs" :
    ensure  => directory,
    source  =>      "puppet:///modules/purge_api/$config_dir/ssl_certs",
    recurse =>      true,
    purge   =>      true,
    require    => Package['revsw-api'],
    notify => Service['revsw-api'],
    owner  => root,
    group  => root,
    mode   => 600,
  }

  file { "/opt/revsw-api/config/config.js":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/purge_api/$config_dir/config.js",
    notify => Service['revsw-api'],
    require => [Package['revsw-api'],File["/opt/revsw-api/config/ssl_certs"]],
  }
}


class purge_api::nodejs_app {

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


class purge_api::test_purge_api_app_2_0_7 {

  $revsw_api_package_file = "revsw-api_1.2.4.deb"

  $config_dir = "test_2.0.7"

#  file { "/root/$revsw_api_package_file":
#    owner  => root,
#    group  => root,
#    mode   => 644,
#    source => "puppet:///modules/purge_api/$revsw_api_package_file",
#    notify => Exec['install_api']
#  }

#   exec { "dpkg -i /root/$revsw_api_package_file":
#      alias => "install_api",
#      refreshonly => true,
#      path        => ["/usr/bin", "/usr/sbin", "/usr/local/sbin", "/bin", "/sbin"],
#      subscribe => File["/root/$revsw_api_package_file"],
#      require => File["/root/$revsw_api_package_file"],
#      before => Package["revsw-api", "nodejs", "nodejs-legacy"]
#   }

  package { "revsw-api":
#    provider => dpkg,
    ensure => installed,
#    source => "/root/$revsw_api_package_file",
    require => Package["nodejs-legacy"]
  }

    service { "revsw-api":
        require    => Package['revsw-api'],
#        ensure     => running,
        enable     => true,
        hasstatus => true,
    }


  file { "/opt/revsw-api/config/ssl_certs" :
    ensure  => directory,
    source  =>      "puppet:///modules/purge_api/$config_dir/ssl_certs",
    recurse =>      true,
    purge   =>      true,
    require    => Package['revsw-api'],
    notify => Service['revsw-api'],
    owner  => root,
    group  => root,
    mode   => 600,
  }

  file { "/opt/revsw-api/config/config.js":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/purge_api/$config_dir/config.js",
    notify => Service['revsw-api'],
    require => [Package['revsw-api'],File["/opt/revsw-api/config/ssl_certs"]],
  }
}

