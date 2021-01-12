#!/usr/bin/perl -w
#-------------------------------------------------------------------------------
use strict; use diagnostics;
        
use DBI 1.48;

my $hostname = 'testhost'; # CHANGE ME
my $db_type = 'Informix';
my $database = 'testdatabase'; # CHANGE ME

#You will need to ensure this configuration information is correct for your environment.
$ENV{'INFORMIXDIR'} = "/usr/informix";
$ENV{'INFORMIXSERVER'} = "$hostname";
$ENV{'ONCONFIG'}       = "onconfig";
$ENV{'DBCENTURY'}      = "C";
$ENV{'INFORMIXC'} = "i386-glibc20-linux-gcc";
my $INFORMIXDIR = $ENV{'INFORMIXDIR'};
$ENV{'PATH'} .= ":$INFORMIXDIR/bin";

#connect to database
my $dbh;
if ($dbh = DBI->connect("dbi:${db_type}:${database}")) {
	$dbh->{PrintError} = 0;
	$dbh->{AutoCommit} = 1;
	$dbh->{ChopBlanks} = 1;
} else  {
	die "Failed to connect to db $database";
}

#run sql
my $sql = "SELECT * from lvarchar_test";
my $sth; 
my $result_set;

if ( ($sth = $dbh->prepare($sql)) && ($sth->execute() ) ) {
	$result_set = $sth->fetchall_arrayref({});
	$sth->finish();	

	print Dumper($result_set);
	
}else{
	print STDERR "Error runing sql $DBI::err $DBI::errstr";
}

$dbh->disconnect;
