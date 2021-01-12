#!/opt/bin/perl

use warnings;
use strict;

use Imager;


my $imager = Imager->new;
$imager->read(file => 'imager.tiff', type => 'tiff');

my $col = $imager->getpixel(x => 1, y => 1);
