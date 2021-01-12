#!/usr/bin/perl

use IO::Compress::Bzip2;
use utf8;
my $str = "ãíòÃçyŏ";

my $z = new IO::Compress::Bzip2 "tmp.bz2" or die;

select $z;
binmode $z, ":utf8"; #noop accordingly with docs

print $str;

close $z;
