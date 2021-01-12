#! /usr/bin/env perl

use PDF::API2;
use strict;
use warnings;

my $filename = shift or die "Usage: $0 <file.pdf>\n";
my $pdf      = PDF::API2->open($filename);
my $out      = PDF::API2->new();
my $out_page = $out->import_page( $pdf, 1 );
