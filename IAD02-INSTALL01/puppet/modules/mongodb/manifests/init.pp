
class mongodb::report_mongodb_stats_to_graphite {

  file { "/etc/cron.d/mongodb_graphite_stats":
    owner  => root,
    group  => root,
    mode   => 644,
    source => "puppet:///modules/mongodb/mongodb_graphite_stats.crontab",
  }
}

