#!/usr/bin/perl -w

use PDL;

##-- test data
my $a = sequence(2,13);
my $b = sequence(3,2,13);

##-- bash to max 2 dimensions
my $a2 = $a->clump(-2);   ##-- no-op
my $b2 = $b->clump(-2);   ##-- merge 1st 2 dims

##-- see what happened
print "a2 dims = ", join(' ', $a2->dims), "\n";
print "b2 dims = ", join(' ', $b2->dims), "\n";

##-- EXPECETED output (e.g. from PDL-2.013)
## a2 dims = 2 13
## b2 dims = 6 13

##-- ACTUAL output from PDL-2.014
## a2 dims = 1 0 0 2 13
## b2 dims = 1 0 45127691276002 3 2 13
