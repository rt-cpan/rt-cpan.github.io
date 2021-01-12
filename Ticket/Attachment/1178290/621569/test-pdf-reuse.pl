#!/usr/bin/perl -w

use warnings;
use strict;
use PDF::Reuse;


prDocDir(".");
prFile("test-save-works.pdf");
prDoc( { file  => "testpdf-works.pdf",
         first => 1,
         last  => 1});
prEnd(); #file has now been save to disk

print "finished works\n";


prDocDir(".");
prFile("test-save-breaks.pdf");
prDoc( { file  => "testpdf-breaks.pdf",
         first => 1,
         last  => 1});
prEnd(); #file has now been save to disk

print "finished breaks\n";
