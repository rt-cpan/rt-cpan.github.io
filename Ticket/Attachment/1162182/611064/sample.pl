#!/usr/bin/perl

use strict;
use warnings;

my $foo = '1:2';
my $bar;

if (defined $foo) {
    if (defined $bar) {
        warn '$bar defined';
    }

    (my $baz = $foo) =~ s/^\d+://;
} else {
    warn 'undefined value for $foo';
}
