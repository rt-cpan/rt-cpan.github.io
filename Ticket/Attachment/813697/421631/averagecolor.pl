#!/usr/bin/perl -w
use strict;
use Getopt::Long;

my $OUTFILE;
my $result=GetOptions(
    "output=s"=>\$OUTFILE,   # Output filename
    );

if (@ARGV!=1 and !defined $OUTFILE) {
  die("Usage: $0 -o outfile infile\n".
      "  This program reads the input file(s) and writes the output file.\n");
}

my $INFILE=$ARGV[0];

use Spreadsheet::ParseExcel;
my %data;
my @ws;
my $parser   = Spreadsheet::ParseExcel->new();
my $workbook = $parser->Parse($INFILE);
foreach my $worksheet ( $workbook->worksheets() ) {
  push @ws,$worksheet->{Name};
  my ( $row_min, $row_max ) = $worksheet->row_range();
  my ( $col_min, $col_max ) = $worksheet->col_range();
  foreach my $row ( $row_min .. $row_max ) {
    foreach my $col ( $col_min .. $col_max ) {
      my $cell = $worksheet->get_cell( $row, $col );
      next unless $cell;
      next unless $cell->unformatted();
      $data{$worksheet->{Name}}[$row][$col]=$cell->unformatted();
    }
  }
}

use Data::Dumper;
print Dumper(%data);
exit 0;

use Spreadsheet::WriteExcel;
$workbook = Spreadsheet::WriteExcel->new($OUTFILE);
for my $wst (@ws) {
  my $worksheet = $workbook->add_worksheet($wst);
  my @rows=@{$data{$wst}};
  for (my $row=0;$row<@rows;$row++) {
    next unless defined $rows[$row];
    my @cols=@{$rows[$row]};
    for (my $col=0;$col<@cols;$col++) {
      next unless defined $data{$wst}[$row][$col];
      $worksheet->write($row,$col,$data{$wst}[$row][$col]);
    }
  }
  print "----\n";
}
