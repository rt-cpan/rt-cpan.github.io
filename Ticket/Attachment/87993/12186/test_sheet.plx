#!/usr/bin/perl -w
use strict;

use Spreadsheet::WriteExcel;

my $file1  = 'test1.xls';
my $file2  = 'test2.xls';
my $xls    = Spreadsheet::WriteExcel->new($file1);
my $sheet1 = get_excel_sheet1($xls);
my $sheet2 = get_excel_sheet2($file2);

# NB: only $sheet1 will have the 'bar' row written (dunno why)
for my $s ($sheet1, $sheet2) {
    $s->write_row(1, 0, ['bar']);
}

## Functions ##

sub get_excel_sheet1 {
    my ($xls) = @_;
    my $sheet = $xls->addworksheet();
    $sheet->write_row(0, 0, ['foo']);
    return $sheet;
}

sub get_excel_sheet2 {
    my ($file_name) = @_;
    my $xls    = Spreadsheet::WriteExcel->new($file_name);
    my $sheet  = $xls->addworksheet();
    $sheet->write_row(0, 0, ['foo']);
    return $sheet;
}

