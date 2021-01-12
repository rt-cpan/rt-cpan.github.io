#!/usr/bin/perl -w

use strict;
use utf8;
use Spreadsheet::ParseExcel;

my $parser=Spreadsheet::ParseExcel->new();
my $doc=$parser->Parse('x.xls');
my $sheet=$doc->Worksheet('Sheet');

my $c;

$c=$sheet->get_cell(0,0);
print "A1: >".$c->unformatted()."< >".$c->value()."<\n";

$c=$sheet->get_cell(1,0);
print "A2: >".$c->unformatted()."< >".$c->value()."<\n";

