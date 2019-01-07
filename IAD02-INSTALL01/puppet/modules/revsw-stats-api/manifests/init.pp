
class revsw-stats-api::nodejs_app {

#  package { "npm":
#    ensure => installed
#  }

#  package { 'forever':
#    ensure   => installed,
#    provider => 'npm',
#  }

  package { "nodejs":
    ensure => installed
  }
}

class revsw-stats-api::required_packages {

  package { "redis-server":
    ensure => installed
  }

  package { 'redis-tools':
    ensure   => installed
  }
}



class revsw-stats-api::test_revsw-stats-api {

  $config_dir = "test_1.0.0"

  package { "revsw-stats-api":
    ensure => installed,
    require => Package["nodejs"]
  }

    service { "revsw-stats-api":
        require    => Package['revsw-stats-api'],
#        ensure     => running,
        enable     => true,
        hasstatus => true,
    }


  file { "/opt/revsw-stats-api/config/ssl_certs" :
    ensure  => directory,
    source  =>      "puppet:///modules/revsw-stats-api/$config_dir/ssl_certs",
    recurse =>      true,
    purge   =>      true,
    require    => Package['revsw-stats-api'],
#    notify => Service['revsw-stats-api'],
    owner  => root,
    group  => root,
    mode   => 600,
  }

  file { "/etc/default/revsw-stats-api":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/revsw-stats-api/$config_dir/revsw-stats-api.default",
#    notify => Service['revsw-stats-api'],
    require => [Package['revsw-stats-api']],
  }
}



class revsw-stats-api::revsw-stats-api {

  $config_dir = "1.0.0"

  package { "revsw-stats-api":
    ensure => installed,
    require => Package["nodejs"]
  }

    service { "revsw-stats-api":
        require    => Package['revsw-stats-api'],
#        ensure     => running,
        enable     => true,
        hasstatus => true,
    }


  file { "/opt/revsw-stats-api/config/ssl_certs" :
    ensure  => directory,
    source  =>      "puppet:///modules/revsw-stats-api/$config_dir/ssl_certs",
    recurse =>      true,
    purge   =>      true,
    require    => Package['revsw-stats-api'],
#    notify => Service['revsw-stats-api'],
    owner  => root,
    group  => root,
    mode   => 600,
  }

  file { "/etc/default/revsw-stats-api":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/revsw-stats-api/$config_dir/revsw-stats-api.default",
#    notify => Service['revsw-stats-api'],
    require => [Package['revsw-stats-api']],
  }
}

