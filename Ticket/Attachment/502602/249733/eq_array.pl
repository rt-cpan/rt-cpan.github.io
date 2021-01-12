use YAML::Tiny qw( DumpFile LoadFile );
use Test::More;

use Clone qw( clone );
use Data::Dumper;

use Devel::Peek;

my $obj = [ 'snake' ];

DumpFile( 'foo', $obj );

my $array = LoadFile( 'foo' );

print STDERR "Before (\$array):\n";
Dump $array;

print STDERR "Before (\$obj):\n";
Dump $obj;

eq_array( $array, $obj );

print STDERR "\nAfter (\$array):\n";
Dump $array;

print STDERR "\nAfter (\$obj):\n";
Dump $obj;

print STDERR "\nCloned \$array:\n";
print STDERR Dumper clone( $array );

print STDERR "\nCloned \$obj:\n";
print STDERR Dumper clone( $obj );


