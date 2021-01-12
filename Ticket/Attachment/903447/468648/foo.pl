#!/usr/bin/perl -w
use strict;
use IO::File;
use IO::InnerFile;

my $outer = IO::File->new('</etc/passwd') || die;
my $inner = IO::InnerFile->new($outer, 5, -s $outer) || die;

my @lines = <$inner>;
print @lines;

exit 0;
