#!/usr/bin/perl -w
use strict;
use autodie;
use ModuleWithoutPackage;

use Test::More;

eval {
    foo;
};

is($@, '',
   'Expect no errors from ModuleWithoutPackage - because it has no bugs!');
