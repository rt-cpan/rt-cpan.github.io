#!/usr/bin/perl -w

use strict;
use warnings;
use DBI qw();
use DBD::Oracle qw();

my $uidpwd = 'username/password@dbsid';
my $dbh = DBI->connect('dbi:Oracle:', $uidpwd, '', {RaiseError => 1, PrintError => 0});

select(STDOUT);
$| = 1;

print 'create table ...';
$dbh->do(q(
    create table sb_blob (id number, bcol blob)
    ));
print "done\n";

print 'create synonym ...';
$dbh->do(q(
    create synonym sb_blob_x for sb_blob
    ));
print "done\n";

print 'insert (direct) ...';
my $sth = $dbh->prepare(q(
    insert
    into    sb_blob (id, bcol)
    values  (:id, :blob)
    ));
$sth->bind_param(':id', 10);
$sth->bind_param(':blob', 'xxxxx', {ora_type => DBD::Oracle::ORA_BLOB});
$sth->execute;
print "done\n";

print 'insert (synonym) ...';
$dbh->trace(3);
$sth = $dbh->prepare(q(
    insert
    into    sb_blob_x (id, bcol)
    values  (:id, :blob)
    ));
$sth->bind_param(':id', 20);
$sth->bind_param(':blob', 'yyyyy', {ora_type => DBD::Oracle::ORA_BLOB});
$sth->execute;
print "done\n";

END {
    if (defined $dbh) {
        $dbh->trace(0);
        $dbh->{RaiseError} = 0;
        $dbh->do(q(drop synonym sb_blob_x));
        $dbh->do(q(drop table sb_blob));
        $dbh->disconnect;
    }
}
