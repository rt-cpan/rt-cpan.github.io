use strict;
use Imager;
use Imager::Color;

my $image = Imager->new(xsize => 300, ysize => 300);
$image->box(color => 'red', fill => 'red', xmin => 100, ymin => 100, xmax => 200, ymax => 200, filled => 1) or die $image->errstr;
my $color = Imager::Color->new(0,0,100,150);
$image->box(color => $color, fill => $color, xmin => 150, ymin => 150, xmax => 250, ymax => 250, filled => 1) or die $image->errstr;
$image->write(file => '/tmp/alpha-test.png') or die $image->errstr;
