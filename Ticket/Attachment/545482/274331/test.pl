use strict;
use Spreadsheet::ParseExcel;

my $file = $ARGV[0] || "test.xls";
print STDERR "Spreadsheet::ParseExcel::Workbook->Parse($file)\n";
my $excel = Spreadsheet::ParseExcel::Workbook->Parse($file);
