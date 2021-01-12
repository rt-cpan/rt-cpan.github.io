#!/usr/bin/perl

use warnings;
use strict;

use utf8;
use open qw(:std :utf8);

use CGI::Carp qw(fatalsToBrowser);

sub foo()
{
    die 123;
}


eval { foo(); };
die if $@;

