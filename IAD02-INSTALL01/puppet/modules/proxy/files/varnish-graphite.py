#!/usr/bin/env python

#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
#

#
# Author: Scott Sanders <scott@jssjr.com>
#
# Collect statistics from Varnish, format them, and send them to Graphite.

import argparse
import json
import logging
import socket
from subprocess import check_output
from time import time, sleep


class GraphiteClient:

  def __init__(self, host='127.0.0.1', port=2003, prefix='varnish', buffer_size=1428, max_buffer_size=33554432):
    self.prefix = prefix
    self.host = host
    self.port = port
    self.sock = None

    self.sendbuf = ''
    self.buffer_size = buffer_size
    self.max_buffer_size = max_buffer_size

    self.connect()

  def connect(self):
    if self.sock == None:
      try:
        self.sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
      except socket.error:
        self.sock = None
        logging.warning("Connection failed. Re-trying on the next interval")
      try:
        self.sock.connect((self.host, int(self.port)))
      except socket.error:
        self.sock.close()
        self.sock = None
        logging.warning("Connection failed. Re-trying on the next interval")
    if self.sock != None:
      logging.info("Connected to {}:{}".format(self.host, self.port))

  def send_metrics(self, metrics):
    if self.sock == None:
      self.connect()
    for stat in metrics:
      if self.sock != None and len(self.sendbuf) + len("{}.{}".format(self.prefix, stat)) > self.buffer_size:
        logging.info("Sending {} bytes to {}".format(len(self.sendbuf), "{}:{}".format(self.host, self.port)))
        try:
          self.sock.send(self.sendbuf)
          self.sendbuf = ''
        except socket.error:
          logging.warning("Lost connection to {}:{}".format(self.host, self.port))
          self.reconnect()
      if len(self.sendbuf) + len("{}.{}".format(self.prefix, stat)) < int(self.max_buffer_size):
        self.sendbuf += "{}.{}\n".format(self.prefix, stat)

  def disconnect(self):
    if self.sock != None:
      self.sock.close()
    self.sock = None
    logging.warning("Disconnected from {}:{}".format(self.host, self.port))

  def reconnect(self):
    self.disconnect()
    self.connect()

def collect_metrics(name):
  varnish_stats = json.loads(check_output(['varnishstat', '-n', name, '-1', '-j']))
  timestamp = int(time())

  status = []
  fmt = lambda x, y: "{} {} {}".format(x, varnish_stats[y]['value'], timestamp)

  metrics = [('cache.hit', 'MAIN.cache_hit'),
             ('cache.hitpass', 'MAIN.cache_hitpass'),
             ('cache.miss', 'MAIN.cache_miss'),
             ('cache.nuked', 'MAIN.n_lru_nuked'),
             ('backend.conn', 'MAIN.backend_conn'),
             ('backend.unhealthy', 'MAIN.backend_unhealthy'),
             ('backend.busy', 'MAIN.backend_busy'),
             ('backend.fail', 'MAIN.backend_fail'),
             ('backend.reuse', 'MAIN.backend_reuse'),
             ('backend.toolate', 'MAIN.backend_toolate'),
             ('backend.recycle', 'MAIN.backend_recycle'),
             ('backend.retry', 'MAIN.backend_retry'),
             ('backend.req', 'MAIN.backend_req'),
             ('session.conn', 'MAIN.sess_conn'),
             ('session.drop', 'MAIN.sess_drop'),
             ('client.req', 'MAIN.client_req'),
             ('client.hdrbytes', 'MAIN.s_resp_hdrbytes'),
             ('client.bodybytes', 'MAIN.s_resp_bodybytes')]

  for (name, metric) in metrics:
    status.append(fmt(name, metric))

  return status


def main():
  parser = argparse.ArgumentParser(
      description='Collect and stream Varnish statistics to Graphite.',
      formatter_class=argparse.ArgumentDefaultsHelpFormatter)

  parser.add_argument('-H', '--host',
      default='127.0.0.1',
      help='The graphite server host')
  parser.add_argument('-p', '--port',
      default=2003,
      help='The graphite server port')
  parser.add_argument('-n', '--name',
      default=socket.gethostname(),
      help="""Specifies the name of the varnishd instance to get logs from. If
           -n is not specified, the host name is used.""")
  parser.add_argument('-P', '--prefix',
      default='varnish',
      help='The prefix for metric names')
  parser.add_argument('-i', '--interval',
      default=10,
      help='The collection interval in seconds')
  # Ethernet - (IPv6 + TCP) = 1500 - (40 + 32) = 1428
  parser.add_argument('-b', '--buffer-size', dest='buffer_size',
      default=1428,
      help='The number of bytes to send each time')
  # Default 32M max buffer size. Discard anything extra if we aren't able to send.
  parser.add_argument('-B', '--max-buffer-size', dest='max_buffer_size',
      default=33554432,
      help='The maximum number of bytes to buffer when reconnecting')

  args = parser.parse_args()

  logging.basicConfig(level=logging.INFO)

  try:
    c = GraphiteClient(args.host, args.port, args.prefix, args.buffer_size, args.max_buffer_size)
    while True:
      interval_start = time()

      c.send_metrics(collect_metrics(args.name))

      interval_used = time() - interval_start
      if interval_used < float(args.interval):
        sleep(float(args.interval) - interval_used)
  except KeyboardInterrupt:
    c.disconnect();

if __name__ == "__main__":
  main()
