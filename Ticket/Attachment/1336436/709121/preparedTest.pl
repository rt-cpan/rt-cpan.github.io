#!/usr/bin/perl -d

use strict;
use DBI; # load DBI database interaction routines
print "DBI::VERSION: $DBI::VERSION\n";
use DBD::mysql;
use Test::Simple tests => 6;
print "DBD::mysql::VERSION: " . $DBD::mysql::VERSION . "\n\n";

#First without the prepare statement
my $dbh=DBI->connect('DBI:mysql:database=test;host=localhost', 'chester', 'myTestPW', {'RaiseError' => 1}) or die "ConnectionEror: $DBI::errstr\n";
testIt($dbh, "no prepared statements");

#Now with the prepare statement
$dbh=DBI->connect('DBI:mysql:database=test;host=localhost;mysql_server_prepare=1', 'chester', 'myTestPW', {'RaiseError' => 1}) or die "ConnectionEror: $DBI::errstr\n";
testIt($dbh, "prepared statements");

sub testIt {
	my $dbh = shift;
	my $condition = shift;
	my $sth = $dbh->prepare("SELECT * FROM preparedTest;");
	$sth->execute or die "SQL Error: $DBI::errstr\n";
	my @rows = $sth->fetchrow_array();
	my $name = $rows[0];
	print "Running tests with " . $condition . ".\n";
	print "Name:";
	print $name . "\n";
	ok($name eq "example", "Got the right row with " . $condition . ".");
	my $floater = $rows[1];
	print $floater . "\n";
	ok($floater == .96, "Float values work with " . $condition . ".");
	my $double = $rows[2];
	print $double . "\n";
	ok($double == .96, "Double values work with " . $condition . ".");
	print "\n\n";
	$sth->finish();
	$dbh->disconnect();
}