#!/usr/bin/perl

use Spreadsheet::WriteExcel;
use LWP::Simple;

# Get us an image to use
unless( -r 'example.png'){
	print STDERR "Downloading example image\n";
	getstore('http://www.google.com/intl/en_ALL/images/srpr/logo1w.png', 'example.png');
}

my $workbook = new Spreadsheet::WriteExcel( "example.xls" );

my $page_one = $workbook->add_worksheet('Normal');
$page_one->insert_image( 'B2', 'example.png' );

my $page_two = $workbook->add_worksheet('Resize later');
$page_two->insert_image( 'B2', 'example.png' );
$page_two->set_row( '3:3', 200 );

my $page_three = $workbook->add_worksheet('Resize earlier');
$page_three->set_row( '3:3', 200 );
$page_three->insert_image( 'B2', 'example.png' );

my $page_four = $workbook->add_worksheet('Resize column');
$page_four->set_column( 'C:C', 20 );
$page_four->insert_image( 'B2', 'example.png' );


