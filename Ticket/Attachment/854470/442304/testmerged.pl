#!/usr/bin/perl

# Test ParseExcel

use Spreadsheet::ParseExcel::SaveParser;
use Data::Dumper;

$templatefile = "./test-out.xls";
$tmpfile = "./test-out2.xls";        

$parser = Spreadsheet::ParseExcel::SaveParser->new();        
$template = $parser->Parse($templatefile);        

$worksheet = $template->worksheet(0);

# Write some text into B4 - this is the first cell
# of a 4x2 merged area.  This cell already exists
# in the template as a merged area, we're just
# adding the text to it.
$cell = $worksheet->get_cell(3,1);    
$format_id = $cell->{FormatNo};
$worksheet->AddCell(3,1,'This is some text that should wrap and merge into a block from B4-E5', $format_id); 

print Dumper($cell);

# Write some text into a normal cell
$worksheet->AddCell(7,1,'After spreadsheet');

 
$template->SaveAs($tmpfile);             
print 'Saved file as: ' . $tmpfile . "\n";

exit(0);
