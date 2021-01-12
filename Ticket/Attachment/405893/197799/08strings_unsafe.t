#!/usr/bin/perl
use warnings;
use strict;

use Test::More tests => 3;

use_ok('Python::Serialise::Pickle');

ok(my $ps = Python::Serialise::Pickle->new('t/strings_unsafe'));


my $s = $ps->load();
is($s, '@{[sin(0.5)]}');

