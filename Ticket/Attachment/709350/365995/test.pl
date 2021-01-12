use strict;
use warnings;

use Spreadsheet::ParseExcel;

my $parser = Spreadsheet::ParseExcel->new();

my $book = $parser->parse('/home/jdr99/Dropbox/4.0.xls');
use Data::Dumper;
warn Dumper $book->{FormatStr};
1;
