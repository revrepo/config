#!/usr/bin/perl
#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
#

#
# The simple script extracts "domain" and "request" fields from the local nginx JSON-based log and prints full URL on standard output
#

use strict;
use warnings;
use 5.012;

my $file = '/var/log/nginx/revsw_nginx_access_json.log';
open my $fh, '<', $file or die "Could not open '$file' $!\n";

while (my $line = <$fh>) {
   chomp $line;
   my @strings = $line =~ /.*\"domain\"\:\s\"(\S+)\".*\"request\"\:\s\"(\S+)\"/g;
   print "http://".$strings[0].$strings[1]."\n";
}
