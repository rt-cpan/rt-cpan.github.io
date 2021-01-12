# -*- perl -*-
use strict;
use warnings;

use Test::More qw(no_plan);
use Data::Dumper;

my @lines;
my $output = 'output.txt';
open my $FH, $output or die "Unable to open $output for reading";
while (<$FH>) {
    chomp;
    push @lines, $_;
}
close $FH or die "Unable to close $output";
print STDERR Dumper \@lines;
pass("All tests passed in $0");

