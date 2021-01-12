#!/usr/bin/env perl

use strict;
use warnings;

use Mail::Box::Manager;

warn "$Mail::Box::VERSION\n";
my $mgr = new Mail::Box::Manager;
my $arg = shift(@ARGV);
my $inbox = $mgr->open(folder => $arg, access => 'r');
my $outbox = $mgr->open(folder => "out-$arg",  access => 'w', create => 1);
$mgr->copyMessage($outbox, $_) for $inbox->messages;
$mgr->closeAllFolders;
