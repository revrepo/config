
class sumocollector::log-collector {

  file { "/root/sumocollector_19.91-2_amd64.deb":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/sumocollector/sumocollector_19.91-2_amd64.deb",
    notify => Exec['install_sumocollector']
  }

   exec { "dpkg -i /root/sumocollector_19.91-2_amd64.deb":
      alias => "install_sumocollector",
      refreshonly => true,
      path        => ["/bin", "/sbin", "/usr/bin", "/usr/sbin"],
      subscribe => File["/root/sumocollector_19.91-2_amd64.deb"],
      require => File["/root/sumocollector_19.91-2_amd64.deb"],
      before => Package["sumocollector"]
   }

  package { "sumocollector":
    provider => dpkg,
    ensure => installed,
    source => "/root/sumocollector_19.91-2_amd64.deb"
  }

  file { "/opt/SumoCollector/config/collector.json":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/sumocollector/collector.json",
    notify => Service['collector'],
    require => Package['sumocollector'],
  }

  file { "/etc/sumo.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/sumocollector/sumo.conf",
    notify => Service['collector'],
    require => Package['sumocollector'],
  }

  service { collector:
    ensure     => running,
    hasrestart => true,
    require => Package['sumocollector'],
  }
}
