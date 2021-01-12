#!/usr/bin/perl -w
 
use strict;
 
use DBI;
 
my $dbh = DBI->connect ("dbi:CSV:", "", "", {
            f_ext    => ".csv",
            csv_null => 1,
            FetchHashKeyName => 'NAME_lc',
        });

my $query = "select c.husband,h.age,c.wife,w.age from couple c, people h, people w where c.husband = h.name and c.wife = w.name";
#my $query = "select c.husband,h.age from couple c, people h where c.husband = h.name ";
my $sth   = $dbh->prepare ($query);
$sth->execute ();
 
while (my $row = $sth->fetchrow_hashref) {
    foreach my $col ( keys %$row ) {
        print $col,"=",$row->{$col},"\t" if defined $row->{$col};
    }
    print "done\n\n";
}
$sth->finish ();

