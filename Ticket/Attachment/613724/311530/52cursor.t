use Test::More;
use DBI;
use DBD::Oracle qw(ORA_RSET);
use strict;

unshift @INC ,'t';
require 'nchar_test_lib.pl';

plan tests => 4;

my $dsn = oracle_test_dsn();
my $dbuser = $ENV{ORACLE_USERID} || 'scott/tiger';
my $dbh = DBI->connect($dsn, $dbuser, '', { PrintError => 0 });

my $sth0 = $dbh->prepare(qq{
	BEGIN
		IF FALSE THEN
			OPEN :r FOR SELECT * FROM dual;
		END IF;
	END;
});
ok($sth0, 'open cursor');
my $sth1;
ok($sth0->bind_param_inout(":r", \$sth1, 0, {ora_type=>ORA_RSET}), 'bind');
ok($sth0->execute, 'first execute');
ok($sth0->execute, 'second execute');

$dbh->disconnect;

exit 0;
