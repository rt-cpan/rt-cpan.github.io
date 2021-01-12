#!/usr/bin/perl -wT
use strict;
use warnings;
use DBI;

unlink 'test.db';

my $dbh = DBI->connect('dbi:SQLite:test.db', undef, undef, {
    AutoCommit => 1,
    PrintError => 0,
    PrintWarn => 0,
    RaiseError => 1
});

$dbh->do('CREATE TABLE test (id VARCHAR(10) NOT NULL, name VARCHAR(20) NOT NULL, PRIMARY KEY(id));');
$dbh->do('INSERT INTO test (id, name) VALUES (\'1\', \'a\');');

my $sth = $dbh->prepare('INSERT INTO test (id, name) VALUES (?, ?)');
eval {
    $sth->execute('1', 'a');
};
warn $@;

## the following line barfs on win32 1.13/1.14 with:
## DBD::SQLite::st execute failed: column id is not unique(21) at dbdimp.c line 376 at test.pl line 26
$sth->execute('2', 'b');
