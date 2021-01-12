#!/usr/bin/perl

use Tk;
$mw = tkinit;
keep_on_top($mw);
MainLoop;

sub keep_on_top {
    my $w = shift;
    my($wrapper) = $w->toplevel->wrapper;
    eval {
	if (!grep { $_ eq '_NET_WM_STATE_STAYS_ON_TOP' } $w->property('get', '_NET_SUPPORTED', 'root')) {
	    die "_NET_WM_STATE_STAYS_ON_TOP not supported";
	}
	$w->property('set', '_NET_WM_STATE', "ATOM", 32,
		     ["_NET_WM_STATE_STAYS_ON_TOP"], $wrapper);
    };
    if ($@) {
	warn $@;
	0;
    } else {
	1;
    }
}

