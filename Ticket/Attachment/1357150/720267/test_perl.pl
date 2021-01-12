#!/usr/bin/env perl
#
# NOTE - Requires test database p95214 & user u95214

use strict;
use Date::Manip;
use IPC::Open2;
use DBI;
use DBD::Pg qw/:pg_types/;

my ($filename, $file1_contents, $file2_contents, $fh);
my ($fname,$lname,$pname);
my $db_name = 'p95214';
my $db_host = 'db';
my $db_user = 'u95214';
my $db_pw = '';
my $db;
my $stmt;
my @row;

$db = DBI->connect("DBI:Pg:dbname=$db_name;host=$db_host;", $db_user, $db_pw);

##################
###### Grab names from the database
##### (This seems to be where Perl UTF-8 Wonkiness comes in)
@row = $db->selectrow_array("SELECT fname,lname FROM nametable");
($fname,$lname) = @row;
$pname = "$fname $lname";

##################
###### Alternate (Working) version
###### (string not tainted w/ Unicode)
#
#$pname = "Hubert Q. Farnsworth Junior";

# ----------------------------------------------------------------------
# binary contents of PNF
$file1_contents = pack ( "a13a4a2a17a14a13a17a16a2LSaaaaaaa20a12aaa94Sa11LS",
        "ABCDEFGH", "125", "M", $pname, 0, "Yoyodyne Inc", 
	"Tristero", "0000000", "N", 
	&UnixDate(ParseDate( "2014-04-10" ), "%s"),
	65535, 
        "", "", "", "", "", "",
        "", "", "", "", "NNNNNNNNNN", 0, "", 
        &UnixDate(ParseDate("1950-01-31"), "%s"), 0x6E
        );

# ----------------------------------------------------------------------
# Write PNF binary
$filename='/tmp/test.pnf';
if ( ! open( FH, ">$filename" ) ) {
    die( "Failed to open $filename: $!" );
}
binmode( FH );
print( FH $file1_contents );
close( FH );

my ($i, @arr, $len, $ecg_contents);
for ($i=0; $i < 16384; $i++) {
	push(@arr, rand(1500));
}
$ecg_contents = pack("S16384", @arr);

$file2_contents = pack( "a256a32776", $file1_contents, $ecg_contents );
$filename='/tmp/file2.bin';
if ( ! open( FH, ">$filename" ) ) {
    die( "Failed to open $filename: $!" );
}
binmode( FH );
print( FH $file2_contents );
close( FH );

$len = length($file1_contents);
printf("File1 Size: $len\n");
$len = length($file2_contents);
printf("File2 Size: $len\n");


#######################
# Database Abuse begins Here
#######################
$stmt = $db->prepare("INSERT INTO testtable (file1, file2) VALUES (?,?)");
$stmt->bind_param( 1, $file1_contents, { pg_type => DBD::Pg::PG_BYTEA } );
$stmt->bind_param( 2, $file2_contents, { pg_type => DBD::Pg::PG_BYTEA } );
$stmt->execute();
$stmt->finish();
$db->disconnect();1
