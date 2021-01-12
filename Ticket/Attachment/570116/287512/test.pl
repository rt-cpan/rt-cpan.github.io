#!/usr/bin/perl

use strict;
use warnings;

use Spreadsheet::ParseExcel::Simple;

my $file = 'test.xls';
my $xls = Spreadsheet::ParseExcel::Simple->read($file);
for my $sheet ($xls->sheets) {
  print "START OF SHEET\n";
  while ($sheet->has_data) {
    my @data = $sheet->next_row;
    print join ('|', @data), "\n";
  }
}
