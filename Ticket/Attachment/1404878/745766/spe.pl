#!/usr/bin/env perl

use strict;
use warnings;
use open qw/:std :locale/;
use Spreadsheet::ParseExcel;

my $b = shift;
my $w = Spreadsheet::ParseExcel->new()->parse( $b )->worksheet(0);

for my $row ( 0 .. ($w->row_range)[1] ) {
    for my $col ( 0 .. ($w->col_range)[1] ) {
        my $cell = $w->get_cell($row, $col);
        print $cell->value . ' ' if $cell;
    }
    print "\n";
}
