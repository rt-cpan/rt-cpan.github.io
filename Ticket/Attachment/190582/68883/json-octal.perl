#!/usr/bin/perl

# JSON::Converter is treating strings that look like numbers as 
# numbers.  For example, the string "08" looks like an invalid octal 
# number.  JSON::Parser is treating them as numbers and is rightfully
# blowing up on invalid characters such as "8" and "." in octal 
# values.

use warnings;
use strict;

use JSON::Converter;
use JSON::Parser;

use Test::More tests => 1;

my $jc = JSON::Converter->new();
my $jp = JSON::Parser->new();

my $ides = "03152006";

my $json = $jc->hashToJson({ beware => $ides });
my $perl = $jp->parse($json);

ok(
  $perl->{beware} eq $ides,
  qq(Input string "$ides" should match output: "$perl->{beware}")
);

exit;
