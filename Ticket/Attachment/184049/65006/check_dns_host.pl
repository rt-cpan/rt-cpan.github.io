#!/usr/bin/perl

#FILE: check_dns.pl
#SYNOPSIS: check A/PTR records for a host. Added support for checking matching returnval vs. a string, and #of responses.

#use strict;
#use warnings;
use Net::DNS;
use Getopt::Long;
use Pod::Usage;
use Time::HiRes qw( usleep ualarm gettimeofday tv_interval );


### Define ARGV options:
my ($host,$match,$server,$timeout,$wlevel,$clevel,$retvalnum,$query_type);

GetOptions(
	"H=s" => \$host,
	"m=s" => \$match,
	"s=s" => \$server,
	"q=s" => \$query_type,
	"t=i" => \$timeout,
	"r=i" => \$retvalnum,
	"w=i" => \$wlevel,
	"c=i" => \$clevel
);

if(!$timeout){$timeout=10};
alarm($timeout);
$SIG{ALRM} = sub {print "$0 timed out.\n"; exit 2;};

if(!$host || !$wlevel || !$clevel){
	pod2usage("$0: fixme");
	exit 3;
}

if($wlevel>=$clevel){
	pod2usage("$0: fixme");
	exit 3;  # Nagios: unknown
}


######################################################################################
### START code:
######################################################################################

### define program vars:
my ($header,$exitstate,@retval,$checkfailed);

# Initialize the DNS Resolver package and start timer:
my $res = Net::DNS::Resolver->new(
  recurse     => 0,
  debug       => 1,
);

my ($t0, $t1);
$t0 = [gettimeofday];

### define program flow:

&query_run;
&query_lint;
&query_compile;
&eval;


######################################################################################
### Execute defined query:

# Perform the lookup, and set status values:
sub query_run {
  $query = $res->search("$host");
  # Calculate time elapsed for lookup:
  $t1 = [gettimeofday];
  $elapsed = int (1000 * tv_interval ( $t0, $t1));
  $query_returncode = ($query->{header}->{rcode});
  $query_count = ($query->{header}->{ancount});
} #/sub query_run

sub query_compile {
# Populate comparison array based on query type:

  if ($query_type eq "FORWARD") { # A queries:
      foreach my $rr ($query->answer) {
        next unless $rr->type eq "A";
        my $ip =  $rr->address;
            push (@retval, $ip);
      }
    } #/if ($query_type eq "FORWARD")

  if ($query_type eq "REVERSE") { # PTR queries:
    foreach my $rr ($query->answer) {
      next unless $rr->type eq "PTR";
      my $hostname =  $rr->ptrdname;
      push (@retval, $hostname);
    }
  } #/if ($query_type eq "REVERSE")
} #/sub query_compile

sub query_lint {
print "\$query_returncode: $query_returncode \n";
  unless ($query_returncode) {
  print "\$query->{header}->{ancount}: $query->{header}->{ancount} \n";
  print "\$query->{header}->{rcode}: $query->{header}->{rcode} \n";
    $querycheck = "FAILED";
    &exit;
  }
  print "\$query->{header}->{ancount}: $query->{header}->{ancount} \n";
  print "\$query->{header}->{rcode}: $query->{header}->{rcode} \n";
}

######################################################################################
### FUNCTION: eval
### Check for failure conditions:
sub eval {

# Query failed:
if ($query_returncode ne "NOERROR") {
  $exitstate = "CRITICAL";
  &exit;
}

# warn timeout threshhold exceeded:
if ($elapsed > $wlevel) {
  $exitstate = "WARNING";
  &exit;
}

# crit timeout threshhold exceeded:
if ($elapsed > $clevel) {
  $exitstate = "CRITICAL";
  &exit;
}

# num query returns out of specified bounds:
if ($retvalnum) {
  ($retvalnum != $query_count) && ($exitstate = "CRITICAL");
  if ($exitstate) {
    $checkfailed = qq{"RETVAL:$retvalnum" != "QUERYCOUNT:$query_count"};
    &exit;
  }
} 

# query return does not match specified string:
if ($match) {
  foreach my $value (@retval) {
  ($match eq $value) || ($exitstate = "CRITICAL");
  }
  if ($exitstate) {
    $checkfailed = qq{"MATCH:$match" != "RETVAL:@retval"};
    &exit;
  }
}

# Yay! all seems OK...
$query_returncode eq "NOERROR" && ($exitstate = "OK");
&exit;
}

######################################################################################
### FUNCTION: exit
sub exit {

print "\$query_returncode: $query_returncode \n";

# Query failures:
if ($queryfailed) {
  die "QUERY FAILED";
}

# check failures:
if ($checkfailed) {
  print "EXITING ERROR \n";
  $output = "DNS $exitstate=($checkfailed) QUERYRETURNCODE=($query_returncode) ANSWERS=($query_count) QUERY_RETURNVAL=(@retval) ELAPSED=(${elapsed} ms) | DurationMS=$elapsed";
} else {
#  print "EXITING NOERROR \n";
  $output = "DNS $exitstate: ANSWERS=($query_count) QUERY_RETURNVAL=(@retval) ELAPSED=(${elapsed} ms) | DurationMS=$elapsed";
  $checkfailed = "";
}

print "$output \n";

exit 2 if(!$query_returncode);            # Nagios: Critical
exit 2 if($elapsed>$clevel);   # Nagios: Critical
exit 2 if($query_count != $retvalnum);   # Nagios: Critical
exit 2 if(!$checkfailed eq "");   # Nagios: Critical
exit 1 if($elapsed>$wlevel);   # Nagios: Warning
exit 0;                        # Nagios: OK
}

### perldoc:

=head1 NAME

check_dns.pl - DNS-Query and Statistics

=head1 SYNOPSIS

        check_dns.pl -H host -s server -w wlevel -c clevel [-t timeout]

        host:    The host to be resolved
        server:  The DNS-server to ask
        timeout: Timeout in seconds
        wlevel:  Warning treshhold (milliseconds)
        clevel:  Critical treshhold (milliseconds)

=head1 DESCRIPTION

This asks a server to resolve a host. It returns OK if the process was
successfull and took less than wlevel milliseconds.

It returns a warning if it took less than clevel milliseconds.

Everything else returns critical. (Also, if it takes longer than timeout.)

=head1 PROBLEMS

This contains a hardcoded perl lib directory. Might wanna change this if
running on a machine with only one perl distribution.

Not too reliable timing functions, I suppose.

=head1 AUTHOR

Copyright (c) 2003 Hannes Schulz <mail@hannes-schulz.de>

=cut
#</perldoc>

