use strict;
use Spreadsheet::Read;
use warnings;

my $book  = Spreadsheet::Read->new('test.xls', 'attr' => 1, parser => 'xls');
