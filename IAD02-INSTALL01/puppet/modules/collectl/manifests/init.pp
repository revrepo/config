

class collectl::collectl_4_2_0 {

  $version_dir = "collectl-4.2.0"

  # We will be directly copying collectl files so making sure that the Ubuntu
  # package is not installed
  package { "collectl":
    ensure => absent
  }

  file {'/usr/share/collectl':
    ensure  => directory,
    recurse => true,
    purge   => true,
    source => "puppet:///modules/collectl/$version_dir/share",
  }

  file { "/etc/collectl.conf":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/collectl/$version_dir/collectl.conf",
  }

  file { "/usr/bin/collectl":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/collectl/$version_dir/collectl",
  }

  file { "/etc/init.d/collectl":
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/collectl/$version_dir/initd/collectl-debian",
  }

  service { collectl:
    enable     => true,
    ensure     => running,
    hasrestart => true,
    hasstatus  => false,
    subscribe  => File["/etc/collectl.conf", "/etc/init.d/collectl", "/usr/share/collectl", "/usr/bin/collectl"]
  }
}
