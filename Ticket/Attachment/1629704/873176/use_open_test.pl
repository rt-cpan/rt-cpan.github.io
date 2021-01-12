#!/usr/bin/perl
use strict;
use warnings;
use open ':std', ':encoding(utf8)';
use Term::ReadLine;

my $t;
$t = new Term::ReadLine 'foo';
print_layers($t->IN);

$t = new Term::ReadLine 'test', \*STDIN, \*STDOUT;
print_layers($t->IN);

exit 0;

sub print_layers {
    my $fh = shift;
    my @layers = PerlIO::get_layers($fh);
    print join(':', @layers), "\n";
}
