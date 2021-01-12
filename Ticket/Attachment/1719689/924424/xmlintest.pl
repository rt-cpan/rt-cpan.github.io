#! /usr/bin/perl

use Data::Dumper;
use XML::Simple;

my $xs = XML::Simple->new();
my $ref = $xs->XMLin('test.xml');

print "->" . $ref->{bar} . "<-\n";
print Dumper $ref->{bar};

open(my $fh, 'test.xml');
my $xml = <$fh>;
print $xml;
print Dumper $xml;
