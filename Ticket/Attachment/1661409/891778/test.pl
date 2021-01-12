#!/usr/bin/perl -w

use warnings;
use strict;

use PDF::API2;

my $pdf   = PDF::API2->open("test.pdf");

$pdf->saveas("test-mod.pdf");
$pdf->end;
