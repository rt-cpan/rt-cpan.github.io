#!/usr/bin/perl -w


use strict;
use Spreadsheet::WriteExcel;

# Create a new workbook called simple.xls and add a worksheet
my $workbook  = Spreadsheet::WriteExcel->new('a_simple.xls');
my $worksheet1 = $workbook->add_worksheet();
my $worksheet2 = $workbook->add_worksheet();
my $worksheet3 = $workbook->add_worksheet();

populate_worksheet($worksheet1);
populate_worksheet($worksheet2);
populate_worksheet($worksheet3);

#Sheet 1,2,3
#hide most colums
my $width  = undef;
my $format = undef;
my $hidden = 1;
$worksheet1->set_column(1, 5, $width, $format, $hidden);
$worksheet2->set_column(1, 5, $width, $format, $hidden);
$worksheet3->set_column(1, 5, $width, $format, $hidden);

#Sheet 1
#unhide one colum, no column width
$width  = undef;
$hidden = 0;
$worksheet1->set_column(3, 3, $width, $format, $hidden);


#Sheet 2
#unhide one colum, with any width defined
$width  = 5;
$hidden = 0;
$worksheet2->set_column(3, 3, $width, $format, $hidden);


#Sheet 3
#unhide one colum, with default width
$width  = 8.43;
$hidden = 0;
$worksheet3->set_column(3, 3, $width, $format, $hidden);


sub populate_worksheet {
	my ($ws) = @_;
	$ws->write(0, 0,  "Hi Excel!");
	$ws->write(0, 1,  'BBB'); 
	$ws->write(0, 2,  'CCC'); 
	$ws->write(0, 3,  'DDD'); 
	$ws->write(0, 4,  'EEE'); 
	$ws->write(0, 5,  'FFF'); 
	$ws->write(0, 6,  'GGG'); 
	$ws->write(0, 7,  'HHH'); 
}

__END__
