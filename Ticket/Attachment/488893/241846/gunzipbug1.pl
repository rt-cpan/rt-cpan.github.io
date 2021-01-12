#!/usr/bin/perl

use strict;
use warnings;

use IO::Uncompress::Gunzip qw(gunzip $GunzipError) ;

my $gz = new IO::Uncompress::Gunzip 'linux.bin.gz'
    or die "Cannot gunzip: $GunzipError\n";

$| = 1;

my $buffer;
my $out;

while ($gz->read($buffer))
{
    $out += length $buffer;
    print "Got $out buyes\n";
}
