#!/usr/bin/perl

use strict;
 
use Imager::Font;
use Graphics::Framebuffer;
use List::Util qw(min max shuffle);
use Time::HiRes qw(sleep time);
use Data::Dumper::Simple; $Data::Dumper::Sortkeys=1;
 
$|++;
 
my $file = 1;
my $arg = join(' ', @ARGV);
my $new_x;
my $new_y;
my $F;
my $dev = 1;
my $XX = 320;
my $YY = 240;
 
$F = Graphics::Framebuffer->new('FB_DEVICE' => "/dev/fb$dev", 'FILE_MODE' => $file, 'SHOW_ERRORS' => 1, 'SPLASH' => 0);

$F->cls();

#create some text
my $text_bb = $F->ttf_print({
    'x'            => 100,
    'y'            => 100, 
    'height'       => 20,
    'wscale'       => 1,   # Scales the width.  1 is normal
    'color'        => 'FFFFFFF', # Hex value of color 00-FF (RRGGBBAA)
    'text'         => 'Hello world',
    'font_path'    => '/usr/share/fonts/truetype/msttcorefonts',
    'face'         => 'Arial.ttf',
    'bounding_box' => 1,
    'antialias'    => 1
});
 
# Draw some reference lines
$F->set_color({ 'red' => int(0), 'green' => int(255), 'blue' => int(255) });
$F->line({'x' => 0, 'y' => 80, 'xx' => 319, 'yy' => 80, 'pixel_size' => 1});
$F->line({'x' => 0, 'y' => 90, 'xx' => 319, 'yy' => 90, 'pixel_size' => 1});
$F->line({'x' => 0, 'y' => 100, 'xx' => 319, 'yy' => 100, 'pixel_size' => 1});
$F->line({'x' => 0, 'y' => 110, 'xx' => 319, 'yy' => 110, 'pixel_size' => 1});


# Draw the True Type font - notice that it is the Y + $text_bb->{global_decent} even though the text decent is 0 with this string 
$F->ttf_print($text_bb);

#Dump out some diag info
my $pfont = "/usr/share/fonts/truetype/msttcorefonts/Arial.ttf";

my $font = Imager::Font->new( 'file' => $pfont, 'color' => 'FFFFFFFF', 'size' => 20);
my $font_bb = $font->bounding_box('string' => 'Hello world', 'canon' => 1, 'size' => 20, 'sizew' => 20);

my $start = $font_bb->start_offset;
my $end = $font_bb->end_offset;
my $gdescent = $font_bb->global_descent;
my $gascent = $font_bb->global_ascent;
my $ascent = $font_bb->ascent;
my $descent = $font_bb->descent;
my $total_width = $font_bb->total_width;
my $advance_width = $font_bb->advance_width;
my $font_height = $font_bb->font_height;
my $text_height = $font_bb->text_height;

print STDERR "Start        : $start\n";
print STDERR "End          : $end\n";
print STDERR "GDescent     : $gdescent\n";
print STDERR "GAscent      : $gascent\n";
print STDERR "Descent      : $descent\n";
print STDERR "Ascent       : $ascent\n";
print STDERR "Total_width  : $total_width\n";
print STDERR "Advance_width  : $advance_width\n";
print STDERR "Font Height  : $font_height\n";
print STDERR "Text Height  : $text_height\n";

print STDERR Dumper($text_bb);
