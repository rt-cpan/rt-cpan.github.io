#!/usr/bin/env perl

use warnings;
use strict;

use DBI;

my $dbh = DBI->connect ("dbi:CSV:", undef, undef, {
  csv_sep_char    => ":",
  csv_quote_char  => undef,
  csv_escape_char => undef,
  csv_eol         => "\n",
#  csv_tables => { dinges => {
#    col_names => [qw( login password uid gid realname directory shell )],
#    file => '/etc/passwd'
#  }}
});

# does *not* work with the csv_tables entry uncommented

$dbh->{csv_tables}{dinges} = {
  file        => "/etc/passwd",
  col_names   => [qw( login password uid gid realname directory shell )]
};

# now it *does* work

my $sth = $dbh->prepare ("SELECT * FROM dinges")
  or die "prepare failed: ", DBI::errstr, "\n";

$sth->execute
  or die "execute failed: ", DBI::errstr, "\n";

while (my $r = $sth->fetchrow_arrayref)
{
  print $r->[0], "\n";
}


