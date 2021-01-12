use strict;
use warnings;
use 5.10.0;
use Tk;

my $candsize = 7;    # size of a candidate square (pixels)
my $mw = MainWindow->new();
my	$canv = $mw->Canvas()->pack();
	my $x = 3;
	foreach my $w (0 .. 2) {
		$canv->createRectangle($x, 3, $x + $candsize - 1, 3 + $candsize - 1,
					-fill => 'green', -width => $w,
					-tags => "w$w",
				);
		say "-width => $w, coords: ", join(',', $canv->coords("w$w"));
		$x += 10;
	}
	MainLoop();

