#!/usr/bin/perl

use strict;
use warnings;
use Test::More tests => 11;
use Number::Fraction;

foreach my $n ( qw(
        1
        2
        -3
        1/2
        -1/2
    ) ){
  my $x = Number::Fraction->new($n);
  ok( $x == $n, "got '$n'" );
}

foreach my $n ( undef, '', qw(
        0.5
        a
        1a
        0.5.1
    ) ){
  my $x = Number::Fraction->new($n);
  is( $x, undef, "got undef for '$n'" );
}
