#!/usr/bin/env perl
use utf8;
use warnings;
use strict;
use lib 'lib';
use Cairo;
use Pango;
use AIINK::Pango;

use constant {
    text_offset => 80,
    width => 900,
    height => 2000 ,
};

sub draw_note;
sub draw_extents;

# GistID: 

my $surface = Cairo::ImageSurface->create ('argb32', width , height );
my $cr = Cairo::Context->create ($surface);

my $dpi = 600;
# $cr->scale( 1 / 25.4 * $dpi, 1 / 25.4 * $dpi );
$cr->scale( 3, 3 );
$cr->translate( 1 , 1 );
$cr->set_line_width(0.5);
$cr->set_font_size(5);

my @fonts = (
    'Folio Md BT',
    'Souvenir Lt BT',
    'News701 BT',
    'News701 BT',
    'Apple LiGothic',
    'AR Roman1 Medium',
    'AR Roman1 Heavy',
    'AR RGothic1 Bold',
);

for my $fontname ( @fonts ) {
    my $layout = Pango::Cairo::create_layout ($cr);
    $layout->set_text("orz123");
    my $desc = Pango::FontDescription->from_string("$fontname Normal 12");
    $desc->set_absolute_size( 48 * Pango->scale() );

    my $lang = Pango::Language->from_string( 'en_US' );
    $layout->set_font_description ($desc);

    Pango::Cairo::show_layout($cr, $layout);
    # AIINK::Pango->draw_extents($cr, $layout, $desc, 'en_US');
    AIINK::Pango->draw_extents( $cr, $layout, $desc, $lang );
    $cr->translate( 0 , text_offset );
}

$cr->show_page();
$surface->write_to_png ('pango-extents-en.png');
system('open','pango-extents-en.png');
