#!/usr/bin/perl
# -*- encoding: utf-8; indent-tabs-mode: nil -*-

use v5.10;
use strict;
use warnings;
use Carp;
use GD::Simple;

my $fmt     = " %3d" x 10;
my $step    = 15;
my $fuzz    =  3;
my $neg_fix =  0;

for     (my $r0 = 0; $r0 <= 255; $r0 += $step) {
  for   (my $g0 = 0; $g0 <= 255; $g0 += $step) {
    for (my $b0 = 0; $b0 <= 255; $b0 += $step) {
      my ($h,  $s,  $v)  = GD::Simple->RGBtoHSV($r0, $g0, $b0);
      my ($r1, $g1, $b1) = GD::Simple->HSVtoRGB($h, $s, $v);
      my $delta = abs($r1 - $r0) + abs($g1 - $g0) + abs($b1 - $b0);
      if ($delta > $fuzz) {
	say sprintf $fmt, $h, $s, $v, $r0, $g0, $b0, $r1, $g1, $b1, $delta;
      }
    }
  }
}

