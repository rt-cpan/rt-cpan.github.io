#!/usr/bin/perl

use strict;
use DBI;

my $db   = "test";
my $host = "localhost";
my $user = "test";
my $pass = "";
my $dsn  = "dbi:mysql:database=$db;host=$host";

local $| = 1;

print "Content-Type: text/plain\n\n";
print "Connecting to database...\n";

my $dbh = DBI->connect( $dsn, $user, $pass );

print "Preparing query...\n";
my $sth = $dbh->prepare("show tables");

print "Executing query...\n";
$sth->execute();

print "Fetching results...\n";
while ( my @row = $sth->fetchrow_array ) {
   print "@row\n";
}

print "Disconnecting...\n";

$dbh->disconnect;

print "DONE\n";
