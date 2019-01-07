#!/usr/bin/python
import json
import requests
from pprint import pprint, pformat
import logging
import time
import sys
import traceback
import math

# settigns
organization = "revsw"
user = "victor"
password = "Bv4CCxeT84"
logging_level = logging.DEBUG
failure_sleep_seconds = 3
max_retries = 50

# setup logger
logging.basicConfig(format='%(asctime)-15s %(message)s')
logger = logging.getLogger('dyn_usage_monitoring')
logger.setLevel(logging_level)

class Dyn(object):
    _base_url = "https://api.dynect.net"
    
    def __init__(self):
        self.token = None
        self.api_version = None
        
    def headers(self):
        headers = {
            'Content-Type': 'application/json',
        }
        
        if self.token is not None:
            headers['Auth-Token'] = self.token
        
        return headers
    
    def _cmd(self, method, command, data=None):
        headers = self.headers()
        url = self._base_url + command
        logger.debug("post %s" % url)
        
        if method == "delete":
            method_function = requests.delete
        elif method == "post":
            method_function = requests.post
        else:
            raise Exception("Unknown request method %s" % method)
        
        if data is not None:
            request_data = json.dumps(data)
            response = method_function(url, data=request_data, headers=headers)
        else:
            response = method_function(url, headers=headers)
        return json.loads(response.content)
    
    def post(self,*args,**kwrgs):
        return self._cmd('post',*args,**kwrgs)
        
    def delete(self,*args,**kwrgs):
        return self._cmd('delete',*args,**kwrgs)
            
    def login(self):
        data = {
            "customer_name": organization,
            "user_name": user,
            "password": password,            
        }
        
        res = self.post('/REST/Session',data)
        
        if res['status'] != 'success':
            logger.error("Login to Dyn API failed.")
        else:
            logger.info("Login to Dyn is success. Storing token and api version.")
            self.token = res['data']['token']
            self.api_version = res['data']['version']

    def logout(self):
        res = self.delete('/REST/Session')
        
        if res['status'] != 'success':
            logger.error("Logout from Dyn API failed.")
        else:
            logger.info("Logout from Dyn is success.")
            self.token = None
            self.api_version = None
        
    def qps_report(self, start_ts, end_ts):
        request = {
            'start_ts': start_ts,
            'end_ts': end_ts,
        }
        res = self.post('/REST/QPSReport/',request)
        if res['status'] != 'success':
            raise Exception("qps_report failed. Reason: %s" % pformat(res))
        csv_data = res['data']['csv'].split("\n")
        timeline = list()
        first_line = True
        for line in csv_data:
            if first_line:
                first_line = False
                continue
            if line == "":
                continue
            (ts_str, val_str) = line.split(',')
            timeline.append((int(ts_str),int(val_str)))
        return timeline        

def get_95_for_last_days(days):
    
    timeline = None
    pretty_time_format = "%d/%m/%Y %H:%M:%S"
    end_ts = int(time.time())
    pretty_end = time.strftime(pretty_time_format, time.gmtime(end_ts))
    start_ts = end_ts - days * 24 * 60 * 60
    pretty_start = time.strftime(pretty_time_format, time.gmtime(start_ts))
    logger.debug("Checking period %s until %s" % (pretty_start, pretty_end))
    
    # Try up to max_retries times here
    attempts = max_retries
    while True:
        try:
            dyn = Dyn()
            dyn.login()
            timeline = dyn.qps_report(start_ts,end_ts)
            dyn.logout()
            break
        except:
            if not attempts:
                logger.error("get_95_for_last_days failed too many times, aborting.")
                raise Exception("get_95_for_last_days failed too many times, aborting.")
            attempts -= 1
            logger.warning("get_95_for_last_days failed, retrying int a bit. Exception was: %s" % traceback.format_exc())
            logger.warning("I'll sleep for %d seconds and try again." % failure_sleep_seconds)
            time.sleep(failure_sleep_seconds)
    if timeline is None:
        raise Exception("No timeline data found, aborting exection.")
        
    samples = list()
    for (ts, qps) in timeline:
        samples.append(qps)
    
#     logger.debug("Counting 95%")
    percential = sorted(samples)[ int(math.ceil ( len(samples) / 100.0 * 95)) ]
    percential_in_qps = percential / 300.0
    return percential_in_qps
                
if __name__ == "__main__":
    try:
        last_30 = get_95_for_last_days(30)
        last_7 = get_95_for_last_days(7)
        last_1 = get_95_for_last_days(1)
        print "95 percentile report"
        print "Last 30 days %.2f" % last_30
        print "Last 7 days %.2f" % last_7
        print "Last 1 days %.2f" % last_1
        
    except:
        print("Execution failed with exception: %s" % sys.exc_info()[0])
        print(traceback.format_exc())
        exit(1)       
        
