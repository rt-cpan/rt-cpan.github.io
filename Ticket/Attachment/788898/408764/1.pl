#!/usr/bin/perl

my $sub = eval q[sub { print "abc\n" } ];
$sub->();

