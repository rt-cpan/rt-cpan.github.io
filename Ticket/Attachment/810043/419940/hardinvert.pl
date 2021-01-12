#!/usr/bin/perl

use strict;
use warnings FATAL => 'all';

use Imager;

my $im = Imager->new;

$im->read(file => $ARGV[0]) or die $im->errstr;

$im->filter(type => 'hardinvert');

$im->write(fh => \*STDOUT, type => 'png') or die $im->errstr;
