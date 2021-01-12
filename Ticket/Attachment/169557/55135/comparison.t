#!/usr/bin/perl

use strict;
use warnings;
use Test::More tests => 47;
use Number::Fraction;

my $x = Number::Fraction->new('1/2');
my $y = Number::Fraction->new('1/4');
my $z = Number::Fraction->new('1/33');

is( $x == '1/2', 1, "x == '1/2'" );
is( $y == '1/4', 1, "y == '1/4'" );
is( $z == '1/33', 1, "z == '1/33'" );

ok( $x > $y, "x > y" );
ok( $x > $z, "x > z" );
ok( $y > $z, "y > z" );

ok( $y < $x, "y < x" );
ok( $z < $x, "z < x" );
ok( $z < $y, "z < y" );

is( $x <=> $y, 1, "x <=> y" );
is( $x <=> $z, 1, "x <=> z" );
is( $y <=> $z, 1, "y <=> z" );

is( $x <=> $x, 0, "x <=> x" );
is( $y <=> $y, 0, "y <=> y" );
is( $z <=> $z, 0, "z <=> z" );

is( $y <=> $x, -1, "y <=> x" );
is( $z <=> $x, -1, "z <=> x" );
is( $z <=> $y, -1, "z <=> y" );

is( $x cmp $y, 1, "x cmp y" );
is( $x cmp $z, 1, "x cmp z" );
is( $y cmp $z, 1, "y cmp z" );

is( $x cmp $x, 0, "x cmp x" );
is( $y cmp $y, 0, "y cmp y" );
is( $z cmp $z, 0, "z cmp z" );

is( $y cmp $x, -1, "y cmp x" );
is( $z cmp $x, -1, "z cmp x" );
is( $z cmp $y, -1, "z cmp y" );

ok( 0.33 < $x, "0.33 < x" );
ok( $x > 0.33, "x > 0.33" );
ok( '1/3' < $x, "'1/3' < x" );
ok( $x > '1/3', "x > '1/3'" );

is( $x == 0.5, 1, "x == 0.5" );
is( $y == 0.25, 1, "y == 0.25" );
is( $x eq 0.5, 1, "x eq 0.5" );
is( $y eq 0.25, 1, "y eq 0.25" );

is( $x <=> 0.5, 0, "x <=> 0.5" );
is( $x <=> 0.4, 1, "x <=> 0.4" );
is( $x <=> 0.6, -1, "x <=> 0.6" );
is( 0.5 <=> $x, 0, "0.5 <=> x" );
is( 0.4 <=> $x, -1, "0.4 <=> x" );
is( 0.6 <=> $x, 1, "0.6 <=> x" );

is( $x cmp 0.5, 0, "x cmp 0.5" );
is( $x cmp 0.4, 1, "x cmp 0.4" );
is( $x cmp 0.6, -1, "x cmp 0.6" );
is( 0.5 cmp $x, 0, "0.5 cmp x" );
is( 0.4 cmp $x, -1, "0.4 cmp x" );
is( 0.6 cmp $x, 1, "0.6 cmp x" );

#eof#
