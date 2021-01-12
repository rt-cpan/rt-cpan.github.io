use Devel::Size qw( total_size );
use Devel::Peek qw( Dump );

my @arr;
Dump \@arr;
print total_size(\@arr), "\n";
Dump \@arr;
