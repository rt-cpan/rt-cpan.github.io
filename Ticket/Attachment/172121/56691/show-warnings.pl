#!/usr/bin/perl -w

use File::Basename;
use lib $ENV{HOME} . "/.perl";
use Spreadsheet::ParseExcel;

my $oBook = Spreadsheet::ParseExcel::Workbook->Parse('gives-warnings.xls');
