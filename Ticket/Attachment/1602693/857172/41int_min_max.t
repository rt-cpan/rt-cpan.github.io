use strict;
use warnings;
use bigint;

use DBI;
use Test::More;
use lib 't', '.';
require 'lib.pl';
use vars qw($test_dsn $test_user $test_password);

my $dbh;
eval {$dbh= DBI->connect($test_dsn, $test_user, $test_password,
                      { RaiseError => 1, PrintError => 1, AutoCommit => 1 });};
if ($@) {
    plan skip_all => "no database connection";
}

if (!MinimumVersion($dbh, '4.1')) {
    plan skip_all => "ERROR: $DBI::errstr. Can't continue test";
    plan skip_all =>
        "SKIP TEST: You must have MySQL version 4.1 and greater for this test to run";
}

my $table = 'dbd_mysql_t41minmax'; # name of the table we will be using
plan tests => 11*8 + 2;

sub test_int_type ($$$$) {
    my ($perl_type, $mysql_type, $min, $max) = @_;

    # Disable the warning text clobbering our output
    local $SIG{__WARN__} = sub { 1; };

    # Create the table
    ok($dbh->do(qq{DROP TABLE IF EXISTS $table}), "removing $table");
    ok($dbh->do(qq{CREATE TABLE `$table` (`val` $mysql_type)}), "creating minmax table for type $mysql_type");

    my $minmax;
    ok($minmax = $dbh->prepare("INSERT INTO $table VALUES (?)"));

    # Insert allowed in and max value
    ok($minmax->bind_param( 1, $min->bstr(), $perl_type ), "binding minimal $mysql_type");
    ok($minmax->execute(), "inserting min data for type $mysql_type");
    ok($minmax->bind_param( 1, $max->bstr(), $perl_type ), "binding maximal $mysql_type");
    ok($minmax->execute(), "inserting max data for type $mysql_type");

    # Try to insert over the limit value
    ok($minmax->bind_param( 1, ($min-1)->bstr(), $perl_type ), "binding less than minimal $mysql_type");
    $@ = '';
    eval{$minmax->execute()};
    like($@, qr/Out of range value for column 'val'/, "less than min exception thrown for $mysql_type");

    ok($minmax->bind_param( 1, ($max+1)->bstr(), $perl_type ), "binding more than maximal $mysql_type");
    $@ = '';
    eval{$minmax->execute()};
    like($@, qr/Out of range value for column 'val'/, "more than max exception thrown for $mysql_type");
}

test_int_type(DBI::SQL_TINYINT,  'tinyint signed',     -2**7,  2**7-1);
test_int_type(DBI::SQL_TINYINT,  'tinyint unsigned',       0,  2**8-1);
test_int_type(DBI::SQL_SMALLINT, 'smallint signed',   -2**15, 2**15-1);
test_int_type(DBI::SQL_SMALLINT, 'smallint unsigned',      0, 2**16-1);
test_int_type(DBI::SQL_INTEGER,  'int signed',        -2**31, 2**31-1);
test_int_type(DBI::SQL_INTEGER,  'int unsigned',           0, 2**32-1);
test_int_type(DBI::SQL_BIGINT,   'bigint signed',     -2**63, 2**63-1);
test_int_type(DBI::SQL_BIGINT,   'bigint unsigned',        0, 2**64-1);

ok ($dbh->do("DROP TABLE $table"));

ok $dbh->disconnect;
