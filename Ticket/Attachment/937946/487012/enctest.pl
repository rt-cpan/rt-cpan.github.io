#!/opt/perl/bin/perl 

use strict;
use warnings;
use 5.010;
use utf8;
use autodie;

use DBI qw(:sql_types);
use DBD::ODBC;

############################################################

my $DB_NAME = '(censored)';
my $DB = "dbi:ODBC:Driver={SQL Server Native Client 10.0};Server=localhost;Database=$DB_NAME;Trusted_Connection=yes;";
my $DB_USER = '(censored)';
my $DB_PASS = '(censored)';
my $DB_OPTIONS = { RaiseError => 1, AutoCommit => 1 };

############################################################

#binmode STDOUT, ':utf8';

say "DBD::ODBC version $DBD::ODBC::VERSION";

my $dbh = DBI->connect($DB, $DB_USER, $DB_PASS, $DB_OPTIONS);
foreach my $attr (qw(odbc_has_unicode odbc_old_unicode)) {
    say "$attr: ", $dbh->{$attr} // '';
}

# Title is a varchar(2000).  The collation is SQL_Latin1_General_CP1_CI_AS, better known as windows-1252.
my $sth = $dbh->prepare("SELECT Title, Title FROM Product WHERE EAN = '3880060000010'");
$sth->execute();
my ($title1, $title2);
$sth->bind_col(1, \$title1);
$sth->bind_col(2, \$title2, SQL_WCHAR);
while ($sth->fetch()) {
    printf("Title with default bind type:   '%s'\n", $title1);
    my @high1 = $title1 =~ m{([^\x00-\x7F])}g;
    foreach my $h (@high1) {
        printf("    '%s': %d\n", $h, ord($h));
    }
    printf("Title with bind type SQL_WCHAR: '%s'\n", $title2);
    my @high2 = $title2 =~ m{([^\x00-\x7F])}g;
    foreach my $h (@high2) {
        printf("    '%s': %d\n", $h, ord($h));
    }
}

$dbh->disconnect();
