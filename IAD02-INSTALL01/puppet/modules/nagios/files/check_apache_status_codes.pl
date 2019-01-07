#!/usr/bin/perl
use strict;
my $start_run = time();

use lib '/usr/local/share/perl/5.18.2';

use Pod::Usage();
use Getopt::Long();

my $count;
my $lvl;
my $error_code;
my $warning_lvl = 0;
my $critical_lvl = 0;
my $help = 0;

Getopt::Long::GetOptions (
	'error|e=s' => \$error_code,
	'warning|w=s' => \$warning_lvl,
	'critical|c=s' => \$critical_lvl,
	'help|?' => \$help,
	);

pod2usage(1) if ($help);
pod2usage(1) if (!$ARGV[0]);
pod2usage("Log file does not exist") unless -e($ARGV[0]);

my $count;

sub report {

	if($count > $critical_lvl){
		$lvl = "CRITICAL:";
	}elsif($count > $warning_lvl){
		$lvl = "WARNING:";
	}

my $end_run = time();
my $run_time = $end_run - $start_run;

print $lvl.' - '.$error_code."_responses=".$count."\n";
print "Job took $run_time seconds\n";
exit;
}

open (F, "/usr/sbin/logtail $ARGV[0] |") or die;
while (<F>) {
	if ($_ =~m/HTTP\/1\.1" $error_code/o) {
		$count++;
	}
}
report;

__END__

=head1 NAME

Nagios Http Log Monitoring tool

=head1 SYNOPSIS

scrape_http_nagios.pl [arguments] [Vaild/path/to/logfile]

 Arguments:
 -e, -error	Error code your looking for, defaults returning all codes
 -w, -warning   Maximum acceptable errors before warning error, Defaults at none
 -c, -critical  Maximum acceptable errors before critical error, Defaults at none
 -h, -help	Help Message

