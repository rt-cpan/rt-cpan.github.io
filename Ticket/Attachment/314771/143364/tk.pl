use 5.008;
use strict;
use warnings;
use Tk;
use Encode;

my $mw = MainWindow->new;
$mw->Entry(-text => decode("iso-8859-9", "рью") )->pack;

MainLoop;