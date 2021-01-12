use strict;
use warnings;
use DBI;

use Rosters2::Globals;


my $college = 'CER90'; 

DBI->trace(15);

my $dbh = DBI->connect( $config{$college}->{db},
                        $config{$college}->{login},
                        $config{$college}->{password},
                        {RaiseError=>1,PrintError=>0}
                        )
                        or croak( "Can't connect to PSDB: $DBI::errstr" );

$dbh->trace($dbh->parse_trace_flags('SQL|odbcconnection'));
$dbh->trace($dbh->parse_trace_flags('1|odbcunicode'));

print "Using DBI $DBI::VERSION and DBD::ODBC $DBD::ODBC::VERSION\n";
print "DB = $config{$college}->{db}\n";

my $classes_sql = q{
    SELECT
        S.CLASS_NBR,
        (SELECT COUNT(R.EMPLID)
        FROM PS_CER_ROS_STD_VW AS R
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
MEETING:
while (my ( $class_nbr, $enrl_tot ) = $classes->fetchrow_array ) {
    $count++;
}

print "Count = $count";
