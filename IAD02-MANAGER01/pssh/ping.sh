#!/bin/bash

GW=`ip ro ls|grep default|awk '{print $3}'`

ping -n -c 10 $GW
