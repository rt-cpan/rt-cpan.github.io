#!/usr/bin/perl -w
use strict;

use Test::More;

use autodie;

package A;

sub bad {
    open(my $i, '<', 'nonexist');
}

package main;

eval {
    A::bad;
};

isa_ok($@, 'autodie::exception', 'autodie in file scope should take effect in entire file');

eval {
    open(my $i, '<', 'nonexist');
};

isa_ok($@, 'autodie::exception', 'autodie in file scope should affect the main package too');

done_testing();
