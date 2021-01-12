use DBI;
use DBD::DB2;
use DBD::DB2::Constants;

require 'connection.pl';
require 'perldutl.pl';

$DATABASE = "dbname";
$USERID = "user";
$PASSWORD = "password";

$dbh = DBI->connect("dbi:DB2:$DATABASE", "$USERID", "$PASSWORD", {PrintError => 0});

$sth = $dbh->prepare( 'DROP PROCEDURE SP_Example' );
$sth->execute();

$statement = "CREATE PROCEDURE SP_Example () LANGUAGE SQL BEGIN RETURN 5; END";
$sth = $dbh->prepare( $statement );
$sth->execute();

$sth = $dbh->prepare( '{ ? = CALL SP_Example( ) }' );
$sth->bind_param_inout( 1, \$output, 20, { 'db2_param_type' => SQL_PARAM_OUTPUT, 'db2_c_type' => SQL_C_LONG, 'db2_type' => SQL_INTEGER });
$rv = $sth->execute();

printf ( "the output is %d ", $output );

$sth->finish;
$dbh->disconnect;



