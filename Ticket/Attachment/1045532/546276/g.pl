#!perl

use DBI;
use strict;

my $dsn = 
'DBI:SQLite:dbname=/var/mobile/Library/AddressBook/AddressBook.sqlitedb';
my $dbh = DBI->connect($dsn);

my $sql = "SELECT value FROM ABMultiValue WHERE label = 1";
my $sth = $dbh->prepare($sql);
$sth->execute;