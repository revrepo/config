
class portal::portal_app_5_0_1 {

  package { "nginx":
    ensure => installed
  }

  package { "revsw-portal":
    ensure => installed,
  }

  service { "nginx":
      require    => Package['nginx'],
      ensure     => running,
	enable	   => true
  }

   file { "/etc/nginx/ssl":
       ensure => "directory",
       owner  => "root",
       group  => "root",
       mode   => 755,
       require => Package["nginx"]
   }

  file { "/etc/nginx/ssl/server-chained.crt":
    owner  => root,
    group  => root,
    mode   => 600,
    source => "puppet:///modules/portal/ssl_certs/server-chained.crt",
    notify => Service['nginx'],
    require => [ Package['nginx'], File["/etc/nginx/ssl"] ]
  }

  file { "/etc/nginx/ssl/server.key":
    owner  => root,
    group  => root,
    mode   => 600,
    source => "puppet:///modules/portal/ssl_certs/server.key",
    notify => Service['nginx'],
    require => [ Package['nginx'], File["/etc/nginx/ssl"] ]
  }

  file { "/etc/nginx/sites-enabled/default":
	ensure => absent
  }

  file { "/etc/nginx/sites-enabled/revsw-portal.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/portal/nginx_portal.conf",
    notify => Service['nginx'],
    require => [ Package['nginx'], File["/etc/nginx/ssl"] ]
  }

}


class portal::test_portal_app_5_0_1 {

  package { "nginx":
    ensure => installed
  }

  package { "revsw-portal":
    ensure => installed,
  }

  service { "nginx":
      require    => Package['nginx'],
      ensure     => running,
        enable     => true
  }

   file { "/etc/nginx/ssl":
       ensure => "directory",
       owner  => "root",
       group  => "root",
       mode   => 755,
       require => Package["nginx"]
   }

  file { "/etc/nginx/ssl/server-chained.crt":
    owner  => root,
    group  => root,
    mode   => 600,
    source => "puppet:///modules/portal/test/ssl_certs/server-chained.crt",
    notify => Service['nginx'],
    require => [ Package['nginx'], File["/etc/nginx/ssl"] ]
  }

  file { "/etc/nginx/ssl/server.key":
    owner  => root,
    group  => root,
    mode   => 600,
    source => "puppet:///modules/portal/test/ssl_certs/server.key",
    notify => Service['nginx'],
    require => [ Package['nginx'], File["/etc/nginx/ssl"] ]
  }

  file { "/etc/nginx/sites-enabled/default":
        ensure => absent
  }

  file { "/etc/nginx/sites-enabled/revsw-portal.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/portal/test/nginx_portal.conf",
    notify => Service['nginx'],
    require => [ Package['nginx'], File["/etc/nginx/ssl"] ]
  }

}

