#!/usr/bin/perl -w

use strict;
use warnings;

=head1 NAME

    DBD::Oracle bug test in counting not-null values in procedure 

=head1 PLSQL-Procedure for this test 

    CREATE OR REPLACE PROCEDURE bugtest1(
        list OUT SYS_REFCURSOR
    )
    AS
    BEGIN
        OPEN list FOR
            SELECT COUNT(null) FROM dual;
    END;
    /

=cut 

use DBI;
use DBD::Oracle qw(:ora_types);

my $dbh = DBI->connect("dbi:Oracle:test",
                        "test", "test",
                        { AutoCommit => 0, RaiseError => 1, PrintError => 1, ora_verbose => 0 }
                    );

# Direct fetch from select works fine: 

my $sth = $dbh->prepare('SELECT COUNT(null) FROM dual');
$sth->execute;
print "result1:\n";
while (my @row = $sth->fetchrow_array) {
    print " row: @row\n";
}
print "\n\n";

# but fetch from cursor opened in procedure does not work 
# if SELECT contains COUNT(column_with_null_values) expression 

$sth = $dbh->prepare('BEGIN bugtest1(list => :list); END;');
$sth->bind_param_inout(':list', \my $list, 0, {ora_type => ORA_RSET});
$sth->execute;

print "result2:\n";
while ( my @row = $list->fetchrow_array ) {
    print " row: @row\n";
}
print "\n\n";

