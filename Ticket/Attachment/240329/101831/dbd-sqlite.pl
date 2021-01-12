#!/usr/bin/perl -wT
use strict;
use DBI;

my $dbh = DBI->connect("dbi:SQLite:wp-empty.db", "", "");
my $wp = $dbh->prepare("SELECT text, name, redirect FROM en WHERE name = ?");

$wp->execute($ARGV[0]);
my $res = $wp->fetch;
print "got @$res\n" if $res;

