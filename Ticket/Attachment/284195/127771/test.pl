use strict;
use warnings;

use OpenOffice::OODoc;
use Data::Dumper;

my $doc = ooDocument( file => "./test.ods");
my $table = $doc->getTable( 'Tabelle1');
$doc->normalizeTable( $table, 4, 2);
my $cell = $doc->getCell($table, 1, 1);
print "type: '", $doc->cellValueType($cell),"', value: '",$doc->getCellValue($cell), "'\n";
my $cell = $doc->getCell($table, 2, 1);
print "type: '", $doc->cellValueType($cell),"', value: '",$doc->getCellValue($cell), "'\n";
my @aData = $doc->getTableText( $table);
print Dumper( @aData);
exit;
