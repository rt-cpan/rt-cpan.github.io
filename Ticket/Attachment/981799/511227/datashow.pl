#!/usr/bin/perl

use strict;
use warnings;
use Data::Show;

my %hash = ( 'a' => 'b', 'c' => 'd' );
show(%hash);

my @keys = keys(%hash);
show(@keys);

my @array = qw( foo bar );
show(@array);
