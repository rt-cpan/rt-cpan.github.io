#!/usr/bin/env perl

# Pragmas.
use strict;
use warnings;

# Modules.
use Encode qw(decode_utf8 encode_utf8);
use Map::Tube::Sofia;

# Arguments.
if (@ARGV < 2) {
	print STDERR "Usage: $0 from to\n";
	exit 1;
}
my $from = decode_utf8($ARGV[0]);
my $to = decode_utf8($ARGV[1]);

# Object.
my $metro = Map::Tube::Sofia->new;

# Get route.
my $route = $metro->get_shortest_route($from, $to);

# Print route.
print "Route: ".encode_utf8($route)."\n";
