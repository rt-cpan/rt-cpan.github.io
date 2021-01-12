#!/usr/bin/perl
use strict;
use 5.006;

use Getopt::Std;
use Locale::Recode;
use Spreadsheet::ParseExcel;
use Spreadsheet::ParseExcel::FmtUnicode;
use Text::CSV_XS;

our $VERSION = '1.06';

=head1 NAME

xls2csv - A script that recodes a spreadsheet's charset and saves as CSV.

=head1 DESCRIPTION

This script will recode a spreadsheet into a different character set
and output the recoded data as a csv file.

The script came about after many headaches from dealing with Excel spreadsheets
from clients that were being received in various character sets.

=head1 OPTIONS

	-x     : filename of the source spreadsheet
	-b     : the character set the source spreadsheet is in (before)
	-c     : the filename to save the generated csv file as
	-a     : the character set the csv file should be converted to (after)
	-q     : quiet mode
	-s     : print a list of supported character sets
	-h     : print help message
	-v     : get version information
	-W     : list worksheets in the spreadsheet specified by -x
	-w     : specify the worksheet name to convert (defaults to the first worksheet)

=head1 EXAMPLE USAGE

The following example will convert a spreadsheet that is in the WINDOWS-1252 character set (WinLatin1)
and save it as a csv file in the UTF-8 character set.

	xls2csv -x "1252spreadsheet.xls" -b WINDOWS-1252 -c "ut8csvfile.csv" -a UTF-8

This example with convert the worksheet named "Users" in the given spreadsheet.

	xls2csv -x "multi_worksheet_spreadsheet.xls" -w "Users" -c "users.csv" 

=head1 NOTES

The spreadsheet's charset (-b) will default to UTF-8 if not set.

If the csv's charset (-a) is not set, the CSV file will be created using the same charset as the spreadsheet.

=head1 REQUIRED MODULES

This script requires the following modules:

	Locale::Recode
	Unicode::Map
	Spreadsheet::ParseExcel
	Spreadsheet::ParseExcel::FmtUnicode (should be included with Spreadsheet::ParseExcel)
	Text::CSV_XS

=head1 CAVEATS

It probably will not work work with spreadsheets that use formulas.

A line in the spreadsheet is assumed to be blank if there is nothing in the first column.

Some users have reported problems trying to convert a spreadsheet while it was opened in a different application.
You should probably make sure that no other programs are working with the spreadsheet while you are converting it.

=cut

$Getopt::Std::STANDARD_HELP_VERSION = 1;

my %O;
getopts('x:b:c:a:qshvWw:', \%O);
HELP_MESSAGE() if !%O or $O{'h'};
VERSION_MESSAGE() if $O{'v'};

if ($O{'s'})
{
	print "\nThe following character sets are supported:\n\n";
	my $Supported = Locale::Recode->getSupported;
	foreach my $CharSet (sort @$Supported)
	{
		print "$CharSet\n";
	}
	print "\n";
	exit;
}

my $SourceFilename = $O{'x'} || die "The filename of the spreadsheet (-x) is required.";
my $SourceCharset = $O{'b'};
$SourceCharset = 'UTF-8' unless $SourceCharset;

unless ($O{'q'})
{
	print "Now reading \"$SourceFilename\" as $SourceCharset.\n";
}

my $XLS = new IO::File;
$XLS->open("< $SourceFilename") || die "Cannot open spreadsheet: $!";
my $Formatter = Spreadsheet::ParseExcel::FmtUnicode->new(Unicode_Map => $SourceCharset);
my $Book = Spreadsheet::ParseExcel::Workbook->Parse($XLS, $Formatter) || die "Can't read spreadsheet!";

if ($O{'W'}) 
{
	print "\nThe following " . ($Book->{SheetCount}>1 ? "$Book->{SheetCount} worksheets are" : "worksheet is")  . " defined in the spreadsheet:\n\n";
	foreach my $Sheet (@{$Book->{Worksheet}}) 
	{
		print "$Sheet->{Name}\n";
	}
	print "\n";
	exit;       
}

my $DestFilename = $O{'c'} || die "The filename to save the csv file as (-c) is required.";
my $DestCharset = $O{'a'};
$DestCharset = $SourceCharset unless $DestCharset;

my $Sheet;
if ($O{'w'}) 
{
	$Sheet = $Book->Worksheet($O{'w'});
	die "Invalid worksheet" if !defined $Sheet;
	unless ($O{'q'})
	{
		print qq|Converting the "$Sheet->{Name}" worksheet.\n|;
	}
}
else
{
	($Sheet) = @{$Book->{Worksheet}};
	if (!$O{'q'} && $Book->{SheetCount}>1)
	{
		print qq|Multiple worksheets found. Will convert the "$Sheet->{Name}" worksheet.\n|;
	}
}

open CSV, "> $DestFilename" || die "Cannot create csv file: $!" ;
binmode CSV;
my $Csv = Text::CSV_XS->new({
	'quote_char'  => '"',
	'escape_char' => '"',
	'sep_char'    => ',',
	'binary'      => 1,
});

my $Recoder;
if ($O{'a'})
{
	$Recoder = Locale::Recode->new(from=>$SourceCharset, to=>$DestCharset);
}

for ( my $Row = $Sheet->{MinRow} ; defined $Sheet->{MaxRow} && $Row <= $Sheet->{MaxRow} ; $Row++ )
{
	my @Row;
	for ( my $Col = $Sheet->{MinCol} ; defined $Sheet->{MaxCol} && $Col <= $Sheet->{MaxCol} ; $Col++ )
	{
		my $Cell = $Sheet->{Cells}[$Row][$Col];
		
		my $Value = "";
		if ($Cell)
		{
			$Value = $Cell->Value;
			if ($Value eq 'GENERAL')
			{
				# Sometimes numbers are read incorrectly as "GENERAL".
				# In this case, the correct value should be in ->{Val}.
				$Value = $Cell->{Val};
			}
			if ($O{'a'})
			{
				$Recoder->recode($Value);
			}
		}
		
		# We assume the line is blank if there is nothing in the first column.
		last if $Col == $Sheet->{MinCol} and !$Value;
		
		push(@Row, $Value);
	}
	
	next unless @Row;
	
	my $Status = $Csv->combine(@Row);
	
	if (!$O{'q'} and !defined $Status)
	{
		my $Error = $Csv->error_input();
		warn "ERROR FOUND!: $Error";
	}
	
	if (defined $Status)
	{
		my $Line = $Csv->string();
		print CSV "$Line\n";
	}
}

close CSV;
$XLS->close;

unless ($O{'q'})
{
	print "The spreadsheet has been converted to $DestCharset and saved as \"$DestFilename\".\n";
}

sub VERSION_MESSAGE
{
	print << "EOF";

This is xls2csv version $VERSION

Copyright (C) 2005 Ken Prows. All rights reserved.

This script is free software; you can redistribute it and\\or modify it under the same terms as Perl itself.

For help, use "xls2csv -h"

EOF
	exit;
}

sub HELP_MESSAGE
{
	print << "EOF";

xls2csv - Recode a spreadsheet's charset and save as CSV.

usage: xls2csv -x spreadsheet.xls [-w worksheet] [-b charset] [-c csvfile.csv] [-a charset] [-qshvW]

-x  : filename of the source spreadsheet
-b  : the character set the source spreadsheet is in (before)
-c  : the filename to save the generated csv file as
-a  : the character set the csv file should be converted to (after)
-q  : quiet mode
-s  : print a list of supported character sets
-h  : this help message
-v  : get version information
-W  : list worksheets in the spreadsheet specified by -x
-w  : specify the worksheet name to convert (defaults to the first worksheet)

example: xls2csv -x "spreadsheet.xls" -b WINDOWS-1252 -c "csvfile.csv" -a UTF-8

More detailed help is in "perldoc xls2csv"

EOF
	exit;
}

=head1 AUTHOR

Ken Prows (perl@xev.net)

=head1 COPYRIGHT

Copyright (C) 2005 Ken Prows. All rights reserved.

This script is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=cut
