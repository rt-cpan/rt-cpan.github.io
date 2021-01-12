use strict;
use warnings;
use DBI;
use DBD::ODBC;

DBI->trace(15);
#DBI->trace(DBD::ODBC->parse_trace_flags('odbcconnection|odbcunicode'));
# production 'DBI:ODBC:driver={SQL Server};Server=SQLVS2;Database=CS90PRD'
# empty test 'DBI:ODBC:driver={SQL Server};Server=avm01;Database=Bruce_test'
my $dbh = DBI->connect( 'DBI:ODBC:driver={SQL Server};Server=avm01;Database=Bruce_test',
                        undef, undef, {RaiseError=>1,PrintError=>0}
                        )
                        or croak( "Can't connect to PSDB: $DBI::errstr" );

$dbh->trace($dbh->parse_trace_flags('SQL|odbcconnection'));
$dbh->trace($dbh->parse_trace_flags('1|odbcunicode'));

print "Using DBI $DBI::VERSION and DBD::ODBC $DBD::ODBC::VERSION\n";

my $classes_sql = q{
    SELECT TOP 2
        S.CLASS_NBR,
        (SELECT 
            COUNT(R.EMPLID)
        FROM 
            PS_CER_ROS_STD_VW AS R
        WHERE
            R.STRM = S.STRM
            AND R.CLASS_NBR = S.CLASS_NBR
            AND R.STDNT_ENRL_STATUS = 'E'
            AND R.CRSE_GRADE_OFF <> 'W'
            AND R.GRADING_BASIS_ENRL <> 'AUD'
        )
    FROM
        PS_CER_ROS_SCH_VW AS S
    WHERE
        S.STRM = ? 
};

my $term_code = 1089;

my $classes = $dbh->prepare( $classes_sql );
$classes->execute( $term_code );

my $count = 0;
while (my ( $class_nbr, $enrl_tot ) = $classes->fetchrow_array ) {
    $count++;
}

print "Count = $count";
