#!/bin/env perl
use strict; use warnings; use 5.010;
use List::Util qw/shuffle/;
use Set::Object 1.35 qw/set/;
my @list = shuffle(1..1000);

my $lil_set = set(@list);
for (1..100) {
            my $x = 0;
            foreach my $item ($lil_set->members()) {
                $x += $item;
                $x += $item;
                $x += $item;
                $x += $item;
                $x += $item;
            }

            foreach my $item (@{$lil_set}) {
                $x += $item;
                $x += $item;
                $x += $item;
                $x += $item;
                $x += $item;
            }
}
__END__
