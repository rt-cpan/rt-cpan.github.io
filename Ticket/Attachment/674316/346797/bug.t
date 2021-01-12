#!/usr/bin/env perl

$^W = 0;
use warnings;
use strict;

use Test::More tests => 4;

use version;

# Check that the qv() implementation does not change

ok(qv(1.2.3) < qv(1.2.3.1));
ok(qv(v1.2.3) < qv(v1.2.3.1));
ok(qv("1.2.3") < qv("1.2.3.1"));
ok(qv("v1.2.3") < qv("v1.2.3.1"));
