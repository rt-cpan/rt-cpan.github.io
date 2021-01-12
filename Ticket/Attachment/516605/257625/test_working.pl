use strict;
use warnings;
use DBI;

use Rosters2::Globals;


my $college = 'CER90'; 

my $dbh = DBI->connect( $config{$college}->{db},
                        $config{$college}->{login},
                        $config{$college}->{password},
                        {RaiseError=>1,PrintError=>0}
                        )
                        or croak( "Can't connect to PSDB: $DBI::errstr" );

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
	)
    FROM
        PS_CER_ROS_SCH_VW AS S
    WHERE
        S.STRM = ? 
};


my $term_code = 1089;
        
#print "Execute $DBI::VERSION $classes_sql with $term_code\n" ;
my $classes = $dbh->prepare( $classes_sql );
$classes->execute( $term_code );

my $count = 0;
MEETING:
while (my ( $class_nbr, $enrl_tot ) = $classes->fetchrow_array ) {
    $count++;
}

print "Count = $count";
