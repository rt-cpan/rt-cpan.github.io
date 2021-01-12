use DBI;
use DBD::DB2;

$DATABASE="dbname";
$USERID = "username";
$PASSWORD = "password";

my $dbh = DBI->connect("dbi:DB2:$DATABASE", $USERID, $PASSWORD, {PrintError => 1})
        or die "Couldn't connect to database: " . DBI->errstr;

$sth = $dbh->prepare( "DROP PROCEDURE swap_email_address");
$sth->execute();

$statement = "CREATE PROCEDURE swap_email_address  ( INOUT inoutString char(25),  INOUT outString char(25) ) P1:   BEGIN  set inoutString = outString; set outString = inoutString ; return 5; END P1";
$sth = $dbh->prepare( $statement );
$sth->execute();

$sth = $dbh->prepare( "{?=CALL swap_email_address(?,?)}");

my $name = "hello";
my $second_name = "yellow";
my $output=100;
print "Values before binding  $name, $second_name \n";

$sth->bind_param_inout( 1, \$output, { 'db2_param_type' => SQL_PARAM_INPUT_OUTPUT}) or die;
$sth->bind_param_inout( 2, \$name, { 'db2_param_type' => SQL_PARAM_INPUT_OUTPUT});
$sth->bind_param_inout( 3, \$second_name, { 'db2_param_type' => SQL_PARAM_INPUT_OUTPUT });
$sth->execute();

# The following code does not work like in your previous example since DB2 does not return a value for ?=some storedproc
# my $nooutput;
# $sth->bind_param_inout( 1, \$nooutput, { 'db2_param_type' => SQL_PARAM_OUTPUT}) or die;
# print "$nooutput" ; // This would give an undef value since DB2 does not return anything. Thus you would need to use db2_call_return.

print "Values after binding  $name, $second_name, $output \n";
#This would output 10
print "Value for Call return is $sth->{db2_call_return} \n";    

$sth->finish();

$dbh->disconnect;
