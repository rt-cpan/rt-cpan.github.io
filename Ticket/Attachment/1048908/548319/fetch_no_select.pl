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

print "\nCreate $proc that conditionally runs SELECT\n";
eval {
   $dbh->do (
      "CREATE PROCEDURE [$proc]" . '
      @I INT
      AS
      SET NOCOUNT ON
      IF 0 = 1
	  BEGIN
          SELECT ' . "'I'" . ', CAST (@I AS VARCHAR)
		  RETURN 5
	  END
      RETURN 0
      '
   )
};
if ($@ || $dbh->err) {
   die "Failed to create $proc\n",
       "$@\n",
       "$DBI::errstr\n";
}

print "exec $proc that conditionally runs SELECT\n";
$rv = undef;
$sp = "? = call $proc (?)";
if ($sth = $dbh->prepare ("{ $sp }")) {
   $sth->bind_param_inout (1, \$rv, 4);
   $sth->bind_param (2, 1);
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
print "Fetched from $proc:\n";
while (my @a = $sth->fetchrow_array) {
   print "@a\n";
}
print "$proc rv=<$rv>\n";

print "Drop $proc\n";
eval { $dbh->do ("DROP PROCEDURE $proc") };


eval { $dbh->commit; };
if ($@) {
   die "Commit failed - $DBI::errstr\n";
   exit 1;
}
$dbh->disconnect;
