use warnings;
use strict;

use GD::Graph::pie;
use GD::Graph::colour;

# Common dataset
my @data=(
	['Green','Amber',  'Red'],
	[      1,      0,     2 ]
);

# Produce a 3D graph with the right color!  (3D is default)
my $graph3 = GD::Graph::pie->new(200, 200);
$graph3->set( dclrs => [ qw(green yellow red) ], '3d' => 1 );
my $gd3 = $graph3->plot(\@data) or die $graph3->error;
open IMG, '>', 'PieTest3D-good.png' or die $!;
binmode IMG;
print IMG $gd3->png;
close IMG;

# Produce a FLAT (non-3D) graph with the WRONG color (green is plotted as amber color!)
my $graph2 = GD::Graph::pie->new(200, 200);
$graph2->set( dclrs => [ qw(green yellow red) ], '3d' => 0 );
my $gd2 = $graph2->plot(\@data) or die $graph2->error;
open IMG, '>', 'PieTest2D-bad.png' or die $!;
binmode IMG;
print IMG $gd2->png;
close IMG;