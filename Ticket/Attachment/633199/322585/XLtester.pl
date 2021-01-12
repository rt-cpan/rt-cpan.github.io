#!d:\perl\bin -s

use strict;
use Spreadsheet::ParseExcel;

my $XLfile = 'test.xls';

print "Starting to parse $XLfile...\n";

my $workbook = Spreadsheet::ParseExcel::Workbook->Parse($XLfile);

