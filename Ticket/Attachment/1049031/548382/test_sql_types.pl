#!/tools/cfr/perl/5.14.1/bin/perl

use strict;
use DBI;

select STDERR; $| = 1;
select STDOUT; $| = 1;

our ($ERROR_CODE, $ERROR_STRING, $WARNING_STRING);

my $db   = 'Test_Perl_DBI';
# my $host = 'pausql02.lsi.com\\dev;Port=1433';
# my $driv = '/tools/cfr/tdsodbc/0.64/lib/libtdsodbc.so';
# my $src  = "DBI:ODBC:Database=$db;Server=$host;Driver=$driv;TDS_Version=8.0";
my $host = 'pausql02.lsi.com\\dev';
my $driv = '/tools/cfr/tdsodbc/0.91/lib/libtdsodbc.so';
my $src  = "DBI:ODBC:Database=$db;Server=$host;Driver=$driv;TDS_Version=7.2";
my $user = 'test';
my $pass = 'test';

my $dbh;

for (my $i = 0 ; $i < 3 ; $i++) {
   $dbh =
   DBI->connect ($src, $user, $pass,
                 {
                    PrintError => 0,
                    RaiseError => 0,
                    AutoCommit => 0,
                 }
   ) and last;
   warn "Attempt #$i failed to connect - $DBI::errstr\n";
   sleep 1;
}

if ($dbh) {
   $dbh->{RaiseError} = 1;
}
else {
   exit 1;
}



my ($i, $sp, $sth, $rv);
my $proc = 'TMP_SP_Test_ODBC';

print "\nCreate $proc to test input param types\n";
eval {
   $dbh->do (
      "CREATE PROCEDURE [$proc]" . '
      @IBIT      bit,
      @ITINT     tinyint,
      @ICHAR     char,
      @ISINT     smallint,
      @IINT      int,
      @IBINT     bigint,
      @IFLOAT    float,
      @IREAL     real,
      @ICHAR10   char,
      @IVCHAR10  varchar,
      @IDATETIME datetime
      AS
      SET NOCOUNT ON
      RETURN 9
      '
   )
};
if ($@ || $dbh->err) {
   die "Failed to create $proc\n",
       "$@\n",
       "$DBI::errstr\n";
}

print "exec $proc using SQL_DATETIME causes Invalid data type (SQL-HY004)\n";
$rv = undef;
$sp = "? = call $proc (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
if ($sth = $dbh->prepare ("{ $sp }")) {
   $i = 1;
   $sth->bind_param_inout ($i++, \$rv, 4);
   $sth->bind_param ($i++, 1, DBI::SQL_BIT);
   $sth->bind_param ($i++, 200, DBI::SQL_TINYINT);
   $sth->bind_param ($i++, 'A', DBI::SQL_CHAR);
   $sth->bind_param ($i++, 30000, DBI::SQL_SMALLINT);
   $sth->bind_param ($i++, 2000000000, DBI::SQL_INTEGER);
   $sth->bind_param ($i++, 99999999999, DBI::SQL_BIGINT);
   $sth->bind_param ($i++, 55.55, DBI::SQL_FLOAT);
   $sth->bind_param ($i++, 123.123, DBI::SQL_REAL);
   $sth->bind_param ($i++, 'c10', DBI::SQL_CHAR);
   $sth->bind_param ($i++, 'vc10', DBI::SQL_VARCHAR);
   $sth->bind_param ($i++, '2011-10-10 10:10:10', DBI::SQL_DATETIME)
      or
      warn "Error: execute $proc bind_param failed\n",
           "err=$DBI::err\n",
           "errstr=$DBI::errstr\n";
   eval { $sth->execute; };
   if ($@) {
      warn "Error: execute $proc failed\n",
           "err=$DBI::err\n",
           "errstr=$DBI::errstr\n";
   }
}
else {
   warn "Error: Prepare $proc failed\n",
        "err=$DBI::err\n",
        "errstr=$DBI::errstr\n";
}
$sth->finish;
print "$proc rv=<$rv>\n";

print "Drop $proc\n";
eval { $dbh->do ("DROP PROCEDURE $proc") };


eval { $dbh->commit; };
if ($@) {
   die "Commit failed - $DBI::errstr\n";
   exit 1;
}
$dbh->disconnect;
