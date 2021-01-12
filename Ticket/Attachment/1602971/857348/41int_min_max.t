use strict;
use warnings;
use bigint;

use DBI;
use Test::More;
use lib 't', '.';
use Data::Dumper;
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
# nostrict tests + strict tests + init/tear down commands
plan tests => 19*8 + 17*8 + 4;

my $table = 'dbd_mysql_t41minmax'; # name of the table we will be using
my $mode; # 'strict' or 'nostrict' corresponds to strict SQL mode

sub test_int_type ($$$$) {
    my ($perl_type, $mysql_type, $min, $max) = @_;

    # Disable the warning text clobbering our output
    local $SIG{__WARN__} = sub { 1; };

    # Create the table
    ok($dbh->do(qq{DROP TABLE IF EXISTS $table}), "removing $table");
    ok($dbh->do(qq{
            CREATE TABLE `$table` (
                `id` int not null auto_increment,
                `val` $mysql_type,
                primary key (id)
            )
    }), "creating minmax table for type $mysql_type");

    my ($store, $retrieve); # statements
    my $read_value;         # retrieved value
    ok($store = $dbh->prepare("INSERT INTO $table (val) VALUES (?)"));
    ok($retrieve = $dbh->prepare("SELECT val from $table where id=(SELECT MAX(id) FROM $table)"));

    ########################################
    # Insert allowed min value
    ########################################
    ok($store->bind_param( 1, $min->bstr(), $perl_type ), "binding minimal $mysql_type, mode=$mode");
    ok($store->execute(), "inserting min data for type $mysql_type, mode=$mode");

    ########################################
    # Read it back and compare
    ########################################
    ok{$retrieve->execute()};
    ($read_value) = $retrieve->fetchrow_array();
    cmp_ok($read_value, 'eq', $min, "retrieved minimal value for $mysql_type, mode=$mode");

    ########################################
    # Insert allowed max value
    ########################################
    ok($store->bind_param( 1, $max->bstr(), $perl_type ), "binding maximal $mysql_type, mode=$mode");
    ok($store->execute(), "inserting max data for type $mysql_type, mode=$mode");

    ########################################
    # Read it back and compare
    ########################################
    ok{$retrieve->execute()};
    ($read_value) = $retrieve->fetchrow_array();
    cmp_ok($read_value, 'eq', $max, "retrieved maximal value for $mysql_type, mode=$mode");

    ########################################
    # Try to insert under the limit value
    ########################################
    ok($store->bind_param( 1, ($min-1)->bstr(), $perl_type ), "binding less than minimal $mysql_type, mode=$mode");
    if ($mode eq 'strict') {
        $@ = '';
        eval{$store->execute()};
        like($@, qr/Out of range value for column 'val'/, "Error, you stored ".($min-1)." into $mysql_type, mode=$mode\n".
            Data::Dumper->Dump([$dbh->selectall_arrayref("SELECT * FROM $table")]).
            Data::Dumper->Dump([$dbh->selectall_arrayref("describe $table")])
        );
    } else {
        ok{$store->execute()};
        ########################################
        # Check that it was rounded correctly
        ########################################
        ok{$retrieve->execute()};
        ($read_value) = $retrieve->fetchrow_array();
        cmp_ok($read_value, 'eq', $min, "retrieved minimal value for type $mysql_type, mode=$mode");
    };

    ########################################
    # Try to insert over the limit value
    ########################################
    ok($store->bind_param( 1, ($max+1)->bstr(), $perl_type ), "binding more than maximal $mysql_type, mode=$mode");
    if ($mode eq 'strict') {
        $@ = '';
        eval{$store->execute()};
        like($@, qr/Out of range value for column 'val'/, "Error, you stored ".($max+1)." into $mysql_type, mode=$mode\n".
            Data::Dumper->Dump([$dbh->selectall_arrayref("SELECT * FROM $table")]).
            Data::Dumper->Dump([$dbh->selectall_arrayref("describe $table")])
        );
    } else {
        ok{$store->execute()};
        ########################################
        # Check that it was rounded correctly
        ########################################
        ok{$retrieve->execute()};
        ($read_value) = $retrieve->fetchrow_array();
        cmp_ok($read_value, 'eq', $max, "retrieved maximal value for type $mysql_type, mode=$mode");
    };
}

# Set strict SQL mode
ok($dbh->do("SET SQL_MODE='STRICT_ALL_TABLES'"),"Enter strict SQL mode.");
$mode = 'strict';

test_int_type(DBI::SQL_TINYINT,  'tinyint signed',     -2**7,  2**7-1);
test_int_type(DBI::SQL_TINYINT,  'tinyint unsigned',       0,  2**8-1);
test_int_type(DBI::SQL_SMALLINT, 'smallint signed',   -2**15, 2**15-1);
test_int_type(DBI::SQL_SMALLINT, 'smallint unsigned',      0, 2**16-1);
test_int_type(DBI::SQL_INTEGER,  'int signed',        -2**31, 2**31-1);
test_int_type(DBI::SQL_INTEGER,  'int unsigned',           0, 2**32-1);
test_int_type(DBI::SQL_BIGINT,   'bigint signed',     -2**63, 2**63-1);
test_int_type(DBI::SQL_BIGINT,   'bigint unsigned',        0, 2**64-1);

# Do not use strict SQL mode
ok($dbh->do("SET SQL_MODE=''"),"Leave strict SQL mode.");
$mode = 'nostrict';

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
