#!/usr/local/bin/perl5.18.1 -w
use strict;
use warnings;
use utf8;	# strict
use Tk;

print "Okay, time to test Hebrew on Tk!\n";

my $htop = MainWindow->new(-title=>"Hebrew Test");

my $lbl = $htop->Label(-text=>"");
my $hjpeg = $htop->Photo( -file => 'hebrew.ppm');
my $ivrit = $htop->Label(-text => "בְּרֵאשִׁית בָּרָא אֱלֹהִים אֵת הַשָּׁמַיִם וְאֵת הָאָֽרֶץ׃\n");
my $english = $htop->Label(
	-text => "In the beginning G-d created the heavens and the earth.\n");

$lbl->pack();
$lbl->configure(-image => $hjpeg);
$ivrit->pack();
$english->pack();


MainLoop;
