#!/usr/bin/env perl

use strict;
use warnings;

use IO::Uncompress::Gunzip;

my $io = IO::Uncompress::Gunzip->new(shift(@ARGV));

while (local $_ = $io->getline()) {
    m/^#/ && next;
    chomp;

    my @fields = split(/\t/);

    if (scalar(@fields) != 8) {
	die sprintf("Incomplete line (line %u): \"$_\"",$io->input_line_number());
    }
    if ($fields[0] ne "Chromosome01") {
	die sprintf("Incomplete line (line %u): \"$_\"",$io->input_line_number());
    }
}

$io->close();
