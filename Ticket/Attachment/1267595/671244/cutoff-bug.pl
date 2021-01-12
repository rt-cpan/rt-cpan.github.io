#!/usr/bin/env perl

use strict;
use warnings;

use Imager;

sub write_image {
    my ($file, $aa) = @_;

    my $img = Imager->new(xsize => 130, ysize => 24);
    $img->box(filled => 1, color => '334455');

    my $text = 'Some Text';
    my $font = Imager::Font->new(file => 'bogstandard.ttf', color => 'ffffff', size => 18);
    my $bbox = $font->bounding_box(string => $text, canon => 1);
    $img->string(
        text  => $text,
        font  => $font,
        x     => ($img->getwidth() - $bbox->total_width()) / 2,
        y     => ($img->getheight() + $bbox->global_ascent() + $bbox->global_descent()) / 2,
        aa    => $aa,
    );

    $img->write(file=> $file);
}

write_image('cutoff-bug-without-aa.png', 0);
write_image('cutoff-bug-with-aa.png', 1);
