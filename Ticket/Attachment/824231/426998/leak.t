use strict;
use warnings;

use DBI;
my ($dbi_dsn, $user, $pass) = map { $ENV{"DBICTEST_PG_$_"} } qw/DSN USER PASS/;

my $dbh = DBI->connect($dbi_dsn, $user, $pass, {
  RaiseError => 1, PrintError => 0, ShowErrorStatement => 1   # <---- this is what makes the party go around
});
$dbh->do ('DROP TABLE IF EXISTS errorstat_leak_hunt');
$dbh->do ('CREATE TABLE errorstat_leak_hunt (num INTEGER NOT NULL)');

my $sth = $dbh->prepare_cached('INSERT INTO errorstat_leak_hunt (num) VALUES (?)');

my $count;
while (1) {
  $count++;
  eval { $sth->execute('non-num' x 200) };

  unless ($count % 2000) {
    warn sprintf ("Cycles: %d\tProc size: %uK\n",
      $count,
      (-f "/proc/$$/stat")
        ? do { local @ARGV="/proc/$$/stat"; (split (/\s/, <>))[22] / 1024 }
        : -1
      ,
    );
  }
}

