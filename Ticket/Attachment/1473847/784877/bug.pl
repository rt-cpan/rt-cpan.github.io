#
# USAGE:
#
#   With DBD::mysql and a real MySQL server:
#  
#       bug.pl <host> <db> <user> <password>
#  
#   With the stripped-to-the-bones DBD::nysql abomination that was attached
#   to the bug report:
#  
#       bug.pl
#  

use strict;
use warnings;

use DBI;


# Arguments passed to connect()
my @connect_args;

if (@ARGV == 4) {
	# Use the real DBD::mysql driver
	my ($host, $db, $user, $password) = @ARGV;
	@connect_args = ("dbi:mysql:database=$db;host=$host", $user, $password);
} elsif (@ARGV == 0) {
	# Use our fake DBD::nysql driver
	@connect_args = "dbi:nysql:";
} else {
	die "$0 requires either four (MySQL) or zero (nysql) arguments\n";
}


# Subclassing DBI and overwriting STORE is one way to trigger the bug
@Foo::ISA     = 'DBI';
@Foo::db::ISA = 'DBI::db';
@Foo::st::ISA = 'DBI::st';

{
	package Foo::db;

	sub STORE {
	    my ($dbh, @args) = @_;

	    return $dbh->SUPER::STORE(@args);
	}
}

my $dbh = Foo->connect(@connect_args);
$dbh->begin_work;
my $r = $dbh->commit;

