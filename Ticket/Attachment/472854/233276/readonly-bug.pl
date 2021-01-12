#!perl

use strict;
use warnings;

use DirHandle;
use Readonly;

Readonly my $CLASS => 'DirHandle';

foo1();
foo2();
foo3();

sub foo1 {
    eval {
        my $handle = $CLASS->new(q{.});
    };
    if ($@) {
        warn "Failed 1 - CLASS is '$CLASS': $@";
    }
}

sub foo2 {
    eval {
        my $handle = $CLASS->new(q{.});
    };
    if ($@) {
        warn "Failed 2 - CLASS is '$CLASS': $@";
    }
}

sub foo3 {
    eval {
        my $handle = "$CLASS"->new(q{.});
    };
    if ($@) {
        warn "Failed 3 - CLASS is '$CLASS': $@";
    }
}

