#!/usr/bin/perl -w
use strict;

use Test::More;

package A;

use autodie;

sub bad {
    open(my $i, '<', 'nonexist');
}

package main;

eval {
    A::bad;
};

isa_ok($@, 'autodie::exception', 'autodie in package scope should affect the package');

eval {
    open(my $i, '<', 'nonexist');
};

is($@, '', 'autodie in package scope should not affect the main package');

done_testing();
