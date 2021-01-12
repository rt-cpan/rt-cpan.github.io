#!perl

use strict;
use warnings;

use DBI;
use DBD::DB2;
use DBD::DB2::Constants;

my ($DATABASE, $USERID, $PASSWORD) = @ARGV;

my $dbh = DBI->connect("dbi:DB2:$DATABASE", "$USERID", "$PASSWORD", {PrintError => 1}) or die $DBI::errstr;

my $sth = $dbh->prepare( 'DROP PROCEDURE SP_Example' ) or die $DBI::errstr;
$sth->execute();

my $statement = "CREATE PROCEDURE SP_Example () LANGUAGE SQL BEGIN RETURN 5; END";
$sth = $dbh->prepare( $statement ) or die $DBI::errstr;
$sth->execute() or die $DBI::errstr;

my $output = undef;

$sth = $dbh->prepare( '{ ? = CALL SP_Example( ) }' ) or die $DBI::errstr;
$sth->bind_param_inout( 1, \$output, 20, { 'db2_param_type' => SQL_PARAM_OUTPUT, 'db2_c_type' => SQL_C_LONG, 'db2_type' => SQL_INTEGER }) or die $DBI::errstr;
my $rv = $sth->execute() or die $DBI::errstr;

printf("the output is %d\n", $output);

$sth->finish or die $DBI::errstr;
$dbh->disconnect or die $DBI::errstr;

__END__
