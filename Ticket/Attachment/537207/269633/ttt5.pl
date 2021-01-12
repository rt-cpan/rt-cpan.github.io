#!/usr/bin/perl

use strict;
use warnings;

use Image::ExifTool;

my $data_ref = read_file('x_7171d725.jpg');

my $exifTool = new Image::ExifTool;

$exifTool->ExtractInfo( $data_ref, { FastScan => 1 } );


sub read_file {
        my ($file) = @_;

        open(IN, $file) or die "Can't open $file: $!";
        local $/;
        my $content = <IN>;
        close IN;

        return \$content;
}
