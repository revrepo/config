
class amanda::server_configuration {
    package { "amanda-server": 
        ensure => installed 
    }

    file { "/etc/amanda/DailySet1/amanda.conf":
       owner  => backup,
       group  => backup,
       mode    => 644,
       source => "puppet:///modules/amanda/amanda.conf"
    }

    file { "/etc/amanda/DailySet1/disklist":
       owner  => backup,
       group  => backup,
       mode    => 644,
       source => "puppet:///modules/amanda/disklist"
    }

    file { "/var/backups/.ssh/authorized_keys2":
        mode   => 400,
        owner  => backup,
        group  => backup,
        source => "puppet:///modules/amanda/id_rsa_amrecover.pub"
    }

}


class amanda::client_configuration {

    user { "backup":
       ensure => present,
       shell  => "/bin/bash",
    }

    package { "gnuplot": 
        ensure => installed 
    }

    package { "amanda-client": 
        ensure => installed 
    }

    package { "dump": 
        ensure => installed 
    }

    file { "/var/backups/.ssh":
	ensure => directory,
        mode   => 400,
        owner  => backup,
        group  => backup,
    }

    file { "/var/backups/.ssh/authorized_keys":
        mode   => 400,
        owner  => backup,
        group  => backup,
        source => "puppet:///modules/amanda/id_rsa_backup.pub"
    }

    file { "/root/.ssh/id_rsa_amrecover":
        mode   => 400,
        owner  => root,
        group  => root,
        source => "puppet:///modules/amanda/id_rsa_amrecover"
    }


    file { "/etc/amanda":
	ensure => directory,
        mode   => 644,
        owner  => backup,
        group  => backup,
    }

    file { "/etc/amanda/amanda-client.conf":
       owner  => backup,
       group  => backup,
       mode    => 644,
       source => "puppet:///modules/amanda/amanda-client.conf"
    }

    file { "/etc/amanda/exclude-list":
       owner  => backup,
       group  => backup,
       mode    => 644,
       source => "puppet:///modules/amanda/exclude-list"
    }
}
