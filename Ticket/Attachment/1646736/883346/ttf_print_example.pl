#!/usr/bin/perl

use strict;
use Graphics::Framebuffer;
use List::Util qw(min max shuffle);
use Data::Dumper::Simple; $Data::Dumper::Sortkeys=1;
 
$|++;
 
my $file = 0;
my $new_x;
my $new_y;
my $F;
my $dev = 1;
my $XX  = 320;
my $YY  = 240;

$F = Graphics::Framebuffer->new('FB_DEVICE' => "/dev/fb$dev", 'FILE_MODE' => $file, 'SHOW_ERRORS' => 1, 'SPLASH' => 0); # ,'SIMULATED_X' => 320, 'SIMULATED_Y' => 240);
my $sinfo = $F->screen_dimensions();

my $F2 = Graphics::Framebuffer->new('FB_DEVICE' => "virtual", 'SHOW_ERRORS' => 1, 'SPLASH' => 0, 'VXRES' => $sinfo->{'width'}, 'VYRES' => $sinfo->{'height'}, 'COLOR_ORDER' => $sinfo->{'color_order'}); # ,'SIMULATED_X' => 320, 'SIMULATED_Y' => 240);

# clear the screen
$F->cls();

# build the text for button1 
my $button1_bb = $F2->ttf_print({
                                       'x'            => 40,
                                       'y'            => 40, 
                                       'height'       => 30,
                                       'wscale'       => 1,   
                                       'color'        => 'FF0000FF',
                                       'text'         => 'Line 1',
                                       'font_path'    => '/usr/share/fonts/truetype/msttcorefonts',
                                       'face'         => 'Arial.ttf',
                                       'bounding_box' => 1,
                                       'antialias'    => 0
                                   });

# build the text for line2 
my $button2_bb = $F2->ttf_print({
                                       'x'            => 80,
                                       'y'            => 70, 
                                       'height'       => 30,
                                       'wscale'       => 1,   
                                       'color'        => '00FF00FF',
                                       'text'         => 'Line 2',
                                       'font_path'    => '/usr/share/fonts/truetype/msttcorefonts',
                                       'face'         => 'Arial.ttf',
                                       'bounding_box' => 1,
                                       'antialias'    => 0
                                   });

# build the text for line3 - same as line 1, but wont print
my $button3_bb = $F2->ttf_print({
                                       'x'            => 40,
                                       'y'            => 230, 
                                       'height'       => 30,
                                       'wscale'       => 1,   
                                       'color'        => '0000FFFF',
                                       'text'         => 'Line 3',
                                       'font_path'    => '/usr/share/fonts/truetype/msttcorefonts',
                                       'face'         => 'Arial.ttf',
                                       'bounding_box' => 1,
                                       'antialias'    => 1
                                   });

# Set a colored box as a background
$F2->set_color({ 'red' => 255, 'green' => 255, 'blue' => 25, 'alpha' => 255 });
$F2->rbox({ 'x' => 1, 'y' => 1, 'width' => $XX, 'height' => $YY, 'filled' => 1 });

# create the button1 and the text
$F2->ttf_print($button1_bb);
$F2->ttf_print($button2_bb);
$F2->ttf_print($button3_bb);
$F->blit_flip($F2);

# put the button in the active buttons array
# print STDERR Dumper($button1_bb);