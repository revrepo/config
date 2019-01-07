class elasticsearch::elasticsearch_app {

    package { "openjdk-7-jre-headless": 
        ensure => installed 
    }

  file { "/root/elasticsearch-1.5.2.deb":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/elasticsearch/elasticsearch-1.5.2.deb",
    notify => Exec['install_es']
  }

   exec { "dpkg -i /root/elasticsearch-1.5.2.deb":
      alias => "install_es",
      refreshonly => true,
      path        => ["/usr/bin", "/usr/sbin", "/usr/local/sbin", "/bin", "/sbin"],
      subscribe => File["/root/elasticsearch-1.5.2.deb"],
      require => File["/root/elasticsearch-1.5.2.deb"],
      before => Package["elasticsearch"]
   }

  package { "elasticsearch":
    provider => dpkg,
    ensure => installed,
    source => "/root/elasticsearch-1.5.2.deb",
    require => Package["openjdk-7-jre-headless"]
  }

    service { "elasticsearch":
        require    => Package['elasticsearch'],
#        ensure     => running,
        enable     => true,
        hasstatus => true,
    }

  file { "/etc/elasticsearch/elasticsearch.yml":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/elasticsearch/elasticsearch.yml",
    require => Package["elasticsearch"],
#    notify => Service["elasticsearch"],
  }


  file { "/etc/elasticsearch/logging.yml":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/elasticsearch/logging.yml",
    require => Package["elasticsearch"],
    notify => Service["elasticsearch"],
  }

  file { "/etc/default/elasticsearch":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/elasticsearch/elasticsearch.default",
    require => Package["elasticsearch"],
#    notify => Service["elasticsearch"],
  }
}

class elasticsearch::test_elasticsearch_app {

    package { "openjdk-7-jre-headless":
        ensure => installed
    }

  package { "elasticsearch":
    ensure => installed,
    require => Package["openjdk-7-jre-headless"]
  }

    service { "elasticsearch":
        require    => Package['elasticsearch'],
        ensure     => running,
        enable     => true,
        hasstatus => true,
    }

  file { "/etc/elasticsearch/logging.yml":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/elasticsearch/logging.yml",
    require => Package["elasticsearch"],
    notify => Service["elasticsearch"],
  }
}

class elasticsearch::pin_elasticsearch_verson_1_5_2 {
  file { "/etc/apt/preferences.d/pin-elasticsearch-version-1_5_2":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/elasticsearch/pin-elasticsearch-version-1_5_2",
    require => Package["elasticsearch"]
  }
}

class elasticsearch::pin_elasticsearch_verson_1_7_3 {
  file { "/etc/apt/preferences.d/pin-elasticsearch-version-1_7_3":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/elasticsearch/pin-elasticsearch-version-1_7_3",
#    require => Package["elasticsearch"]
  }
}

class elasticsearch::esurl_remove_old_indexes {

     file { "/opt/scripts/esurl_remove_old_ES_indices.sh":
            owner  => root,
            group  => root,
            mode   => 755,
            source => "puppet:///modules/elasticsearch/esurl_remove_old_ES_indices.sh",
     }

     file { "/etc/cron.d/esurl_remove_old_ES_indices.crontab":
            owner  => root,
            group  => root,
            mode   => 644,
            source => "puppet:///modules/elasticsearch/esurl_remove_old_ES_indices.crontab",
            require => File["/opt/scripts/esurl_remove_old_ES_indices.sh"]
     }
}

class elasticsearch::crontab_remove_old_es_logs {

     file { "/etc/cron.d/elasticsearch_delete_old_logs":
            owner  => root,
            group  => root,
            mode   => 644,
            source => "puppet:///modules/elasticsearch/elasticsearch_delete_old_logs.crontab"
     }
}
