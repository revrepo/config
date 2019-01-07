
class revsw-api::nodejs_app {

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


class revsw-api::revsw-api {

  $config_dir = "1.0.8"

  package { "revsw-api":
#    provider => dpkg,
    ensure => installed,
#    source => "/root/$revsw_api_package_file",
    require => Package["redis-server"]
  }

    service { "revsw-api":
        require    => Package['revsw-api'],
#        ensure     => running,
        enable     => true,
        hasstatus => true,
    }


  file { "/opt/revsw-api/config/ssl_certs" :
    ensure  => directory,
    source  =>      "puppet:///modules/revsw-api/$config_dir/ssl_certs",
    recurse =>      true,
    purge   =>      true,
    require    => Package['revsw-api'],
    notify => Service['revsw-api'],
    owner  => root,
    group  => root,
    mode   => 600,
  }

  file { "/etc/default/revsw-api":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/revsw-api/$config_dir/revsw-api.default",
    notify => Service['revsw-api'],
    require => [Package['revsw-api']],
  }


  package { "redis-server":
    ensure => installed
  }

  package { 'redis-tools':
    ensure   => installed
  }

}


class revsw-api::test_revsw-api {

  $config_dir = "test_1.0.8"

  package { "revsw-api":
#    provider => dpkg,
    ensure => installed,
#    source => "/root/$revsw_api_package_file",
    require => Package["redis-server"]
  }

    service { "revsw-api":
        require    => Package['revsw-api'],
#        ensure     => running,
        enable     => true,
        hasstatus => true,
    }

  file { "/etc/default/revsw-api":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/revsw-api/$config_dir/revsw-api.default",
    notify => Service['revsw-api'],
    require => [Package['revsw-api']],
  }

  file { "/opt/revsw-api/config/ssl_certs" :
    ensure  => directory,
    source  =>      "puppet:///modules/revsw-api/$config_dir/ssl_certs",
    recurse =>      true,
    purge   =>      true,
    require    => Package['revsw-api'],
    notify => Service['revsw-api'],
    owner  => root,
    group  => root,
    mode   => 600,
  }

  package { "redis-server":
    ensure => installed
  }

  package { 'redis-tools':
    ensure   => installed
  }

}

