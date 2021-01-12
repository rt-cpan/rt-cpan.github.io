#!/usr/bin/perl
use strict;
use Spreadsheet::ParseExcel;
use Data::Dumper;

my $parser   = Spreadsheet::ParseExcel->new();
my $workbook = $parser->Parse('test.xls');

print Dumper $workbook;
