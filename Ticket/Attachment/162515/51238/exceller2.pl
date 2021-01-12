use utf8;
use strict;
use warnings;

use Spreadsheet::WriteExcel;

my $outfile = "exceller.xls";

my $wbk = Spreadsheet::WriteExcel->new( $outfile );
my $wks = $wbk->add_worksheet( 'Test' );

my $row = 1;
   for(my $i =0; $i < 11; $i++) {
	$wks->write( $row, 0, $i );
	$row++;
    }

$wks->write( 1, 2, "=COUNT(A:A)" );
$wks->write( 1, 3, "=COUNTIF(A:A,5)" );

$wks->write( 2, 1, "5" );
$wks->write( 1, 4, "=COUNTIF(A:A,B3)" );


# Workaround for formula parsing problem.
my $countif = $wks->store_formula('=COUNTIF(A:A,B3)');
$wks->repeat_formula(1, 5, $countif, undef, '_ref2d' => '_ref2dV');


$wks->activate;
$wbk->close;