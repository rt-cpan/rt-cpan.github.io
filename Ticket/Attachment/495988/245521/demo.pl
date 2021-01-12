#!/usr/bin/perl

use PDF::API2;
use PDF::Table;

my $pdf = PDF::API2->new(-file => "demo.pdf");

my $page = $pdf->page;

$page->mediabox ('A4');	# 842x595

my $mail_data =[
    ["E-mail", ""],
    ["Test 1",
     'chris@foo.bar'],
    ["Test 2",
     'chris@fooo.bar'],
    ["Test 3",
     'chris@foooo.bar'],
    ["Test 4",
     'chris@fooooo.bar'],
    ["Test 5",
     'chris@foooooo.bar'],
    ["Test 6",
     'chris@fooooooo.bar'],
    ["Test 7",
     'chris@foooooooo.bar'],
    ["Test 8",
     'chris@fooooooooo.bar'],
    ["Test 9",
     'chris@foooooooooo.bar'],
    ["Test 10",
     'chris@fooooooooooo.bar'],
    ];

# build the table layout
my $y = addTable($pdf, $page, $mail_data, 840);

$pdf->save;
$pdf->end();

sub addTable {
    my ($pdf, $page, $some_data, $y) = @_;

    my $pdftable = new PDF::Table;

    # build the table layout
    my ($end, $pages, $new_y) = $pdftable->table($pdf,
						 $page,
						 $some_data,
						 x => 30,
						 w => 535,
						 start_y => $y,
						 next_y  => 700,
						 start_h => 300,
						 next_h  => 500,
						 # some optional params
						 padding => 5,
						 padding_right => 10,
						 background_color_odd  => "white",
						 background_color_even => "white",
						 header_props          => {
						     bg_color   => "darkblue",
						     font => $pdf->corefont( 'Helvetica-Bold', -encoding => 'latin1' ),
						     font_size  => 14,
						     font_color => "white",
						     repeat     => 1,
						 },
						 column_props          => [
						     {
							 min_w => 250,
							 bg_color   => "white",
							 font => $pdf->corefont( 'Helvetica', -encoding => 'latin1' ),
							 font_size  => 12,
							 font_color => "black",
						     },
						     {
							 min_w => 535-250,
							 bg_color   => "white",
							 font => $pdf->corefont( 'Helvetica', -encoding => 'latin1' ),
							 font_size  => 12,
							 font_color => "black",
						     },
						 ],
	);

    return $new_y;
}
