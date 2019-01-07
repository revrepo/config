#!/bin/bash

TIME=`date +%Y%m%d-%H%M%S`

/usr/local/nagios/libexec/check_http -S -I rum01.revdn.net -H "rum01.revsw.net" -u "/service?request=nw_info&user_ip=50.240.197.150&rt.start=navigation&rt.tstart=1414530967512&rt.bstart=1414530968262&rt.end=1414530974632&t_resp=962&t_page=6158&t_done=7120&r=&t_other=boomerang%7C2%2Cboomr_fb%7C750%2Ct_domloaded%7C1157&nt=1&nt_red_cnt=0&nt_nav_type=0&nt_nav_st=1414530967512&nt_red_st=0&nt_red_end=0&nt_fet_st=1414530968129&nt_dns_st=1414530968129&nt_dns_end=1414530968129&nt_con_st=1414530968129&nt_con_end=1414530968129&nt_req_st=1414530968141&nt_res_st=1414530968474&nt_res_end=1414530968490&nt_domloading=1414530968476&nt_domint=1414530969058&nt_domcontloaded_st=1414530969058&nt_domcontloaded_end=1414530969065&nt_domcomp=1414530975018&nt_load_st=1414530975018&nt_load_end=1414530975020&nt_unload_st=0&nt_unload_end=0&nt_spdy=0&nt_first_paint=0&v=0.9.1396020860&u=http%3A%2F%2Frum-test.com%2F$TIME" -t 10 -w 1 -c 5 > /dev/null 2>&1

SLEEP=3
sleep $SLEEP

RESULT=`curl -s -d "{\"domain\":\"rum-test.com\",\"u\":\"http://rum-test.com/$TIME\"}" -H "Content-Type: application/json" http://localhost:8090/checkRumStatus`

if [ -z "`echo $RESULT | grep \"Event Data Exists\"`" ]; then
	echo "CRITICAL: Failed to find the RMDB a RUM request for timestamp $TIME (waited for $SLEEP seconds)"
	exit 2
fi

echo "OK: Found in RMDB a RUM record fo timestamp $TIME (waited for $SLEEP seconds)"
exit 0


