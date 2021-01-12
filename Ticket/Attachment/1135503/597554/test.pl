use strict;
use warnings;

use DBI;
use SQL::Translator;

my $dbh = DBI->connect( 'dbi:Pg:dbname=playground', 'postgres', '********' );

my $translator = SQL::Translator->new(
    parser      => 'DBI',
    parser_args => { dbh => $dbh, }
);
$translator->translate();
