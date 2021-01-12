#!/usr/bin/perl
use v5.14;
use warnings;

use SVG;

my $svg = SVG->new;
my $circle = $svg->circle(cx => 20, cy => 20, r => 18);
$circle->insertSiblingAfter($circle);
say $svg->xmlify;
