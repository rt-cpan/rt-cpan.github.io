use strict;
use warnings;
use Scalar::Util qw(looks_like_number);
use Spreadsheet::WriteExcel;  


our $Workbook;
our $Sheet; 

	$Workbook        = Spreadsheet::WriteExcel->new("TestCase.xls");
	$Sheet   = $Workbook->add_worksheet("NoSheet");

	if (!$Sheet) {
		print "WARNING -- Could Not add a sheet called NoSheet to the workbook\n";
	} else {
		print "NoSheet was added to the workbook.  Yes, a sheet called NoSheet, so this means there IS a sheet, just that it's called NoSheet\n";
	}

	print "Setting cell 0,0 to 42.0  The answer to the question\n";
	$Sheet->write_number(0,0, 42.0 );
	print "Attempting to write the cell to the value 3.14\n".
	$Sheet->write_number(0,0,  3.14 );
	print "Closing Workbook... See if there is PI at cell 0,0\n";
	$Workbook->close();
