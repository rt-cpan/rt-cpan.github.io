#!/usr/bin/perl

use warnings;
use strict;

use Test::MockObject;
use Data::Dumper;

my $mock = Test::MockObject->new();
my $arrayref = [1, 2, 3];
$mock->set_bound('arrayref', \$arrayref);

print Dumper($mock->arrayref);
