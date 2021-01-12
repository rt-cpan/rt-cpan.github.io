#!/usr/bin/env perl

######################################################################
# TimeoutBot is a bot to test a timeout error                        #
# Copyright (C) 2020  Asher Gordon <AsDaGo@posteo.net>               #
#                                                                    #
# Copying and distribution of this file, with or without             #
# modification, are permitted in any medium without royalty provided #
# the copyright notice and this notice are preserved.  This file is  #
# offered as-is, without any warranty.                               #
######################################################################

use strict;
use warnings;
use Net::Telnet;
use Getopt::Long;
use subs 'tell'; # Override CORE::tell with Main::tell functions

my $name = 'TimeoutBot';
my $host = 'freechess.org';
my $port = 5000;

# The time (in seconds) that we need to do something in order to
# prevent the server from kicking us off.
my $ping_time = 3600;

# The time of the last tell.
my $last_tell_time;

my $usage = <<EOF;
Usage: $0 [-n NAME] [-l FILE] [HOST [PORT]]
Connect to the chess server at HOST (default $host) through port PORT
(default $port) and start running.

  -n, --name=NAME       use NAME to log in rather than $name
  -l, --log-file=FILE   log all I/O to FILE
  -h, --help            print this help and exit
EOF

GetOptions
    'n|name=s'		=> \$name,
    'l|log-file=s'	=> \my $log_filename,
    'h|help'		=> sub { print $usage; exit }
    or die $usage;

$host = shift if @ARGV;
$port = shift if @ARGV;
die if @ARGV;

die "Invalid handle: $name" unless $name =~ /^[[:alpha:]]+$/;
die "Handle too long (must be at most 17 characters): $name"
    if (length $name) > 17;

my $log_file;
if (defined $log_filename && ! open $log_file, '>', $log_filename) {
    warn "Cannot open $log_filename: $!";
    undef $log_filename;
    undef $log_file;
}

my $telnet;

# Die unless the error was a timeout.
sub die_unless_timeout {
    die $_[0] unless $telnet->timed_out;
}

sub tell {
    my $user = shift;
    my $msg = @_ ? "@_" : $_;
    my $ret = $telnet->cmd("tell $user $msg");
    $last_tell_time = time;
    return $ret;
}

# Connect to the server.
print "Opening connection to $host on port $port\n";
$telnet = new Net::Telnet
    Host	=> $host,
    Port	=> $port;
$telnet->input_log($log_file) if defined $log_file;
$telnet->open;

# Log in.
print "Waiting for login prompt\n";
$telnet->waitfor('/\rlogin: $/');
print "Logging in\n";
$telnet->print($name);
$telnet->print();

# Initialize the last tell time.
$last_tell_time = time;

# Wait for the prompt.
$telnet->waitfor('/\rfics% /');

# Wait a bit for all the initialization text to finish coming.
sleep 1;

# Run the initialization commands.
$telnet->cmd('set open 0');
$telnet->cmd('set seek 0');
$telnet->cmd('set width 240');
$telnet->cmd("set interface $name");
$telnet->cmd('set 1 I am a bot to test a timeout error that occurs ' .
	     'with blikII.');

my $timeout = 10;

# Start the main loop.
while (1) {
    my $period = time - $last_tell_time;

    # Check if we should do something so that the server doesn't kick
    # us off. Allow for an extra grace period of $timeout.
    tell $name, 'ping'
	if defined $ping_time && $period > $ping_time - $timeout;

    $_ = $telnet->getline(Timeout => $timeout,
			  Errmode => \&die_unless_timeout);
    next unless defined;
    chomp;
    s/^\r//;

    if (/^([[:alpha:]]+).*? tells you:\s+(.*)$/) {
	tell $1, qq/Hi $1. You told me "$2"./;
    }
}
