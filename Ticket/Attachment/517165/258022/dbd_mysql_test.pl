#!/usr/bin/perl -w

use strict;
use warnings;
use DBI;

my ($host, $database, $username, $password) = @ARGV;
die "Usage: $0 host database username password\n" unless $password;

my $dbh = DBI->connect("DBI:mysql:database=$database;host=$host", $username, $password);
die "Connection failed " . DBI->errstr() unless $dbh;

$dbh->{mysql_auto_reconnect} = 1;
my $threadid = $dbh->{mysql_thread_id};

my $dbh2 = DBI->connect("DBI:mysql:database=$database;host=$host", $username, $password);
die "Connection failed " . DBI->errstr() unless $dbh2;
$dbh2->do("KILL $threadid");
$dbh2->disconnect();
sleep 1;

my ($val) = $dbh->selectrow_array("SELECT 1");
print "You do not have the bug.  Also, autoreconnection: " . ($val ? "succeeded" : "failed") . "\n";
