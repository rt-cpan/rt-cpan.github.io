#!/usr/bin/perl -w

use strict;
use warnings;
use PPI;

sub foo {
    my $foo = shift;

    $foo++;

    die <<END;
Stuff and things
END
}

print "First\n";
print PPI::Document->new($0)->find_first("PPI::Statement::Sub")->block;

print "Second\n";
my $sub = PPI::Document->new($0)->find_first("PPI::Statement::Sub");
print $sub->block;
