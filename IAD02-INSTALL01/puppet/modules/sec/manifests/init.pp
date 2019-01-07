class sec::sec_app {

  package { "sec":
    ensure => present
  }

  file { "/etc/default/sec":
    owner  => root,
    group  => root,
    mode   => 644,
    require    => Package['sec'],
    notify => Service['sec'],
    source => "puppet:///modules/sec/sec.default",
  }

  file { "/etc/sec.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    require    => Package['sec'],
    notify => Service['sec'],
    source => "puppet:///modules/sec/sec.conf",
  }

  service { sec:
    enable     => true,
    ensure     => running,
    hasrestart => true,
    hasstatus  => false,
    require    => Package['sec']
  }
}
