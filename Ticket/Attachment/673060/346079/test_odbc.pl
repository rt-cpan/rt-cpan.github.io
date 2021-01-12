# test DBD::ODBC problem
use strict;
use warnings;

use Rosters2::Globals qw( %CONFIG $EMPTY );
use DBI;
use DBD::ODBC;

DBI->trace(DBD::ODBC->parse_trace_flags('odbcconnection|odbcunicode|15'));

my $college = 'CER90';
my $dbh = DBI->connect( 'DBI:ODBC:driver={SQL Server};Server=avm01;Database=test' )
                        or croak( "Can't connect to DB: $DBI::errstr" );

my $request_sql = <<'END_REQUEST_SQL';
    SELECT 
        (SELECT XLATSHORTNAME FROM PSXLATITEM X
            WHERE FIELDNAME = 'ENRL_REQ_DETL_STAT'
            AND FIELDVALUE = D.ENRL_REQ_DETL_STAT
            AND X.EFF_STATUS = 'A'
            AND EFFDT = (
                SELECT MAX(X2.EFFDT) FROM PSXLATITEM X2
                WHERE X.FIELDNAME = X2.FIELDNAME 
                AND X.FIELDVALUE = X2.FIELDVALUE 
                AND X2.EFF_STATUS = 'A'
                )
        )
    FROM
        PS_ENRL_REQ_DETAIL AS D
    WHERE
        D.STRM = ? 
END_REQUEST_SQL



my $request = $dbh->prepare( $request_sql );

print( "Execute DBI = $DBI::VERSION, DBD::ODBC = $DBD::ODBC::VERSION\n" );
$request->execute( 1099 );
