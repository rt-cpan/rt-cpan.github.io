#!/usr/bin/perl
use strict;

use PDF::API2;

my $output = PDF::API2->open('test.pdf');
my $otls=$output->outlines();
print "Document 1: $otls\n";
my $section = $otls->outline();
$section->title("Test");
$output->end;

