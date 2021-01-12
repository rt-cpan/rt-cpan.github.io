#!/usr/bin/env perl

# script to demo ExtUtils::Depends->save_config

use strict;
use warnings;
use 5.010;

use ExtUtils::Depends;

my $deps = ExtUtils::Depends->new(q(Foo), q(Gtk2));
$deps->save_config(q(extutils-depends.tmp));
