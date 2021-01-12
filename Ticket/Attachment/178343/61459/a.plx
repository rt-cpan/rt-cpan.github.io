#!/usr/bin/perl
use DBI;
my $dbh = DBI->connect('dbi:Pg:dbname=test','test');
$dbh->do(q{SET search_path TO ?}, undef, 'public');
