
class revsw-webtest::nodejs_app {

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


class revsw-webtest::revsw-webtest {

  package { "mongodb-server":
    ensure => installed
  }

  package { "ffmpeg":
    ensure => installed
  }

  package { "nginx":
    ensure => installed
  }

  package { "redis-server":
    ensure => installed
  }

  service { "redis-server":
    require    => Package['redis-server'],
    ensure     => running,
  }

  file { "/etc/default/revsw-webtest":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/revsw-webtest/revsw-webtest.default"
  }

#  file { "/opt/revsw-cds/config/ssl_certs" :
#    ensure  => directory,
#    source  =>      "puppet:///modules/revsw-cds/ssl_certs",
#    recurse =>      true,
#    purge   =>      true,
##    require    => Package['revsw-api'],
#    owner  => root,
#    group  => root,
#    mode   => 600,
#  }

  service { nginx:
    ensure     => running,
    hasrestart => true,
    require => Package['nginx'],
  }

  file { "/etc/nginx/sites-enabled/default":
    ensure  => absent,
    require => Package['nginx'],
    notify => Service['nginx']
  }

  file { "/etc/nginx/sites-enabled/webtest_site.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/revsw-webtest/webtest_site.conf",
    require    => Package['nginx'],
    notify => Service['nginx']
  }
}
