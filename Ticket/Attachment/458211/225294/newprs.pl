#instructions: run with perl newprs.pl test.xls
# you should get a substr outside of string error
# now open the excel file, go to the entry in the notes collumn, line 2 and just get
# rid of the first character(a greek terminal s) , the one before the :
#run again and behold! it runs fine

# Bug reproduced with perl v5.8.7(activestate build 815), also same on linux
#


#!/usr/bin/perl -w

use Spreadsheet::ParseExcel;

use strict;

my $filename = shift || "test.xls";

my $e = new Spreadsheet::ParseExcel;
my $eBook = $e->Parse($filename);

my $sheets = $eBook->{SheetCount};
my ($eSheet, $sheetName);

foreach my $sheet (0 .. $sheets - 1) {
    $eSheet = $eBook->{Worksheet}[$sheet];
    $sheetName = $eSheet->{Name};
    print "Worksheet $sheet: $sheetName\n";
    next unless (exists ($eSheet->{MaxRow}) and
    (exists ($eSheet->{MaxCol})));
    foreach my $row ($eSheet->{MinRow} .. $eSheet->{MaxRow}) {
        foreach my $column ($eSheet->{MinCol} .. $eSheet->{MaxCol}) {
            next unless (defined $eSheet->{Cells}[$row][$column]);
            print $eSheet->{Cells}[$row][$column]->Value . " ";
        }
        print "\n";
    }
}