

class logcheck {
  package { "logcheck":
    ensure => installed
  }

  file { "/etc/cron.d/logcheck":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/logcheck/logcheck.crontab",
    require    => Package['logcheck'],
  }

  file { "/etc/logcheck" :
    ensure  => directory,
    source  =>      "puppet:///modules/logcheck/logcheck",
    recurse =>      true,
    purge   =>      true,
    require    => Package['logcheck'],
    owner  => root,
    group  => root,
    mode   => 644,
  }

}

