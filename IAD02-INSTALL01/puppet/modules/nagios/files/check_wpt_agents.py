#!/usr/bin/env python
#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
#

import argparse
import os
import sys

from pygtail import Pygtail


def make_ips_dict(agents):
    return dict((ip, 0) for name, ip in agents.iteritems())


def exchange_key_values(agents):
    return dict((ip, name) for name, ip in agents.iteritems())


def parse_agents_to_monitor(agents):
    return dict(agent.split(':') for agent in agents.split(','))


def main():
    parser = argparse.ArgumentParser(description="Check WPT Agents")
    parser.add_argument(
        "-l", "--log",
        help="Path to log file", metavar="",
        default="/var/log/nginx/access.log")
    parser.add_argument(
        "-e", "--entries_to_expect", metavar="",
        help="Number of log entries to expect",
        default="2")
    parser.add_argument(
        "-a", "--agents_to_monitor", metavar="",
        help="WPT agent name and IP address to monitor")
    args = vars(parser.parse_args())

    if not args["agents_to_monitor"]:
        sys.exit("Agents to monitor parameter should be specified.")

    if not os.path.exists(args["log"]):
        sys.exit("Log file doesn't exist.")

    agents = parse_agents_to_monitor(args["agents_to_monitor"])
    agents_mirror = exchange_key_values(agents)
    found_ips = make_ips_dict(agents)

    for line in Pygtail(args["log"]):
        for name, ip in agents.iteritems():
            if ip in line:
                found_ips[ip] += 1

    status = 0
    for ip, quantity in found_ips.iteritems():
        if quantity == 0:
            sys.stdout.write(
                "CRITICAL: Records for %s with IP %s not found\n"
                % (agents_mirror[ip], ip))
            status = 2
        elif quantity < int(args["entries_to_expect"]):
            sys.stdout.write(
                "WARNING: Quantity of records for %s with IP %s are less than %s\n"
                % (agents_mirror[ip], ip, args["entries_to_expect"]))
            if status < 2:
                status = 1
    if status == 0:
        sys.stdout.write("OK\n")
    sys.exit(status)


if __name__ == '__main__':
    main()
