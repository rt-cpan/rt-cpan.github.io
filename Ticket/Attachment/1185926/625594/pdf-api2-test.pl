#!/usr/bin/perl -w

use strict;
use PDF::API2;

my $origpdfo = PDF::API2->open($ARGV[0]);
my $singlepdfo = PDF::API2->new;
$singlepdfo->mediabox($origpdfo->openpage(1)->get_mediabox);
$singlepdfo->page->gfx->formimage($singlepdfo->importPageIntoForm(PDF::API2->open($ARGV[0]),1),0,0);
$singlepdfo->saveas($ARGV[1]);
