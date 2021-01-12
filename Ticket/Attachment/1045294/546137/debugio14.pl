#!/tools/cfr/perl/5.14.1/bin/perl

use strict;
use DBI;

select STDERR; $| = 1;
select STDOUT; $| = 1;

our ($ERROR_CODE, $ERROR_STRING, $WARNING_STRING);

my $db   = 'Test_Perl_DBI';
my $host = 'pausql02.lsi.com\\dev';
my $driv = '/tools/cfr/tdsodbc/0.91/lib/libtdsodbc.so';
my $src  = "DBI:ODBC:Database=$db;Server=$host;Driver=$driv;TDS_Version=7.2";
my $user = 'test_perl_dbi';
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



sub exec_sp_io {
   my ($dbh, $sp_spec, $iparams, $oparams) = @_;
   my $sth;

   undef $ERROR_CODE;
   undef $ERROR_STRING;
   undef $WARNING_STRING;

   if ($sth = $dbh->prepare ("{ $sp_spec }")) {
      if (defined $iparams) {
         while (my ($n, $p) = each (%$iparams)) {
            $sth->bind_param ($n, $p);
         }
      }
      if (defined $oparams) {
         while (my ($n, $p) = each (%$oparams)) {
            $sth->bind_param_inout ($n, @$p);
         }
      }
      eval { $sth->execute; };
      if ($@) {
         $ERROR_CODE   = $sth->err;
         $ERROR_STRING = $sth->errstr;
      }
      else {
         $WARNING_STRING = $sth->errstr;
      }
   }
   else {
      $ERROR_CODE   = $DBI::err;
      $ERROR_STRING = "Can't prepare statement '{ $sp_spec }'\n"
                    . $DBI::errstr;
   }

   return if ($ERROR_CODE);
   return $sth;
} # exec_sp_io()



my ($sth, $rv, $o);
my $proc = 'TMP_SP_Test_ODBC';

print "\nCreate $proc with input and no output\n";
eval {
   $dbh->do (
      "CREATE PROCEDURE [$proc]" . '
      @I INT
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

print "exec_sp_io $proc\n";
($rv, $o) = ();
exec_sp_io (
   $dbh,
   ":RV = call $proc (:I, :O)",
   {
      I => 10,
   },
   {
      RV => [ \$rv, 4 ],
   }
)
or
   warn "Error: exec_sp_io $proc failed\n",
        "ERROR_CODE=$ERROR_CODE\n",
        "ERROR_STRING=$ERROR_STRING\n";
$WARNING_STRING and warn "WARNING_STRING=$WARNING_STRING\n";
print "$proc returned:\n";
print "rv=<$rv>\n";

print "Drop $proc\n";
eval { $dbh->do ("DROP PROCEDURE $proc") };


print "\nCreate $proc with input and output\n";
eval {
   $dbh->do (
      "CREATE PROCEDURE [$proc]" . '
      @I INT,
      @O INT OUTPUT
      AS
      SET NOCOUNT ON
      SELECT @O = 55
      RETURN 9
      '
   )
};
if ($@ || $dbh->err) {
   die "Failed to create $proc\n",
       "$@\n",
       "$DBI::errstr\n";
}

print "exec_sp_io $proc\n";
($rv, $o) = ();
exec_sp_io (
   $dbh,
   ":RV = call $proc (:I, :O)",
   {
      I => 10,
   },
   {
      RV => [ \$rv, 4 ],
      O => [ \$o, 4 ],
   }
)
or
   warn "Error: exec_sp_io $proc failed\n",
        "ERROR_CODE=$ERROR_CODE\n",
        "ERROR_STRING=$ERROR_STRING\n";
$WARNING_STRING and warn "WARNING_STRING=$WARNING_STRING\n";
print "$proc returned:\n";
print "rv=<$rv>\n";
print "o=<$o>\n";

print "Drop $proc\n";
eval { $dbh->do ("DROP PROCEDURE $proc") };


print "\nCreate $proc with input and output without SET NOCOUNT ON\n";
eval {
   $dbh->do (
      "CREATE PROCEDURE [$proc]" . '
      @I INT,
      @O INT OUTPUT
      AS
      SELECT @O = 55
      RETURN 9
      '
   )
};
if ($@ || $dbh->err) {
   die "Failed to create $proc\n",
       "$@\n",
       "$DBI::errstr\n";
}

print "exec_sp_io $proc\n";
($rv, $o) = ();
exec_sp_io (
   $dbh,
   ":RV = call $proc (:I, :O)",
   {
      I => 10,
   },
   {
      RV => [ \$rv, 4 ],
      O => [ \$o, 4 ],
   }
)
or
   warn "Error: exec_sp_io $proc failed\n",
        "ERROR_CODE=$ERROR_CODE\n",
        "ERROR_STRING=$ERROR_STRING\n";
$WARNING_STRING and warn "WARNING_STRING=$WARNING_STRING\n";
print "$proc returned:\n";
print "rv=<$rv>\n";
print "o=<$o>\n";

print "Drop $proc\n";
eval { $dbh->do ("DROP PROCEDURE $proc") };


print "\nCreate $proc with input, output, select, init SET NOCOUNT\n";
eval {
   $dbh->do (
      "CREATE PROCEDURE [$proc]" . '
      @I INT,
      @O INT OUTPUT
      AS
      SET NOCOUNT ON
      SET @O = 55
      IF @I = 0
         RETURN 5
      SELECT ' . "'I'" . ', CAST (@I AS VARCHAR)
      RETURN 9
      '
   )
};
if ($@ || $dbh->err) {
   die "Failed to create $proc\n",
       "$@\n",
       "$DBI::errstr\n";
}

print "exec_sp_io $proc\n";
($rv, $o) = ();
$sth = exec_sp_io (
   $dbh,
   ":RV = call $proc (:I, :O)",
   {
      I => 10,
   },
   {
      RV => [ \$rv, 4 ],
      O => [ \$o, 4 ],
   }
)
or
   warn "Error: exec_sp_io $proc failed\n",
        "ERROR_CODE=$ERROR_CODE\n",
        "ERROR_STRING=$ERROR_STRING\n";
$WARNING_STRING and warn "WARNING_STRING=$WARNING_STRING\n";
print "Selected values:\n";
while (my @a = $sth->fetchrow_array) {
   print "@a\n";
}
print "Output values:\n";
print "rv=<$rv>\n";
print "o=<$o>\n";

print "Drop $proc\n";
eval { $dbh->do ("DROP PROCEDURE $proc") };


print "\nCreate $proc with input, output, select disabled, init SET NOCOUNT\n";
eval {
   $dbh->do (
      "CREATE PROCEDURE [$proc]" . '
      @I INT,
      @O INT OUTPUT
      AS
      SET NOCOUNT ON
      SET @O = 55
      IF @I = 0
         RETURN 5
      SELECT ' . "'I'" . ', CAST (@I AS VARCHAR)
      RETURN 9
      '
   )
};
if ($@ || $dbh->err) {
   die "Failed to create $proc\n",
       "$@\n",
       "$DBI::errstr\n";
}

print "exec_sp_io $proc\n";
($rv, $o) = ();
exec_sp_io (
   $dbh,
   ":RV = call $proc (:I, :O)",
   {
      I => 0,
   },
   {
      RV => [ \$rv, 4 ],
      O => [ \$o, 4 ],
   }
)
or
   warn "Error: exec_sp_io $proc failed\n",
        "ERROR_CODE=$ERROR_CODE\n",
        "ERROR_STRING=$ERROR_STRING\n";
$WARNING_STRING and warn "WARNING_STRING=$WARNING_STRING\n";
print "Output values:\n";
print "rv=<$rv>\n";
print "o=<$o>\n";

print "Drop $proc\n";
eval { $dbh->do ("DROP PROCEDURE $proc") };


print "\nCreate $proc with input, output, select disabled, later SET NOCOUNT\n";
eval {
   $dbh->do (
      "CREATE PROCEDURE [$proc]" . '
      @I INT,
      @O INT OUTPUT
      AS
      SET @O = 55
      IF @I = 0
         RETURN 5
      SET NOCOUNT ON
      SELECT ' . "'I'" . ', CAST (@I AS VARCHAR)
      RETURN 9
      '
   )
};
if ($@ || $dbh->err) {
   die "Failed to create $proc\n",
       "$@\n",
       "$DBI::errstr\n";
}

print "exec_sp_io $proc\n";
($rv, $o) = ();
exec_sp_io (
   $dbh,
   ":RV = call $proc (:I, :O)",
   {
      I => 0,
   },
   {
      RV => [ \$rv, 4 ],
      O => [ \$o, 4 ],
   }
)
or
   warn "Error: exec_sp_io $proc failed\n",
        "ERROR_CODE=$ERROR_CODE\n",
        "ERROR_STRING=$ERROR_STRING\n";
$WARNING_STRING and warn "WARNING_STRING=$WARNING_STRING\n";
print "Output values:\n";
print "rv=<$rv>\n";
print "o=<$o>\n";

print "Drop $proc\n";
eval { $dbh->do ("DROP PROCEDURE $proc") };


eval { $dbh->commit; };
if ($@) {
   die "Commit failed - $DBI::errstr\n";
   exit 1;
}
$dbh->disconnect;
