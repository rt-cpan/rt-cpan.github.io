#!perl -w
use strict;
use warnings;

use Getopt::Long;

my @opts;
GetOptions('opt=o@{,}' => \@opts) or die;

print join(',', @opts), "\n";
