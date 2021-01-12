#!/usr/local/bin/perl

use strict;
use warnings;
use DBI;

DBI->trace (9);

my $dbh = DBI->connect ("DBI:Unify:", "", "PUBLIC", { uni_verbose => 99 }) or
    die "Cannot connect: ". DBI->errstr;

