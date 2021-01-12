use strict;
use warnings;

use Spreadsheet::ParseExcel::SaveParser;

my $parser   = new Spreadsheet::ParseExcel::SaveParser;
my $wb = $parser->Parse("example.xls");
my $ws = $wb->{Worksheet}[0];

$ws->AddCell( 0, 0, 10 );

$wb->SaveAs( "example_output.xls" );
