#!/usr/bin/perl -w

use DBI;

# connect to db:
my $connstring = "dbi:ODBC:".
		    "Driver=SQL Server;".
		    "Server=.;".
		    "Database=testperlodbc;".
		    "Trusted_Connection=yes";

my $dbh = DBI->connect($connstring, undef, undef,
			    {   AutoCommit          => 1,
				RaiseError          => 1,
				PrintError          => 1,
			    });

my $rv;

# cleanup
eval {
    $rv = $dbh->do(qq{DROP TABLE EventLog});
    $rv = $dbh->do(qq{DROP TABLE ComputerSlice});
};

# construct tables:
$rv = $dbh->do(qq{
	    CREATE TABLE ComputerSlice (
		ComputerSliceID         BIGINT PRIMARY KEY,
		ComputerIDC		VARCHAR(64)
	    )
	});

$rv = $dbh->do(qq{
	    CREATE TABLE EventLog (
		EventLogID              BIGINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
		ComputerIDC		VARCHAR(64),
		EventMessage            VARCHAR(8000)
	    )
	});

# these are values to work on:
my $evmsg = "X" x 2001;		# THIS IS IT; "X" x 2000 works ok, x 2001 will fail; however, value goes to column VARCHAR(8000)
my $compsliceid = 1;
my $compsliceidc = "xxx";

# support data
$rv = $dbh->do(qq{  INSERT INTO ComputerSlice (ComputerSliceID, ComputerIDC)
		    VALUES (?, ?)
		},
		undef,
		$compsliceid, $compsliceidc);

# this one succeedes:
$rv = $dbh->do(qq{  INSERT INTO EventLog (ComputerIDC, EventMessage)
		    VALUES (?, ?)
		},
		undef,
		$compsliceidc, $evmsg );

# and this one will fail:
$rv = $dbh->do(qq{  INSERT INTO EventLog (ComputerIDC, EventMessage)
		    SELECT cs.ComputerIDC, ?
		    FROM ComputerSlice AS cs
		    WHERE cs.ComputerSliceID = ?
		},
		undef,
		$evmsg, $compsliceid );

$dbh->disconnect();

#### END OF DEMO CODE ####

# version info:

# FAILS ON EG.:
# sql server ver: Microsoft SQL Server 2008 R2 (RTM) - 10.50.1600.1 (X64)
# sql server native client version: 10.50.1600.1
# perl env: Strawberry perl v5.12.1.0 (x64), DBI v1.613, DBD::ODBC v1.25
#      and: cygwin 1.7.1, perl v1.5.10.0, DBI v1.615, DBD::ODBC v1.25

# sql server ver: Microsoft SQL Server 2005 - 9.00.3042.00 (Intel X86)  
# sql server native client version: 2005.90.3042.00
# perl env: Strawberry perl v5.12.1.0 (x86), DBI v1.613, DBD::ODBC v1.24
#      and: Active perl v5.12.2.1202 (x86), DBI v1.613, DBD::ODBC v1.24

# sql server ver: Microsoft SQL Server  2000 - 8.00.760 (Intel X86)
# client driver ver: 2000.85.1117.00
# perl env: Strawberry perl v5.10.0.5 (x86), DBI v1.607, DBD::ODBC v1.21
