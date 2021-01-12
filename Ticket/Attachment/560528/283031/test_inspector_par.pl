#!/usr/bin/perl
use strict;
use warnings;
use PAR 'foobar.par';
use Class::Inspector;

if (Class::Inspector->installed('Foo::Bar')) {
    print "Foo::Bar is found :)\n";
}
else {
    die "Foo::Bar not found! :(\n";
}
