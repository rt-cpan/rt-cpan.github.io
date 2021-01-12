#!/usr/bin/perl

use strict;
use warnings;
use OpenOffice::OODoc;
use Data::Dumper;

my $file = shift or die;

my $ods = odfDocument(file => $file, part => 'content')
    or die "Cannot open file $file\n";

printf "%d, %d, %d\n", $ods->getTableSize(0), scalar($ods->getTableRows(0));

print "Before normalization:\n";

foreach my $row (($ods->getTableText(0))[0,1]) {
    print scalar @$row, ': ', Dumper($row);
}

$ods->normalizeSheet(0, 2, 10);

print "\nAfter normalization:\n";

foreach my $row (($ods->getTableText(0))[0,1]) {
    print scalar @$row, ': ', Dumper($row);
}
