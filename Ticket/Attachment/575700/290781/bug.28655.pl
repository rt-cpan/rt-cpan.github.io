use strict;
use warnings;
use DBD::DB2;

our $N ||= 1; 
our $P ||= 0;   # print flag

my $DATABASE = "foo";
my $USERID   = "bar";
my $PASSWORD = "*********";
my $dbh = DBI->connect("dbi:DB2:$DATABASE", "$USERID", "$PASSWORD", {PrintError => 0});
my $query =  q{select foo from bar where } . join(q{ and }, ('id>?') x $N);
print $query if $P;
my $sth = $dbh->prepare($query);

__END__
