# build roster database, test select statement

use strict;
use warnings;
use DBI;


my $dbh = DBI->connect( 'DBI:ODBC:driver={SQL Server};Server=avm01;Database=Bruce_test' )
            or die "Can't connect to DB: $DBI::errstr";


opendir( DIR, '.' );
my @files = readdir(DIR); 
closedir( DIR );

foreach my $file (@files) {
    next if $file !~ m{.txt$}ix;
    print "Processing $file\n";
    process( $file);
}


sub process {
    my $file = shift;
    
    my $sql;
    my $line_number = 0;
    open( my $fh, '<', $file );
    while (my $line = <$fh>) {
        $line_number++;
        #print "$line_number: $line";
        next if $line =~ m{^GO}ix;
        next if $line =~ m{^SET}ix;
        $line =~ s{\[dbo\]\.}{}igx;
        $line =~ s{PSDATETIME|PSDATE|PSTIME}{datetime}gix;
        #$line =~ s{PSDATE}{datetime}gix;
        #$line =~ s{PSTIME}{datetime}gix;
        $sql .= $line;
    }
    #print "SQL: $sql";
    $dbh->do( $sql );
    return;
}