

class rmdb::mongodb {
    package { "mongodb-server": 
        ensure => installed 
    }

    service { "mongodb":
        require    => Package['mongodb-server'],
        ensure     => running,
	enable     => true,
    }

    file { "/etc/mongodb.conf":
       mode   => 644,
       owner  => root,
       group  => root,
       source => "puppet:///modules/rmdb/mongodb.conf",
       notify => Service['mongodb']
    }
}
