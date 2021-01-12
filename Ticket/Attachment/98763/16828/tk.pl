use Tk;
$mw=tkinit;
$bla = ".rtsrehc\374lB";
$c=$mw->Canvas->pack;
#$c->createText(100, 100, -text => $bla); # works
$c->createText(100, 100, -text => substr($bla,0)); # does not work
MainLoop;
