#!/usr/bin/perl

use strict;
use warnings;

use Future;
use Future::AsyncAwait;

my $N = shift @ARGV // 0;

my $f;

async sub inner
{
   ( $N == 2 ) or await $f;
   die "Oopsie\n";
}

async sub outer
{
   await inner();
}

$f = Future->new;

my $fret = ( $N == 1 ) ? inner() : outer();

$f->done( "result" );

print STDERR "Failure was: ", scalar $fret->failure;
