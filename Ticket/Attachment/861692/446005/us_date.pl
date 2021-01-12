use strict;
use Data::Dump qw( dump );

require Spreadsheet::ParseExcel;

my $oBook = Spreadsheet::ParseExcel::Workbook->Parse('us_date.xls');
#get the cell B2
foreach my $i (1..5) {
	my $oCell = $oBook->{Worksheet}[0]{Cells}[1][$i];
	#get the text format string for this cell (its index)
	my $FmtIdx = $oCell->get_format()->{FmtIdx};
	my $format_string = $oBook->{FormatStr}{$FmtIdx};
	print "Format index $FmtIdx, \nwhich is defined as '$format_string', \n".
		"but is detected as type: ".$oCell->type()."\n";
	my $alt_regexp = qr{^(?:\[\$\-\d+\])?[dmyDMY][;,-\s\\/dmyDMY\.]*(?:;\@)?$};
	print "\nWith regexp: $alt_regexp \nthe format is detected as '".
		($format_string =~ $alt_regexp ? "Date" : "Numeric")."'\n\n\n";
}



