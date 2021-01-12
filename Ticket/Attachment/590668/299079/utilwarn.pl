#!/usr/bin/perl

use warnings;
use strict;
use Spreadsheet::ParseExcel;
use Carp qw(cluck);

my ($c, $w) = (0, 0);

$SIG{__WARN__} = sub { cluck $_[0]; $w++; };

my $filename = "fmtest.xls";

my $parser = Spreadsheet::ParseExcel->new(CellHandler => \&parser_cb, NotSetCell => 1);
my $workbook = $parser->Parse($filename) or die "Could not open file!";
my @sheets = $workbook->worksheets();
printf "Workbook contains %d sheets\n", scalar @sheets;
print "Completed with $c cells and $w warnings\n";

exit 0;

sub parser_cb
{
	my ($workbook, $sheet_index, $row, $col, $cell) = @_;
	my $v = $cell->value();
	print "($row, $col) : $v\n";
	$c++;
}
