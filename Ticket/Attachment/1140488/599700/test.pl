#!/usr/bin/env perl
use DBI;
use strict;
use warnings;

my $dbh = DBI->connect("dbi:SQLite::memory:", undef, undef, { 
    RaiseError=>1, 
    PrintError=>1,
  });

# load the virtual table extension
$dbh->sqlite_enable_load_extension(1);
$dbh->sqlite_load_extension('perlvtab.so');

my $sth = $dbh->prepare('create virtual table test using perl ("SQLite::VirtualTable::CSV","test");');
$sth->execute;

my $sth2 = $dbh->prepare('select * from test;');
$sth2->execute;

