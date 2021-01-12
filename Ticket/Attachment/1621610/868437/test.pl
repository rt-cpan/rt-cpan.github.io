#!/usr/bin/env perl

use strict;
use warnings;

use Error qw(:try);

sub foo {
    if (1) {
        do_something();
    }
    else {
        do_something_else();
    }

    try { something(); }
catch
 Error
 with {
 something_else(); }
    finally { foo(); 
};
}

try { croak "An Error ёбаный стыд!"; }
catch($error) {    print STDERR $error . "\n";};

