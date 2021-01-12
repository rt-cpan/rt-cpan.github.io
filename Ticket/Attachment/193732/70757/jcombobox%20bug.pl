#!/usr/bin/perl -w
use strict;

use Tk;
use Tk::JComboBox;

my $jcbDir;
my $jcbSelected = 'a';
my @history_table = ("a","b","c");
my $top = MainWindow->new();
$jcbDir = $top->JComboBox(
  -mode => 'readonly', -textvariable => \$jcbSelected,
  -choices => \@history_table,
);
$jcbDir->pack(
  -side => 'left', -expand => 0, -fill => "none",
);
$jcbDir->configure(-state => 'disabled');
#
# Following statement causes control to look
# disabled, yet it still responds to events
#
$jcbDir->configure(-state => 'disabled');
$jcbDir->configure(-state => 'normal');
MainLoop();
  
exit 1;
