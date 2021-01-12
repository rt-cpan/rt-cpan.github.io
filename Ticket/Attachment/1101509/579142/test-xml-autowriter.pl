use warnings;
use strict;

use XML::Doctype;
use XML::AutoWriter;

my $encoding = 'utf-8';

my $doctype = XML::Doctype->new('artikel-liste', SYSTEM_ID => 'pmg-artikel-liste.dtd');

my $writer = XML::AutoWriter->new(DOCTYPE => $doctype, OUTPUT => 'test.xml');
$writer->xmlDecl($encoding);
$writer->doctype('artikel-liste', undef, '"pmg-artikel-liste.dtd"');

my $end = $ARGV[0] || 1;
foreach my $i (1 .. $end) {
    print STDERR "Run $i\n";
    $writer->dataElement('artikel-id', 'A1');
    $writer->dataElement('lieferant-id', '123');
    $writer->dataElement('quelle-id', '456');
    $writer->dataElement('name', 'world news');
    $writer->dataElement('datum', '20120101');
    $writer->dataElement('seite-start', 1);
    $writer->dataElement('autor-name', 'me');
    $writer->dataElement('rubrik', 'news') if ($i > 5);
    $writer->dataElement('titel', 'headline');
    $writer->dataElement('absatz', 'foo bar');
    $writer->endTag('artikel');
}

$writer->end;
