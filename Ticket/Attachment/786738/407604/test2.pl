use Test::More;
use Devel::Peek;

select STDERR;

print  "Perl = $]\n";
print "Test::More = ", Test::More->VERSION, "\n\n";


my $obj = [ 'snake' ];
my $array = [ 'snake' ];

print "Before (\$array):\n";
Dump $array;

print "Before (\$obj):\n";
Dump $obj;

eq_array( $array, $obj );

print "\nAfter (\$array):\n";
Dump $array;

print "\nAfter (\$obj):\n";
Dump $obj;

