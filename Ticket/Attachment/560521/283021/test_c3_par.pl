#!/usr/bin/perl
use strict;
use warnings;
use PAR 'foobar.par';
use base 'Class::C3::Componentised';

__PACKAGE__->ensure_class_found('Foo::Bar') or die("Foo::Bar not found");
print "Foo::Bar found.\n";
