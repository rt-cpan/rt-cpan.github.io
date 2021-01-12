#!/usr/bin/perl

use strict;
use warnings;
use Devel::Peek;
use URI;

my $latin1	= URI->new('http://www.xn--hestebedgrd-58a.dk/')->as_iri;
my $utf8	= URI->new('http://xn--df-oiy.ws/')->as_iri;

Dump($latin1);
Dump($utf8);
