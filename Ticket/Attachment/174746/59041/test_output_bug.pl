#!/usr/local/bin/perl
use strict;
use warnings;
use Test::More qw(no_plan);
use Test::Output qw(stdout_from stderr_from combined_from output_from);

my ($x, $y);

($x, $y) = output_from(sub {print qq~stdout~; print STDERR qq~stderr~});
print "'$x'$y'\n";

($x, $y) = output_from(sub {system 
	'perl -e "print qq~stdout~; print STDERR qq~stderr~"'});
print "'$x'$y'\n";

($x, $y) = output_from(sub {system 'echo "hi" && ls JKFLDSF'});
print "'$x'$y'\n";
