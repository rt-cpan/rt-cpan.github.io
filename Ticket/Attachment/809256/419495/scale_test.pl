#!/usr/bin/perl
use strict;
use warnings;
use Imager;
use Image::Imlib2;

my ($width, $height, $x, $y) = (100, 100, 0, 0);

my $iref = Imager->new();
$iref->read(file=>'allroad.jpg') or die $iref->errstr();
my $norm = $iref->scale(xpixels=>$width, ypixels=>$height, qtype=>'normal');
my $mix = $iref->scale(xpixels=>$width, ypixels=>$height, qtype=>'mixing');
$norm = $norm->crop(width=>$width, height=>$height, left=>$x, top=>$y);
$norm->write(file=>'allroad_imager_normal_100x100.jpg');
$mix = $mix->crop(width=>$width, height=>$height, left=>$x, top=>$y);
$mix->write(file=>'allroad_imager_mixing_100x100.jpg');

my $iref2 = Image::Imlib2->load('allroad.jpg');
## Imlib2 does not keep aspect ratio by default except when one dim is 0
if ($iref2->height > $iref2->width) {
	$iref2 = $iref2->create_scaled_image($width, 0);
} else {
	$iref2 = $iref2->create_scaled_image(0, $height);
}
$iref2 = $iref2->crop($x, $y, $width, $height);
$iref2->save('allroad_imlib2_100x100.jpg');

## EOF
