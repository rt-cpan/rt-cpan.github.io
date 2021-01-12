#!/usr/bin/perl -w

###############################################################################
#
# Simple example of how to embed an externally created chart into a
# Spreadsheet:: WriteExcel worksheet.
#
#
# This example adds a line chart extracted from the file Chart1.xls as follows:
#
#   perl chartex.pl -c=demo5 Chart5.xls
#
#
# reverse('©'), September 2007, John McNamara, jmcnamara@cpan.org
#

use strict;
use Spreadsheet::WriteExcel;

my $workbook  = Spreadsheet::WriteExcel->new('demo5mjl.xls');

# Add some extra formats to cover formats used in the charts.
my $chart_font_1 = $workbook->add_format(font_only => 1);
my $chart_font_2 = $workbook->add_format(font_only => 1);

#--------------------------------------------
# create first worksheet
#--------------------------------------------

my $worksheet = $workbook->add_worksheet( 'Sheet1' );

# Embed a chart extracted using the chartex utility
$worksheet->embed_chart('D3', 'demo501.bin');

# Link the chart to the worksheet data using a dummy formula.
$worksheet->store_formula('=Sheet1!A1');

# Add data to range that the chart refers to.
my @nums    = (0, 1, 2, 3, 4,  5,  6,  7,  8,  9,  10 );
my @squares = (0, 1, 4, 9, 16, 25, 36, 49, 64, 81, 100);

$worksheet->write_col('A1', \@nums   );
$worksheet->write_col('B1', \@squares);

#--------------------------------------------
# create second worksheet
#--------------------------------------------

$worksheet = $workbook->add_worksheet( 'Sheet2' );

# Embed a chart extracted using the chartex utility
$worksheet->embed_chart('D3', 'demo501.bin');

# Link the chart to the worksheet data using a dummy formula.
$worksheet->store_formula('=Sheet2!A1');


# Add data to range that the chart refers to.
@nums    = (0, 1, 2, 3, 4,  5,  6,  7,  8,  9,  10 );
@squares = (100, 101, 104, 109, 1016, 1025, 1036, 1049, 1064, 1081, 10100);

$worksheet->write_col('A1', \@nums   );
$worksheet->write_col('B1', \@squares);

#--------------------------------------------
# create third worksheet
#--------------------------------------------

$worksheet = $workbook->add_worksheet( 'Sheet3' );

# Embed a chart extracted using the chartex utility
$worksheet->embed_chart('D3', 'demo501.bin');

# Link the chart to the worksheet data using a dummy formula.
$worksheet->store_formula('=Sheet3!A1');


# Add data to range that the chart refers to.
@nums    = (0, 1, 2, 3, 4,  5,  6,  7,  8,  9,  10 );
@squares = (200, 201, 204, 209, 2016, 2025, 2036, 2049, 2064, 2081, 20100);

$worksheet->write_col('A1', \@nums   );
$worksheet->write_col('B1', \@squares);

__END__
