#!/usr/bin/perl -lw

use Want;

sub ok($) {
    print @_;
}

sub foo {
    return "CODE" if want("CODE");
}

ok( foo() );
