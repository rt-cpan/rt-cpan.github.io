#!/bin/env perl

use strict;
use Getopt::Long;

my $insep = '';
my $outsep = '';
my $result = GetOptions ("in-seperator=s" => \$insep,
                        "out-seperator=s"   => \$outsep,
);

if (!$insep) {
    die "Missing args : in-seperator \n";
}
if (!$outsep) {
    die "Missing args : out-seperator \n";
}
$insep =~ s/([^\w\\])/\\$1/g;
while (<>) {
    chomp();
    my @F = split ($insep, $_) ;
    print join( $outsep, @F ), "\n";
}