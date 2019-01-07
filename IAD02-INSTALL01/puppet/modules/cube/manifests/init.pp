
class cube::nodejs_app {

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


class cube::cube_app {

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

  $revsw_cube_package_file = "revsw-cube_2.0.4.deb"

  file { "/root/$revsw_cube_package_file":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/cube/$revsw_cube_package_file",
    notify => Exec['install_cube']
  }

   exec { "dpkg -i /root/$revsw_cube_package_file":
      alias => "install_cube",
      refreshonly => true,
      path        => ["/usr/bin", "/usr/sbin", "/usr/local/sbin", "/bin", "/sbin"],
      subscribe => File["/root/$revsw_cube_package_file"],
      require => File["/root/$revsw_cube_package_file"],
      before => Package["revsw-cube", "nodejs", "nodejs-legacy"]
   }

  package { "revsw-cube":
    provider => dpkg,
    ensure => installed,
    source => "/root/$revsw_cube_package_file",
    require => Package["nodejs-legacy"]
  }

    service { "revsw-cube":
        require    => Package['revsw-cube'],
#        ensure     => running,
        enable     => true,
        hasstatus => true,
    }

  file { "/opt/revsw-cube/config/collector-config.js":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/cube/collector-config.js",
    notify => Service['revsw-cube'],
    require => Package['revsw-cube'],
  }

  file { "/opt/revsw-cube/config/evaluator-config.js":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/cube/evaluator-config.js",
    notify => Service['revsw-cube'],
    require => Package['revsw-cube'],
  }

  file { "/usr/lib/nagios/plugins/restart_cube_service.sh":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/cube/restart_cube_service.sh"
  }
}


class cube::test_cube_app_3_0_1 {

    $config_dir = "test_3.0.1"

#  $revsw_cube_package_file = "revsw-cube_2.0.4.deb"
#
#  file { "/root/$revsw_cube_package_file":
#    owner  => root,
#    group  => root,
#    mode   => 644,
#    source => "puppet:///modules/cube/$revsw_cube_package_file",
#    notify => Exec['install_cube']
#  }
#
#   exec { "dpkg -i /root/$revsw_cube_package_file":
#      alias => "install_cube",
#      refreshonly => true,
#      path        => ["/usr/bin", "/usr/sbin", "/usr/local/sbin", "/bin", "/sbin"],
#      subscribe => File["/root/$revsw_cube_package_file"],
#      require => File["/root/$revsw_cube_package_file"],
#      before => Package["revsw-cube", "nodejs", "nodejs-legacy"]
#   }

  package { "revsw-cube":
#    provider => dpkg,
    ensure => installed,
#    source => "/root/$revsw_cube_package_file",
    require => Package["nodejs-legacy"]
  }

    service { "revsw-cube":
        require    => Package['revsw-cube'],
#        ensure     => running,
        enable     => true,
        hasstatus => true,
    }

  file { "/opt/revsw-cube/config/collector-config.js":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/cube/$config_dir/collector-config.js",
    notify => Service['revsw-cube'],
    require => Package['revsw-cube'],
  }

  file { "/opt/revsw-cube/config/evaluator-config.js":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/cube/$config_dir/evaluator-config.js",
    notify => Service['revsw-cube'],
    require => Package['revsw-cube'],
  }

  file { "/opt/revsw-cube/config/config.js":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/cube/$config_dir/config.js",
    notify => Service['revsw-cube'],
    require => Package['revsw-cube'],
  }

  file { "/usr/lib/nagios/plugins/restart_cube_service.sh":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/cube/restart_cube_service.sh"
  }
}

