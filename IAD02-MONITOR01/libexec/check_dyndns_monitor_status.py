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
password = "WE6mR1LYLVZ4C369erLY"
logging_level = logging.DEBUG
failure_sleep_seconds = 3
max_retries = 50

# setup logger
logging.basicConfig(format='%(asctime)-15s %(message)s')
logger = logging.getLogger('dyn_monitoring_status')
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
        elif method == "get":
            method_function = requests.get
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

    def get(self,*args,**kwrgs):
        return self._cmd('get',*args,**kwrgs)
        
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
        
    def list_dsf(self):
        res = self.get('/REST/DSF')
        if res['status'] != 'success':
            raise Exception("Failed to get a list of DSF records. Reason: %s" % pformat(res))
        print res['data']
        return res['data']

    def list_response_pool(dsf):
        res = self.get(dsf)
        if res['status'] != 'success':
            raise Exception("Failed to get a list of DSF records. Reason: %s" % pformat(res))
        print res['data']
        return res['data']

if __name__ == "__main__":
    try:
       dyn = Dyn()
       dyn.login()
       ee=dyn.list_dsf()
       print ee
       dyn.list_response_pool(ee)
       dyn.logout()
 
    except:
        print("Execution failed with exception: %s" % sys.exc_info()[0])
        print(traceback.format_exc())
        exit(1)       
        
