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
                port: 3000,
                post: "POST",
                get: "GET",
                paths:{
                        area_graph: "/portal/area_graph",
                        distribution_graph: "/portal/distribution_graph",
                        bandwidth_graph: "/sumo/bandwidth_reports",
                        counts_graph: "/sumo/traffic_count",
                        login: "/user/login",
                        filter: "/user/filter",
                        settings: "/user/settings",
                        change_password: "/user/change_password",
                        user_logout: "/user/logout",
                        change_theme: "/user/theme",
                        config_settings: "/domain/configure",
                        update_config: "/domain/updateConfigure",
                        quick_stats: "/dashboard/stats",
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
                        con_lock_check:"/user/checkAcl"
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
                                '1hour': 'LAST 1 HOUR',
                                '3hours': 'LAST 3 HOURS',
                                '6hours': 'LAST 6 HOURS',
                                '12hours': 'LAST 12 HOURS',
                                '24hours': 'LAST 24 HOURS',
                                '7days': 'LAST 7 DAYS',
                                '15days': 'LAST 15 DAYS'
                },
                pages:{
                        menus: "./pages/menus.html",
                        main: "./pages/main.html",
                        login: "./pages/login.html",
                        area_graph: "./pages/area_graph.html",
                        distribution_graph: "./pages/distribution_graph.html",
                        bandwidth_graph:"./pages/traffic_bw_graph.html",
                        hits_graph:"./pages/hits_graph.html",
                        settings: "./pages/user_settings.html",
                        forgot_password: "./pages/forgot_password.html",
                        reports:"./pages/reports.html",
                        configure: "./pages/configure.html",
                        dashBoard:"./pages/dashboard.html",
                        webpaget:"./pages/wptest.html"
                },
                wbrowsers:{
                    "IE 11": "images/ie9.png",
                    "Chrome": "images/chrome.png",
                    "Firefox": "images/firefox.png",
                    "Safari": "images/sfari.png",
                    "IE 9": "images/ie8.png"
                }
};

