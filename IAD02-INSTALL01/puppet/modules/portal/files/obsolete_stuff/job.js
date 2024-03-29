
/*
#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
# 
*/


module.exports = function(compound) {
        compound.cron.daemonize_route('stats_cron', {
                route : 'dashboard#stats_cron',
                cronTime : '*/15 * * * *',
                start : false
        });
        compound.cron.daemonize_route('eval_stats_cron', {
                route : 'dashboard#eval_stats_cron',
                cronTime : '0 */1 * * *',
                start : false
        });
        compound.cron.daemonize_route('eval_dev_browser_cron', {
                route : 'dashboard#eval_dev_browser_cron',
                cronTime : '*/30 * * * *',
                start : false 
        });

        compound.cron.daemonize_route('eval_heatmap_cron', {
                route : 'dashboard#eval_heatmap_cron',
                cronTime : '0 */2 * * *',
                start : false 
        });

        compound.cron.daemonize_route('eval_graphs_cron', {
                route : 'portal#eval_graphs_cron',
                cronTime : '0 */3 * * *',
                start : false 
        });


        compound.cron.daemonize_route('sync_failed_cron', {
                route : 'domain#sync_failed_cron',
                cronTime : '*/17 * * * *',
                start : false
        });

        compound.cron.daemonize_route('heatmap_cache_cron', {
                route : 'dashboard#heatmap_cache_cron',
                cronTime : '0 9 * * *',
                start : false
        });
        compound.cron.daemonize_route('dev_browser_cache_cron', {
                route : 'dashboard#dev_browser_cache_cron',
                cronTime : '0 7 * * *',
                start : false
        });

        compound.cron.daemonize_route('heatmap_cache_cron_24hrs', {
                route : 'dashboard#heatmap_cache_cron_24hrs',
                cronTime : '0 */1 * * *',
                start : false
        });

        compound.cron.daemonize_route('dev_browser_cache_cron_24hrs', {
                route : 'dashboard#dev_browser_cache_cron_24hrs',
                cronTime : '0 */1 * * *',
                start : false
        });
}

