#!/usr/bin/perl

use XML::LibXML;

my $p = XML::LibXML->new;
my $doc = $p->parse_file("utf-16-2.cml");
#$doc->setEncoding('utf-8'); # "fixes" the problem
my @nodes = $doc->findnodes("/cml/*");

