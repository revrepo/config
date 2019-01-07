
class revsw-logshipper::nodejs_app {

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


class revsw-logshipper::revsw-logshipper {

  file { "/etc/default/revsw-logshipper":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/revsw-logshipper/revsw-logshipper.default"
  }

  file { "/opt/revsw-logshipper/config/ssl_certs" :
    ensure  => directory,
    source  =>      "puppet:///modules/revsw-logshipper/ssl_certs",
    recurse =>      true,
    purge   =>      true,
#    require    => Package['revsw-api'],
#    notify => Service['revsw-api'],
    owner  => root,
    group  => root,
    mode   => 600,
  }
}


class revsw-logshipper::test_revsw-logshipper {

  package { "revsw-logshipper":
#    provider => dpkg,
    ensure => installed,
#    source => "/root/$revsw_api_package_file",
    require => Package["nodejs-legacy"]
  }

    service { "revsw-logshipper":
        require    => Package['revsw-logshipper'],
#        ensure     => running,
        enable     => true,
        hasstatus => true,
    }


  file { "/etc/default/revsw-logshipper":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/revsw-logshipper/test/revsw-logshipper.default"
  }

  file { "/opt/revsw-logshipper/config/ssl_certs" :
    ensure  => directory,
    source  =>      "puppet:///modules/revsw-logshipper/ssl_certs",
    recurse =>      true,
    purge   =>      true,
#    require    => Package['revsw-api'],
#    notify => Service['revsw-api'],
    owner  => root,
    group  => root,
    mode   => 600,
  }
}

