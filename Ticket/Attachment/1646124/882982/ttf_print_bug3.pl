#!/usr/bin/perl

use strict;
use Graphics::Framebuffer;
use List::Util qw(min max shuffle);
use Data::Dumper::Simple; $Data::Dumper::Sortkeys=1;
 
$|++;
 
my $file = 1;
my $new_x;
my $new_y;
my $F;
my $dev = 1;
my $XX = 320;
my $YY = 240;
 
$F = Graphics::Framebuffer->new('FB_DEVICE' => "/dev/fb$dev", 'FILE_MODE' => $file, 'SHOW_ERRORS' => 1, 'SPLASH' => 0);

# clear the screen
$F->cls();

# build the text for button1 
my $button1_bb = $F->ttf_print({
    'x'            => 40,
    'y'            => 40, 
    'height'       => 30,
    'wscale'       => 1,   
    'color'        => 'FF00FFFF',
    'text'         => 'Line 1',
    'font_path'    => '/usr/share/fonts/truetype/msttcorefonts',
    'face'         => 'Arial.ttf',
    'bounding_box' => 1,
    'antialias'    => 1
});

# build the text for line2 
my $button2_bb = $F->ttf_print({
    'x'            => 80,
    'y'            => 70, 
    'height'       => 30,
    'wscale'       => 1,   
    'color'        => '555575FF',
    'text'         => 'Line 2',
    'font_path'    => '/usr/share/fonts/truetype/msttcorefonts',
    'face'         => 'Arial.ttf',
    'bounding_box' => 1,
    'antialias'    => 1
});

# build the text for line3 - same as line 1, but wont print
my $button3_bb = $F->ttf_print({
    'x'            => 40,
    'y'            => 230, 
    'height'       => 30,
    'wscale'       => 1,   
    'color'        => 'FF00FFFF',
    'text'         => 'Line 1',
    'font_path'    => '/usr/share/fonts/truetype/msttcorefonts',
    'face'         => 'Arial.ttf',
    'bounding_box' => 1,
    'antialias'    => 1
});

# Set a colored box as a background
$F->set_color({ 'red' => 255, 'green' => 255, 'blue' => 25, 'alpha' => 255 });
$F->rbox({ 'x' => 1, 'y' => 1, 'width' => 320, 'height' => 240, 'filled' => 1 });

# create the button1 and the text
$F->ttf_print($button1_bb);
$F->ttf_print($button2_bb);
$F->ttf_print($button3_bb);
# put the button in the active buttons array
print STDERR Dumper($button1_bb);

