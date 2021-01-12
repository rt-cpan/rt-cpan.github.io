#!/usr/bin/perl -w

use warnings;
use strict;

use DBI;
use DBD::DB2;
use DBD::DB2::Constants;
use Data::Dumper;
$Data::Dumper::Useqq = 1;
$Data::Dumper::Terse = 1;
$Data::Dumper::Indent = 0;

my ($DATABASE, $USERID, $PASSWORD) = @ARGV;

my $dbh = DBI->connect("dbi:DB2:$DATABASE", "$USERID", "$PASSWORD", {PrintError => 1}) or die $DBI::errstr;

my $sth = $dbh->prepare( 'DROP PROCEDURE SP_Example' ) or die $DBI::errstr;
$sth->execute();

my $statement = "CREATE PROCEDURE SP_Example () LANGUAGE SQL BEGIN RETURN 5; END";
$sth = $dbh->prepare( $statement ) or die $DBI::errstr;
$sth->execute() or die $DBI::errstr;

my $failures = 0;
sub passfail($$) {
    my ($msg, $ret) = @_;
    print($msg.' '.('.'x(55 - length($msg))).' '.($ret ? 'pass' : 'FAIL')."\n");
    $failures++ if (!$ret);
}

my $round = 0;
foreach my $binds (
    { 'db2_param_type' => SQL_PARAM_OUTPUT },
    { 'db2_param_type' => SQL_PARAM_OUTPUT, 'db2_c_type' => SQL_C_LONG },
) {
    $round++;
    $sth = $dbh->prepare( '{ ? = CALL SP_Example( ) }' ) or die $DBI::errstr;
    my $output;
    $sth->bind_param_inout( 1, \$output, 20, $binds) or die $DBI::errstr;

    $sth->execute() or die $DBI::errstr;
    my $output_dcr = $sth->{'db2_call_return'};

    #printf("the output bind is ".Dumper($output));
    #printf("the db2_call_return is ".Dumper($output_dcr));

    $sth->finish or die $DBI::errstr;

    passfail('Checking round '.$round.' db2_call_return value '.Dumper($output_dcr), $output_dcr eq 5);
    passfail('Checking round '.$round.' output bind var value '.Dumper($output), $output eq 5);
}

$dbh->disconnect or die $DBI::errstr;

die 'failed' if $failures;