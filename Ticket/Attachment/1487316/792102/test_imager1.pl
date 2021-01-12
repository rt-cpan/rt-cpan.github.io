use strict;
use warnings;
use Imager;

my $i = Imager-> new( xsize => 100, ysize => 100 );
$i-> box( box => [ 0, 0, 49, 49 ], filled => 1 );
$i-> box( box => [ 50, 50, 99, 99 ], filled => 1 );
my $j = $i-> copy();
$i-> flood_fill( x => 0, y => 0, color => 'red' );
$i-> write( file => '1.png' );
$j-> flood_fill( x => 99, y => 99, color => 'red' );
$j-> write( file => '2.png' );

__END__
            
