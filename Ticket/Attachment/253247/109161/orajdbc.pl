#!/opt/OV/bin/Perl/bin/perl

use lib '/opt/ovaa/perl5lib';
use lib '/opt/ovaa/perl5lib/sun4-solaris';
use strict;
use warnings;

# Modules
use Carp;
use Data::Dumper;
use English;
use JDBC;

my $driver = 'oracle.jdbc.driver.OracleDriver';
my $url    = 'jdbc:oracle:thin:@localhost:1521:ORAOPVD1';
my $user   = 'opc_report';
my $passwd = 'fr334a11';

JDBC->load_driver($driver);
my $con  = JDBC->getConnection($url,$user,$passwd);
my $sql;
eval { $sql  = $con->createStatement(); };
die $@->getMessage() if ref $@;
die $@ if $@;

my $result;
my $query = <<"SQL";
select distinct name 
  from opc_user_data
 where user_id in(select profile_id
  from opc_user_data ud, opc_op_profiles p
 where name = '$ARGV[0]'    
   and ud.user_id = p.user_id)
SQL

eval { $result = $sql->executeQuery($query) };
die $@->getMessage() if ref $@;
die $@ if $@;

my $metadata     = $result->getMetaData();
my $column_count = $metadata->getColumnCount();
    
my @results;
while ($result->next) {
    my @strings;
    for my $i (1..$column_count) {
        push @strings, $result->getString($i);
    }

    if ($column_count eq 1) {
        push @results, @strings;
    }
    else {
        push @results, [@strings];
    }
}
$result->close;
$sql->close;
$con->close;

print Dumper(@results);

