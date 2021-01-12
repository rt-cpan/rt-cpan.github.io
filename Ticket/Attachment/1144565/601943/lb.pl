#!/usr/bin/perl -w

use strict;
use Tk;
use Test::More 'no_plan';

my $mw = tkinit;
$mw->wmTracing(1);

$mw->geometry('+0+0');
my $lb = $mw->Listbox(-width => 30, -height => 5);
$lb->pack('-expand',1,'-fill','both');
$lb->insert('end','one','two','three','four','five','six','seven',
	    'eight','nine','ten','eleven','twelve','thirteen',
	    'fourteen','fifteen');
$mw->update;
my $geom = $mw->geometry;
my($width, $height) = $geom =~ /(\d+)x(\d+)/;
diag "Old geometry ($width,$height)";
$mw->geometry($width . "x" . ($height-3));
$mw->update;

diag $lb->get(4);

{ diag "wait 1s"; my $x; $lb->after(1000, sub { $x = 1 }); $lb->waitVariable(\$x); } # delay

$lb->see(4);
is $lb->index('@0,0'), 1;

__END__
