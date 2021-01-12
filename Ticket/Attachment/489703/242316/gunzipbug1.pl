#!/usr/bin/perl

use strict;
use warnings;

use IO::Uncompress::Gunzip qw(gunzip $GunzipError) ;

my $gz = new IO::Uncompress::Gunzip 'linux.bin.gz'
    or die "Cannot gunzip: $GunzipError\n";

$| = 1;

my $buffer;
my $out;

while ($gz->read($buffer, 16 * 1024))
{
    my $got = length $buffer;
    $out += $got;
    print "Got $got bytes -> total $out bytes\n";
}
