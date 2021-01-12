#!/usr/bin/perl

use Spreadsheet::XLSX;

my $Excel = Spreadsheet::XLSX->new('bug_space.xlsx');


my ($Data1) = grep { $_->{Name} eq 'Data1' } @{ $Excel->{Worksheet} || [] };
my ($Data2) = grep { $_->{Name} eq 'Data2' } @{ $Excel->{Worksheet} || [] };


print "Values for A2:\n";
print "Data1: '" . $Data1->{Cells}->[1]->[0]->{Val} . "'\n";
print "Data2: '" . $Data2->{Cells}->[1]->[0]->{Val} . "'\n\n";

print "Values for A3 (ERROR HERE):\n";
print "Data1: '" . $Data1->{Cells}->[2]->[0]->{Val} . "'\n";
print "Data2: '" . $Data2->{Cells}->[2]->[0]->{Val} . "'\n\n";

print "Values for A4:\n";
print "Data1: '" . $Data1->{Cells}->[3]->[0]->{Val} . "'\n";
print "Data2: '" . $Data2->{Cells}->[3]->[0]->{Val} . "'\n\n";

1;