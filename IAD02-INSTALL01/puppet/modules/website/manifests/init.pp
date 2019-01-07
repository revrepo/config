
class website::website {

  package { "apache2":
    ensure => installed
  }

   exec { "a2enmod rewrite":
      alias => "a2enmod_rewrite",
      refreshonly => true,
      path        => ["/usr/bin", "/usr/sbin"],
      require => Package["apache2"],
   }

   exec { "a2enmod ssl":
      alias => "a2enmod_ssl",
      refreshonly => true,
      path        => ["/usr/bin", "/usr/sbin"],
      require => Package["apache2"],
   }

    service { "apache2":
        require    => Package['apache2'],
        ensure     => running,
	enable     => true,
    }

  file { "/etc/apache2/sites-enabled/000-default.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/website/000-default.conf",
    notify => Service['apache2'],
    require => Package['apache2'],
  }

  file { "/var/www/html/test-cache.js":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/website/www-html-default/test-cache.js",
    require => Package['apache2'],
  }

  file { "/etc/apache2/mods-enabled/mpm_event.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/website/mpm_event.conf",
    notify => Service['apache2'],
    require => Package['apache2'],
  }

  file { "/etc/logrotate.d/apache2":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/website/apache2.logrotate",
    require => Package['apache2']
  }

}

class website::boomerang-js {

  file { "/var/www/boomerang-js" :
    ensure  => directory,
    source  =>      "puppet:///modules/website/boomerang-js",
    recurse =>      true,
    purge   =>      true,
    require    => Package['apache2'],
    owner  => root,
    group  => root,
    mode   => 644,
  }

  file { "/etc/apache2/ssl_certs" :
    ensure  => directory,
    source  =>      "puppet:///modules/website/ssl_certs",
    recurse =>      true,
    purge   =>      true,
    require    => Package['apache2'],
    notify => Service['apache2'],
    owner  => root,
    group  => root,
    mode   => 600,
  }

  file { "/etc/apache2/sites-enabled/boomerang-js.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/website/boomerang-js.conf",
    notify => Service['apache2'],
    require => [Package['apache2'],File["/etc/apache2/ssl_certs"]],
  }
}

class website::test_boomerang-js {

  file { "/var/www/boomerang-js" :
    ensure  => directory,
    source  =>      "puppet:///modules/website/test_website/boomerang-js",
    recurse =>      true,
    purge   =>      true,
    require    => Package['apache2'],
    owner  => root,
    group  => root,
    mode   => 644,
  }

  file { "/etc/apache2/ssl_certs" :
    ensure  => directory,
    source  =>      "puppet:///modules/website/test_website/ssl_certs",
    recurse =>      true,
    purge   =>      true,
    require    => Package['apache2'],
    notify => Service['apache2'],
    owner  => root,
    group  => root,
    mode   => 600,
  }

  file { "/etc/apache2/sites-enabled/boomerang-js.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/website/test_website/boomerang-js.conf",
    notify => Service['apache2'],
    require => [Package['apache2'],File["/etc/apache2/ssl_certs"]],
  }
}



class website::monitor-origin {

  file { "/var/www/monitor-origin" :
    ensure  => directory,
    source  =>      "puppet:///modules/website/monitor-origin",
    recurse =>      true,
    purge   =>      true,
    require    => Package['apache2'],
    owner  => root,
    group  => root,
    mode   => 644,
  }

  file { "/etc/apache2/sites-enabled/monitor-origin.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/website/monitor-origin.conf",
    notify => Service['apache2'],
    require => Package['apache2'],
  }
}

class website::test_monitor-origin {

  file { "/var/www/monitor-origin" :
    ensure  => directory,
    source  =>      "puppet:///modules/website/test_website/monitor-origin",
    recurse =>      true,
    purge   =>      true,
    require    => Package['apache2'],
    owner  => root,
    group  => root,
    mode   => 644,
  }

  file { "/etc/apache2/sites-enabled/monitor-origin.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/website/test_website/monitor-origin.conf",
    notify => Service['apache2'],
    require => Package['apache2'],
  }
}


class website::portal-maintenance-page {

  file { "/var/www/portal-maintenance-page" :
    ensure  => directory,
    source  =>      "puppet:///modules/website/portal-maintenance-page",
    recurse =>      true,
    purge   =>      true,
    require    => Package['apache2'],
    owner  => root,
    group  => root,
    mode   => 644,
  }

  file { "/etc/apache2/sites-enabled/portal-maintenance-page.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/website/portal-maintenance-page.conf",
    notify => Service['apache2'],
    require => Package['apache2'],
  }
}


class website::test_portal-maintenance-page {

  file { "/var/www/portal-maintenance-page" :
    ensure  => directory,
    source  =>      "puppet:///modules/website/test_website/portal-maintenance-page",
    recurse =>      true,
    purge   =>      true,
    require    => Package['apache2'],
    owner  => root,
    group  => root,
    mode   => 644,
  }

  file { "/etc/apache2/sites-enabled/portal-maintenance-page.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/website/test_website/portal-maintenance-page.conf",
    notify => Service['apache2'],
    require => Package['apache2'],
  }
}

class website::swagger-ui {

  file { "/var/www/swagger-ui-origin" :
    ensure  => directory,
    source  =>      "puppet:///modules/website/swagger-ui-origin",
    recurse =>      true,
    purge   =>      true,
    require    => Package['apache2'],
    owner  => root,
    group  => root,
    mode   => 644,
  }

  file { "/etc/apache2/sites-enabled/swagger-ui-origin.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/website/swagger-ui-origin.conf",
    notify => Service['apache2'],
    require => Package['apache2'],
  }
}
