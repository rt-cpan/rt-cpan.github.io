# -*- perl -*-
#$Id: 02_list.t 1110 2006-12-14 03:56:31Z jimk $
# t/02_list.t - test what happens when source is a list
use strict;
use warnings;

use Test::More qw(no_plan);
use Carp;
use Data::Dumper;

my @lines;
my $output = 'output';
open my $FH, $output or croak "Unable to open $output for reading";
while (<$FH>) {
    chomp;
    push @lines, $_;
}
close $FH or croak "Unable to close $output";
print Dumper \@lines;
pass("All tests run in $0");

