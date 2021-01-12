#!/usr/bin/perl
use strict;
use warnings;
use Storable;

use Benchmark qw/timethese/;

my $data = { id => "ds" x 40 };

timethese(300000, {
        freeze  => sub { Storable::freeze($data) },
        nfreeze => sub { Storable::nfreeze($data) },
    });
