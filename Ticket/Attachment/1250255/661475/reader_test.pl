#!/usr/bin/perl

use strict;
use warnings;
use Devel::SizeMe qw(perl_size);
use XML::LibXML::Reader;

for (1..10) {
    for (1..1000) {
        my $r = XML::LibXML::Reader->new(string => '<html></html>');
        while ($r->read) {
            $r->preserveNode();
        }
    }
    print "Memory usage: ", perl_size(), "\n";
    sleep 1;
}

