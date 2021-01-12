#!/usr/bin/perl -w

use Test::More tests => 8;
use Scalar::Util qw(weaken isweak);
use warnings;
use strict;

my $a;
my $b = \$a;

ok(! isweak($b), "b not weak");
weaken($b);
ok(isweak($b), "b weak");

my $x = { y => [ 0, 1, 2], z => \$a, w => { a => 7 } };

ok(! isweak($x->{z}), "z not weak");
weaken($x->{z});
ok(isweak($x->{z}), "z weak");

ok(! isweak($x->{y}), "y not weak");
weaken($x->{y});
ok(isweak($x->{y}), "y weak");

ok(! isweak($x->{w}), "w not weak");
weaken($x->{w});
ok(isweak($x->{w}), "w weak");

