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
                //domain: "192.168.0.151",
                domain:"portal.revsw.net",
                port: 3000,
                post: "POST",
                get: "GET",
                paths:{
            create_company: "/company/new",
                        update_company: "/company/update",
                        delete_company: "/company/delete",
                        company_list: "/company/list",
            company_name: "/company/getCompanyName",
                        create_user: "/user/new",
                        update_user: "/user/update",
                        user_list: "/user/list",
                        create_domain: "/domain/new",
                        update_domain: "/domain/update",
                        delete_domain: "/domain/delete",
                        domain_list: "/domain/list",
                        s_group_list:"/servergroup/list",
                        update_config:"/domain/updateConfigure",
                        get_domain_names: "/domain/names",
                        login: "/user/login",
                        filter: "/user/filter",
                        set_domain_settings: "/domain/settings",
                        get_domain_settings: "/domain/getSettings",
                        delete_user: "/user/delete",
                        user_logout: "/user/logout",
                        forgot_password: "/user/forgot_password",
                        get_domain_bp_list:"/domain/purgeDomains",
                        purge:"/domain/purge",
                        get_masterConfig_domain:"/domain/getMasterConfigDomain",
                        getUserDomains: "/user/getUserDomains"
                },
                url: function(path){
                        if(settings.paths.hasOwnProperty(path)){
                                return "https://"+settings.domain+":"+settings.port+settings.paths[path];
                        }
                },
                default_to_render: "#users",
                pages:{
            companies:"pages/companies.html",
                        accounts: "pages/accounts.html",
                        domains: "pages/domains.html",
                        menus: "pages/menus.html",
                        main: "pages/main.html",
                        login: "pages/login.html",
                        settings: "pages/user_settings.html",
                        edit_domain: "pages/dialog/edit_domain.html",
                        edit_user: "pages/dialog/edit_user.html",
            edit_company: "pages/dialog/edit_company.html",
                        forgot_password: "pages/forgot_password.html",
                        purge:"pages/purge.html",
                        domainEditor:"pages/domainEditor.html",
			contact_support:"../contact_support.html",
			about:"../about.html"
                }
};
