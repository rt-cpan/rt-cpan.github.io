#!/usr/bin/perl

use strict;
use warnings;
use DBI;

my($dbh,$q);
unlink("test.db");
$dbh = DBI->connect("dbi:SQLite2:test.db");

my $create = <<EOF;
create table test (id INTEGER PRIMARY KEY, col1 INTEGER, col2 INTEGER);
insert into test (id, col1, col2) values (1, 1, 0);
EOF

for (split(/\n/, $create)) { $dbh->do($_); }

$q = $dbh->prepare("SELECT * FROM test WHERE col1 = ?");
$q->execute(1);

my $delayed = 0;
my (@row);
while (1) {
     if (@row = $q->fetchrow()) {
         print "q fetch, id=$row[0], col1=$row[1], col2=$row[2]\n";
     } else {
     	last if $delayed++;
     }
}
