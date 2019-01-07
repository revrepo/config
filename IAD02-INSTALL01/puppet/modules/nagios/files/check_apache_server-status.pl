#!/usr/bin/perl

#
# This file is managed by Rev Puppet service as described on Wiki
# page https://revwiki.atlassian.net/wiki/display/OP/Puppet+Centralized+Configuration+Management+System
# Please don't modify the file on the Puppet client server since your changes will be overwritten on the next
# Puppet agent run on the server.
#

use Getopt::Std;

my %options=();
getopts("H:v:w:c:u:",\%options);

### CONFIGURATION 
%monitor_type = (   
                'traffic'               => 'LiB',
                'requests_per_second'   => 'LiB',
                'bytes_per_request'     => 'LiB',
                'accesses'              => 'LiB',
                'bytes_per_second'      => 'LiB',
                'idle_worker'           => 'HiB',
                #'uptime'                => 'LiB',
                'current_requests'      => 'LiB'
            );
%critical = (   'traffic'               => '60', #MB
                'requests_per_second'   => '6',
                'bytes_per_request'     => '1024',
                'accesses'              => '100000',
                'bytes_per_second'      => '1000',
                'idle_worker'           => '50',
                'current_requests'      => '150'
            );
%warning  = (   'traffic'               => '50', #MB
                'requests_per_second'   => '4',
                'bytes_per_request'     => '768',
                'accesses'              => '50000',
                'bytes_per_second'      => '800',
                'idle_worker'           => '150',
                'current_requests'      => '70'
            );
my @pretext = ('APACHE OK','APACHE WARNING','APACHE CRITICAL','APACHE UNKNOWN');
my $server  = $options{'H'};
my $mon     = $options{'v'};
my $server_uri     = "/status";
$server_uri     = $options{'u'};

$warning{$mon}  = $options{'w'} if ($options{'w'});
$critical{$mon} = $options{'c'} if ($options{'c'});

help() if (! $options{'H'});

my %data    = get_apache_status($server);
if (! keys(%data)) {
   print $pretext[3].": $server did not deliver information.\n";
   exit(3);
}

if ($mon) {
	($status,$text) = CheckValue($mon,\%data);
} else {
	($status,$text) = CheckAll(\%data);
}

print $pretext[$status].":".$text."\n";
exit($status);

sub CheckAll(\%) {
   my $data		= shift();
   my %stati		= ();
   my $fin_status	= 0;
   foreach my $mon (keys(%monitor_type)) {
	my ($status,$txt) 	= CheckValue($mon,$data);
	$stati{$status}{$mon} 	= $txt; 
	$fin_status = $status if ($status > $fin_status);
   }
   
   if ($fin_status == 2) {
	map{ $text .= " $_"; }keys(%{$stati{2}});
   } elsif ($fin_status == 1) {
	map{ $text .= " $_"; }keys(%{$stati{1}});
   }
   $text .= ' ('.scalar(keys(%{$stati{2}})).'c/'.scalar(keys(%{$stati{1}})).'w/'.scalar(keys(%{$stati{0}})).'o)';
   return($fin_status,$text);
}

sub help() {
   print <<HERE;
	check_apache_status
	Fetches the server-status page of an apache, extracts some information and evaluates them.
	
	usage: check_apache_status -H HOSTNAME -v VARNAME [-c LIMIT] [-w LIMIT] [-u SERVER_URI]

	VARNAME might be one of:
		traffic			provided in MB
                requests_per_second	LiB
                bytes_per_request	LiB
                accesses		LiB
                bytes_per_second	LiB
                idle_worker		HiB
                current_requests	LiB
		uptime			[will allways deliver UNKNOWN]

	HiB = Higher is Better
	LiB = Lower is Better
HERE
   exit;
}

sub CheckValue($\%) {
   my $mon = shift();
   my $data= shift();
   if ($$data{$mon}) {
	if ($monitor_type{$mon} eq 'LiB') { # Lower is better
	    if ($$data{$mon} >= $critical{$mon}) {
		# status CRITICAL for "lower = better"
		$ret = 2;
	    } elsif ($$data{$mon} >= $warning{$mon}) {
		# status WARNING for "lower = better"
		$ret = 1;
	    } else {
		# status OK for "lower = better"
		$ret = 0;
	    }
	} elsif ($monitor_type{$mon} eq 'HiB') { # Higher is better
	    if ($$data{$mon} <= $critical{$mon}) {
		# status CRITICAL for "higher = better"
		$ret = 2;
	    } elsif ($$data{$mon} <= $warning{$mon}) {
		# status WARNING for "higher = better"
		$ret = 1;
	    } else {
		# status OK for "higher = better"
		$ret = 0;
	    }
	} else {
	    # Unknown Monitor-Type
	    $ret = 3;	
	}
   } else {
       $ret = 3;
   }
   return($ret,"$mon is ".$$data{$mon}."|".$mon."=".$$data{$mon}.";;");
}

sub get_apache_status($) {
    use LWP::UserAgent;
    use URI::URL;

    my $uri  = shift() || return();
       $uri  = 'http://'.$uri.'/'.$server_uri;
    my $hdrs = new HTTP::Headers(Accept => 'text/plain',
                             User-Agent => 'STAMPBrowser/1.0');
    my $ua   = new LWP::UserAgent;
    my $url  = new URI::URL($uri);
    my $req  = new HTTP::Request(GET, $url, $hdrs);
    my $resp = $ua->request($req);
    my $code = $resp->content;

#    Server Version: Apache/2.0.59 (Win32) PHP/5.1.6
#    Server Built: Jul 27 2006 15:55:03
#    
#    Current Time: Friday, 11-Apr-2008 09:16:25 W. Europe Daylight Time
#    Restart Time: Friday, 11-Apr-2008 06:01:18 W. Europe Daylight Time
#    Parent Server Generation: 38
#    Server uptime:  3 hours 15 minutes 7 seconds
#    Total accesses: 30554 - Total Traffic: 4.9 MB
#    2.61 requests/sec - 439 B/second - 168 B/request
#    3 requests currently being processed, 597 idle workers
 
    my %results = ();
    while ($code =~ /<dt>([^<]+)<\/dt>/g ) {
        my $line = $1;
        if ($line =~ /Server\s+uptime:\s+(\d+)\s+days\s+(\d+)\s+hours\s+(\d+)\s+minutes\s+(\d+)\s+seconds/) {
            $results{'uptime'} = sprintf("%04d:%02d:%02d:%02d",$1,$2,$3,$4);
        } elsif ($line =~ /Server\s+uptime:\s+(\d+)\s+hours?\s+(\d+)\s+minutes\s+(\d+)\s+seconds/) {
            $results{'uptime'} = sprintf("0000:%02d:%02d:%02d",$1,$2,$3);
        } elsif ( $line =~ /Total\s+accesses:\s+(\d+)\s+-\s+Total\s+Traffic:\s+([\d\.]+)\s+MB/) {
            $results{'accesses'}           = $1;
            $results{'traffic'}            = $2; # MB->bytes
        } elsif ( $line =~ /([\d\.]+) requests\/sec - ([\d\.]+) B\/second - ([\d\.]+) B\/request/) {
            $results{'requests_per_second'} = $1;
            $results{'bytes_per_second'}    = $2;
            $results{'bytes_per_request'}   = $3;    
        } elsif ( $line =~ /(\d+) requests currently being processed, (\d+) idle workers/) {
            $results{'current_requests'}    = $1;
            $results{'idle_worker'}         = $2;   
        }
    }
    return(%results); 
}
