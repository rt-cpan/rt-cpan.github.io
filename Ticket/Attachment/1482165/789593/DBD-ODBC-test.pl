use DBI;
use DBD::ODBC;

our $dbuser = 'dbuser';
our $dbpass = '****';
my $dbh = DBI->connect(
    "dbi:ODBC:ODBC-LABEL",
    $dbuser, $dbpass,
    { PrintError => 0, RaiseError => 1, AutoCommit => 1, @_ },
);

for (1, 2) {
    my $sth = $dbh->prepare_cached( "UPDATE [ticket] SET [retail_price] = CAST(? AS MONEY) WHERE 1=0" );
    $sth->execute( 100.21 + $_ );
}

