#!/usr/bin/env perl
use utf8;
use warnings;
use strict;
use lib 'lib';
use Cairo;
use Pango;

use constant {
    text_offset => 20,
    width => 900,
    height => 2000 ,
};

sub draw_note;
sub draw_extents;

# take logical, ink (pango::rectangle)
sub ascent  { -$_[0]->{y} }

# take logical,ink  (pango::rectangle)
sub descent { $_[0]->{y} + $_[0]->{height} }

# GistID: 

my $surface = Cairo::ImageSurface->create ('argb32', width , height );
my $cr = Cairo::Context->create ($surface);

$cr->scale( 21 , 21);
$cr->translate( 1 , 1 );
$cr->set_line_width(0.1);
$cr->set_font_size(2);

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
    $layout->set_text("Orz");
    my $desc = Pango::FontDescription->from_string("$fontname Normal 12");
    $desc->set_absolute_size( 12 * Pango->scale() );

    my $lang = Pango::Language->from_string( 'en_US' );
    $layout->set_font_description ($desc);

    Pango::Cairo::show_layout($cr, $layout);
    draw_extents( $cr, $layout, $desc, $lang );
    $cr->translate( 0 , text_offset );
}

$cr->show_page();
$surface->write_to_png ('pango-extents-en.png');
system('open','pango-extents-en.png');

sub draw_extents {
    my ( $cr, $layout, $desc, $lang ) = @_;
    my $layoutline = $layout->get_line(0);
    my $fontmap = Pango::Cairo::FontMap->new_for_font_type('ft');
    my $context = $fontmap->create_context();
    my $font    = $context->load_font($desc);
    Pango::Cairo::update_context( $cr, $context );
    Pango::Cairo::update_layout( $cr, $layout );
    my ( $ink, $logical ) = $layoutline->get_pixel_extents();
    my $metrics = $font->get_metrics($lang);
    my $ascent =  $metrics->get_ascent() / Pango->scale;
    my $descent =  $metrics->get_descent()/ Pango->scale;
    my $baseline_y = $layout->get_baseline() / Pango->scale;

    # logical rectangle
    $cr->save;
    $cr->set_source_rgba( 0, 0, 1 , 1 );
    
    $cr->rectangle( $logical->{x} , $baseline_y - ascent($logical) , 
                $logical->{width}, $logical->{height} );
    $cr->stroke;
    draw_note( $cr, 'logical', 100 , 0 );
    $cr->restore;

    # ink rectangle
    $cr->save;
    $cr->set_source_rgba( 0, 0, 0, 0.4 );
    $cr->rectangle( $ink->{x} , $baseline_y - ascent($ink) , $ink->{width}, $ink->{height} );
    $cr->stroke;
    draw_note( $cr, 'ink', $ink->{x}, $baseline_y - ascent($ink) );
    $cr->restore;

    # draw baseline
    $cr->save;
    $cr->set_source_rgba( 1 , 0, 0 , 1 );
    $cr->move_to( 0 , $baseline_y  );
    $cr->line_to( $logical->{width} + 20 , $baseline_y );
    $cr->stroke;
    draw_note($cr, 'baseline' , $logical->{width} + 2 , $baseline_y );
    $cr->restore;


    # draw descent line
    $cr->save;
    $cr->set_source_rgba( 1 , 0, 0 , 0.5 );
    $cr->move_to( 0 , $baseline_y + $descent );
    $cr->line_to( $logical->{width} , $baseline_y + $descent );
    $cr->stroke;
    draw_note($cr, 'descent line' , 0 , $baseline_y + $descent );
    $cr->restore;

    # draw ascent line
    $cr->save;
    $cr->set_source_rgba( 1 , 0, 0 , 0.5 );
    $cr->move_to( 0 , $baseline_y - $ascent );
    $cr->line_to( $logical->{width} , $baseline_y - $ascent );
    $cr->stroke;
    draw_note($cr, 'ascent line' , 0 , $baseline_y - $ascent );
    $cr->restore;
}


sub draw_note {
    my ( $cr, $text, $x, $y ) = @_;
    $cr->save;
    $cr->move_to( $x, $y );
    $cr->show_text($text);
    $cr->stroke;
    $cr->restore;
}
