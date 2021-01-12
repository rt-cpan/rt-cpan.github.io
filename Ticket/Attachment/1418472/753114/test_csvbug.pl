#!/bin/perl -w
use strict;

#------------------------------------------------------------------
#
# Example program to demonstrate a problem in DBD::CSV
#
# bind variables are probably not bound in the correct order to the
# '?'-plasholders in the prepared SQL statement
#
# This program expects a csv table 'abc.csv' in the same directory
# with one line (A=1, B=2, C=3)
#
# It searches for rows where either A or B equals 1 an C=3
# There should be one result (the only row in abc.csv),
# but nothing it found
#
#-------------------------------------------------------------------

# Load DBI modules, test for latest version

    use DBI            1.631;
    use DBD::CSV       0.44;
    use SQL::Statement 1.405;

    use Data::Dumper;

# Open the database(assuming that abc.cvs is stored in the current working directory),
# set some defaults

    my $dbh = DBI->connect("DBI:CSV:f_dir=.");
    if (! $dbh) {
	print STDERR $dbh->errstr();
	exit 1;
    }

    $dbh->{f_ext}	   = '.csv';
    $dbh->{csv_sep_char}   = ",";
    $dbh->{csv_quote_char} = '"';
    $dbh->{csv_eol}        = "\n";

# Prepare the search statement

    my $sth = $dbh->prepare(<<_SQLEND_);
select * 
from   abc
where  (A=? or B=?) and C=?
_SQLEND_

    print "\n\n";

# Execute, and print trhe result

    # (A=1 or B=1) and C=3
    # Should give one row as result, but finds nothing
    # (probably executes A=1 and C=1)

    $sth->execute(1,1,3) or print STDERR $dbh->errstr();

    my $result = $sth->fetchall_arrayref({});
    print "Result for (A=1 or B=1) and C=3\n(should be one row):\n",
	  Dumper($result);

    print "\n\n";

    # (A=1 or B=3) and C=99
    # Should give no results, but finds one row
    # (probably executes A=1 and C=3

    $sth->execute(1,3,99) or print STDERR $dbh->errstr();

    $result = $sth->fetchall_arrayref({});
    print "Result for (A=1 or B=3) and C=99\n(should be empty):\n",
	  Dumper($result);

    $sth->finish;
