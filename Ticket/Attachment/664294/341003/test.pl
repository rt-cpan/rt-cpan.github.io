
use strict;
use DBI;
use DBI qw(:sql_types);
use Data::Dumper;

# Using mysql_server_prepare!!!
my $dbh =
DBI->connect("DBI:mysql:dbname=test;host=127.0.0.1;port=3306;mysql_server_prepare=1",
"root", "") or die $!;

$dbh->do("DROP TABLE IF EXISTS test");
$dbh->do("create table test (id int, value0 varchar(10), value1 varchar(10), value2 varchar(10))");

my $sth_insert = $dbh->prepare("INSERT INTO test (id, value0, value1, value2) VALUES (?, ?, ?, ?)");
my $sth_lookup = $dbh->prepare("SELECT * FROM test where id=?");

# Insert null value
$sth_insert->bind_param(1, 42, SQL_WVARCHAR);
$sth_insert->bind_param(2, 102, SQL_WVARCHAR);
$sth_insert->bind_param(3, undef, SQL_WVARCHAR);
$sth_insert->bind_param(4, 10004, SQL_WVARCHAR);
$sth_insert->execute();

# Insert afterwards none null value
# This will insert currently (DBD::MySQL-4.012) corrupted data....
# incorrect use of MYSQL_TYPE_NULL in prepared statement in dbdimp.c

$sth_insert->bind_param(1, 43, SQL_WVARCHAR);
$sth_insert->bind_param(2, 2002, SQL_WVARCHAR);
$sth_insert->bind_param(3, 20003, SQL_WVARCHAR);
$sth_insert->bind_param(4, 200004, SQL_WVARCHAR);
$sth_insert->execute();

# verify

$sth_lookup->execute(42);
my $row_id_42 = $sth_lookup->fetchrow_hashref();
$sth_lookup->execute(43);
my $row_id_43 = $sth_lookup->fetchrow_hashref();
print "Row1: ", Dumper($row_id_42);
print "Row2: ", Dumper($row_id_43);

# the following line failes in DBD::MySQL-4.012, since row with id==43 (second insert) is corrupted.
$row_id_43->{value0} eq "2002" or die "Row: id=43, expected value0='2002' but got: '$row_id_43->{value0}'";

# never reached in DBD::MySQL-4.012
print "Test finished without error.\n" 
