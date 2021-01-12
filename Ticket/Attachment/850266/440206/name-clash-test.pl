#!/usr/bin/perl
use strict;
use warnings;

=head1 NAME

name-clash-test.pl - crash DBIx::Class::Schema::Loader when there is a
column name that collides with a built-in method name

2010-10-28

=cut

my $file = 'name-clash-test.dbfile';

my $ddl1 = '
CREATE TABLE t1 (
    id         INTEGER PRIMARY KEY,
    noise      TEXT
);';

my $ddl2 = '
CREATE TABLE t2 (
    id         INTEGER PRIMARY KEY,
    second_foreign_key INTEGER,
    belongs_to INTEGER,
    FOREIGN KEY (second_foreign_key) REFERENCES t1(id),
    FOREIGN KEY (belongs_to) REFERENCES t1(id)
);';

my $sql1 = 'INSERT INTO t1 (noise) VALUES ("art of");';
my $sql2 = 'INSERT INTO t2 (belongs_to) VALUES (1);';

unlink $file if -e $file;

use DBI;

# DBI->trace(1);

my $dbh = DBI->connect("dbi:SQLite:dbname=$file", '', '') or die;
$dbh->do($ddl1) or die;
$dbh->do($ddl2) or die;
$dbh->do($sql1) or die;
$dbh->do($sql2) or die;
$dbh->disconnect or die;


use DBIx::Class::Schema::Loader qw/ make_schema_at /;

make_schema_at( 'NameClash::Schema',
		{
			debug => 1,
			dump_directory => '.',
		},
		[
			"dbi:SQLite:dbname=$file",
			'',
			'',
		],
);

