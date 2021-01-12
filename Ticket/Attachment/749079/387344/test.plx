#!/usr/bin/perl

use autobox;

sub SCALAR::mo {
    print "mo called\n";
    return bless \$_[0], "Meta";
}

my $foo = 42;
$foo->mo;
$foo->mo;
