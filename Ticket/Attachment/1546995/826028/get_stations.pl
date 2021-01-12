#!/usr/bin/env perl

# Pragmas.
use strict;
use warnings;

# Modules.
use Encode qw(encode_utf8);
use Map::Tube::Bucharest;

# Arguments.
if (@ARGV < 1) {
	print STDERR "Usage: $0 line\n";
	exit 1;
}
my $line = $ARGV[0];

# Object.
my $metro = Map::Tube::Bucharest->new;

# Get tables.
my $stations_ar = $metro->get_stations($line);

# Print lines.
foreach my $station (@{$stations_ar}) {
	print encode_utf8($station)."\n";
}
