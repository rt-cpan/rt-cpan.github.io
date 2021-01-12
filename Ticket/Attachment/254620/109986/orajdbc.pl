#!/opt/OV/bin/Perl/bin/perl
use JDBC;

my $driver = 'oracle.jdbc.driver.OracleDriver';
my $url    = 'jdbc:oracle:thin:@localhost:1521:ORAOPVD1';
my $user   = 'opc_report';
my $passwd = 'fr334a11';
my $query =  'select distinct name from opc_user_data';

JDBC->load_driver($driver);
my $con = JDBC->getConnection($url,$user,$passwd); 

print $con->getClass->getName();

my $sql  = $con->createStatement();
my $result = $sql->executeQuery($query);

while ($result->next) {
        print $result->getString(1);
}
