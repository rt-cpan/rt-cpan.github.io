#!/usr/bin/perl


use Storable qw(nstore retrieve);

my $obj = retrieve("obj.stored");

use SOAP::Lite +trace => 'all';
my $ser = SOAP::Serializer->new();
$ser->encode_object($obj);
