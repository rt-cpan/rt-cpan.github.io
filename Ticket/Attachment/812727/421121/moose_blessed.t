#!/usr/bin/perl

use strict;
use warnings;

package BreakMoose;

use Test::More tests => 2;
use Scalar::Util qw(blessed);

use Moose;

my $foo = bless { }, 'BreakMoose';

ok( blessed $foo, '$foo is blessed' );

no Moose;

ok( blessed $foo, '$foo is still blessed' );

1;
