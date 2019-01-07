
class revsw-cds::nodejs_app {

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


class revsw-cds::revsw-cds {

  file { "/etc/default/revsw-cds":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/revsw-cds/revsw-cds.default"
  }

  file { "/opt/revsw-cds/config/ssl_certs" :
    ensure  => directory,
    source  =>      "puppet:///modules/revsw-cds/ssl_certs",
    recurse =>      true,
    purge   =>      true,
#    require    => Package['revsw-api'],
#    notify => Service['revsw-api'],
    owner  => root,
    group  => root,
    mode   => 600,
  }
}


class revsw-cds::test_revsw-cds {

  file { "/etc/default/revsw-cds":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/revsw-cds/test/revsw-cds.default"
  }

  file { "/opt/revsw-cds/config/ssl_certs" :
    ensure  => directory,
    source  =>      "puppet:///modules/revsw-cds/test/ssl_certs",
    recurse =>      true,
    purge   =>      true,
#    require    => Package['revsw-api'],
#    notify => Service['revsw-api'],
    owner  => root,
    group  => root,
    mode   => 600,
  }
}

