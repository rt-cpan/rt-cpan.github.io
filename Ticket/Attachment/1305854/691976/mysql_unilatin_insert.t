use warnings;
use strict;

use DBI;
use Devel::Dwarn;

my @DSN = map { $ENV{"DBICTEST_MYSQL_$_"} } qw(DSN USER PASS);

for my $strict (0,1) {

  print "\n\n=============\nATTEMPT WITH STRICT=$strict\n=============\n";


  my $dbh = DBI->connect(@DSN, { RaiseError => 1, AutoCommit => 1, mysql_enable_utf8 => 1 });

  $dbh->do( q{SET SQL_MODE = CONCAT('ANSI,TRADITIONAL,ONLY_FULL_GROUP_BY,', @@sql_mode)} )
    if $strict;

  $dbh->do($_) for (
    'DROP TABLE IF EXISTS _unilatin_test_greetz',
    'CREATE TABLE _unilatin_test_greetz ( greetings VARCHAR(255) ) DEFAULT CHARSET=utf8',
  );

  my $ins_sth = $dbh->prepare('INSERT INTO _unilatin_test_greetz (greetings) VALUES (?)');

  for my $str (
    "Gr\N{LATIN SMALL LETTER U WITH DIAERESIS}\N{LATIN SMALL LETTER SHARP S}",
    "Gr\xFC\xDF",
  ) {
    $ins_sth->trace(1);
    $ins_sth->execute($str);
    $ins_sth->trace(0);
  }

  Dwarn { contents => $dbh->selectall_arrayref('SELECT * FROM _unilatin_test_greetz') };
}

