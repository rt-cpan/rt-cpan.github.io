#!/usr/bin/env perl

use strict;
use warnings;
use HTTP::Server::Simple;
use Net::Server::Fork;
my $a = Net::Server::Fork->new();

my $TEST_PORT = $ARGV[0];

my $server = HTTP::Server::Simple->new($TEST_PORT);

$server->net_server($a);
my $pid = $server->background;

print "PID: $pid\n";
