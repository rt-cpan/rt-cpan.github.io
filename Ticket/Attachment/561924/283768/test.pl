#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;
use OpenOffice::OODoc;

my $content = odfDocument( file => 'test.ods', part => 'content');
#my $styles = $content;
my $styles = odfDocument( file => $content, part => 'styles');



print "################## Table #################\n\n";
my $table = $content->getTable(0);
my $stylename = $content->getStyle($table);
print $stylename."\n";
my $styleobjekt = $styles->getStyleElement($stylename);
print $styleobjekt."\n";
my %styleproperties = $styles->styleProperties($styleobjekt);
print Dumper(\%styleproperties)."\n";

print "################## Row #################\n\n";
my $row = $content->getRow(0,1);
$stylename = $content->getStyle($row);
print $stylename."\n";
$styleobjekt = $styles->getStyleElement($stylename);
print $styleobjekt."\n";
%styleproperties = $styles->styleProperties($styleobjekt);
print Dumper(\%styleproperties)."\n";

print "################## Column #################\n\n";
my $column = $content->getColumn(0,1);
print $column."\n";
$stylename = $content->getStyle($column);
print $stylename."\n";
$styleobjekt = $styles->getStyleElement($stylename);
print $styleobjekt."\n";
%styleproperties = $styles->styleProperties($styleobjekt);
print Dumper(\%styleproperties)."\n";

print "################## Cell #################\n\n";
my $cell = $content->getCell(0,1,1);
$stylename = $content->getStyle($cell);
print $stylename."\n";
$styleobjekt = $styles->getStyleElement($stylename);
print $styleobjekt."\n";
%styleproperties = $styles->styleProperties($styleobjekt);
print Dumper(\%styleproperties)."\n";
