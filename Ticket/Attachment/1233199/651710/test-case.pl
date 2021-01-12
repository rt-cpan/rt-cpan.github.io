use warnings;
use strict;

use DBI;

my $count = $ARGV[0];

my $place_holders = join(',', ('?') x $count);

my $sql = <<"EOF";
SELECT   *
FROM     information_schema.tables
WHERE    table_schema IN ( $place_holders)
EOF

my @params = ('test') x $count;

my $dbh = DBI->connect(
    'DBI:mysql:test',
    q{}, q{},
    {
        Callbacks => {
            ChildCallbacks => {
                execute => sub { return; }
            }
        }
    }
);

my $sth = $dbh->prepare($sql);
$sth->execute(@params);
