/*
#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
# 
*/

/*!
 * RevPortal v1.0.0
 * Copyright 2013-2014 RevSofware, Inc.
 */

/**
 * This is the Settings file to store the properties
 */
var settings = {    //config values
                domain: "portal.revsw.net",
                //domain:"192.168.0.199",
        wptUrl:"https://wpt-prod-east-secure.revsw.net/",
                port: 3000,
                post: "POST",
                get: "GET",
                paths:{
                        area_graph: "/portal/area_graph",
                        distribution_graph: "/portal/distribution_graph",
                        bandwidth_graph: "/elasticsearch/bandwidth_reports",
                        counts_graph: "/elasticsearch/traffic_count",
                bytes_graph: "/elasticsearch/bandwidth_graph",
                compare_graph: "/portal/compare_graph",
                cmp_timeRange_graph:"/portal/cmp_timeRange_graph",
                 login: "/user/login",
                        filter: "/user/filter",
                        cmp_filter:"/user/compare_filters",
                        settings: "/user/settings",
                        change_password: "/user/change_password",
                        user_logout: "/user/logout",
                        change_theme: "/user/theme",
                        config_settings: "/domain/configure",
                        update_config: "/domain/updateConfigure",
                        quick_stats: "/dashboard/elastic_search_stats",
                        heat_map:"/dashboard/heatMap",
                        browser_stats:"/dashboard/deviceBrowser",
                        last_updated:"/user/updateDomainTimeStamp",
                        cards_order:"/user/updateUserMenuOrder",
                        saveTestResults: "/wpt/wpt_history",
                        getTestHistory:"/wpt/get_wpt_history",
                        fg_pwd_act:"/user/reset_fpwd",
                        forgot_password: "/user/forgot_pwd",
                        is_valid_activation_code:"/user/is_valid_activation_code",
                        agg_ohr_hm: "/dashboard/agregate_ohr_heatmap",
                        agg_ohr_db: "/dashboard/agregate_ohr_dev_browser",
                        con_lock_check:"/user/checkAcl",
                                                getUserDomains: "/user/getUserDomains",
                                                 PageLoad_dashboard:"/portal/pgt_analytics"
                },
                url: function(path){
                        if(settings.paths.hasOwnProperty(path)){
                                return "https://"+settings.domain+":"+settings.port+settings.paths[path];
                        }
                },
                graphFilters: {
                        time_range: {
                                /*'title': 'Time Range',*/
                                '6hours': 'LAST 6 HOURS',
                                '12hours': 'LAST 12 HOURS',
                                '24hours': 'LAST 24 HOURS',
                                '15days': 'LAST 15 DAYS',
                                '30days': 'LAST 30 DAYS'
                        },
                        geography: {
                                'title': 'All Countries'
                        },
                        /*network: {
                                'title': 'Network'
                        },*/
                        device: {
                                'title': 'All Devices & Browsers'
                        }
                },
                traffic_filters:{
                        '24hours': 'LAST 24 HOURS',
                        '7days': 'LAST 7 DAYS',
                        '30days': 'LAST 30 DAYS'
                },
                traffic_devices:{
                    'title': 'All Devices & Browsers',
                    'Mobile':'Mobile Browsers',
                    'Non-Mobile':'Non Mobile Browsers'
                },
                pages:{
                        menus: "./pages/menus.html",
                        main: "./pages/main.html",
                        login: "./pages/login.html",
                        area_graph: "./pages/area_graph.html",
                        distribution_graph: "./pages/distribution_graph.html",
                        bandwidth_graph:"./pages/traffic_bw_graph.html",
                        hits_graph:"./pages/hits_graph.html",
                        bytes_graph:"./pages/bytes_bars.html",
                        settings: "./pages/user_settings.html",
                        forgot_password: "./pages/forgot_password.html",
                        reports:"./pages/reports.html",
                        configure: "./pages/configure.html",
                        compare: "./pages/compare.html",
                        dashBoard:"./pages/dashboard.html",
                        webpaget:"./pages/wptest.html",
                        cmp_dist_graph:"./pages/cmp_dist_graph.html",
                        cmp_area_graph:"./pages/cmp_area_graph.html"
                },
                wbrowsers:{
                        "IE 11": "images/ie9.png",
                        "Chrome": "images/chrome.png",
                        "Firefox": "images/firefox.png",
                        "Safari": "images/sfari.png",
                        "IE 9": "images/ie8.png",
                        "Nexus7 - Chrome":"images/mobile_chrome.png"
                },
                default_caching : {
                    "version": 1,
                    "url": {
                        "is_wildcard": true,
                        "value": "**"
                    },
                    "edge_caching": {
                        "override_origin": false,
                        "new_ttl": 0,
                        "override_no_cc": false
                    },
                    "browser_caching": {
                        "override_edge": false,
                        "new_ttl": 0,
                        "force_revalidate": false
                    },
                    "cookies": {
                        "override": false,
                        "ignore_all": false,
                        "list_is_keep": false,
                        "keep_or_ignore_list": [],
                        "remove_ignored_from_request": false,
                        "remove_ignored_from_response": false
                    }
                }
};
