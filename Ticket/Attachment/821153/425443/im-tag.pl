#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use Imager;

my $img = Imager->new;
$img->read( file => 'test.jpg' ) or die;
my $tag_value = 'Test Value';
$img->settag( name => 'exif_model', value => $tag_value ) or die;
is( $img->tags( name=>'exif_model'), $tag_value, 'exif data in memory' );

my $jpg;
$img->write( data => \$jpg, type => 'jpeg' ) or die $img->errstr;
my $im2 = Imager->new;
$im2->read( data => $jpg ) or die $im2->errstr;
is( $im2->tags( name=>'exif_model'), $tag_value, '... read after write' );

