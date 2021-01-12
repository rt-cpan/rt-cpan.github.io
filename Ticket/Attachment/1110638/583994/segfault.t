#!/usr/bin/perl
use strict;
use warnings;

use Test::More tests => 16385;

use DBI;

use lib 't','.';
require 'dbdpg_test_setup.pl';

my $dbh = connect_database();

for my $length (0..16384) {
    my $sql = sprintf 'SELECT %*d', $length + 3, $length;
    my $cur_len = $dbh->selectrow_array($sql);
    is $cur_len, $length, "length $length => " . length($sql);
}
