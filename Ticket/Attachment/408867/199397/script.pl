#!/usr/bin/perl -w

use strict;
use warnings;
use Imager;

my $img = Imager->new(); 
my $thumb = Imager->new();

$img->open(file => "kenya-flagmap.png") or die $img->errstr;
$thumb = $img->scale(xpixels=>150,ypixels=>160,qtype=>"mixing") or die $img->errstr;
$thumb->write(file => "test1.png") or die $thumb->errstr;
$thumb = $thumb->convert(preset=>"noalpha") or die $thumb->errstr;
$thumb->write(file => "test2.png") or die $thumb->errstr;
