#!/usr/bin/env perl

use strict;
use warnings;

use Mail::Box::Manager;

my $mgr = Mail::Box::Manager->new;
my $arg = shift(@ARGV);
my $inbox = $mgr->open(folder => $arg, access => 'r');
my $outbox = $mgr->open(folder => "out-$arg",  access => 'w', create => 1, save_on_exit => 1);
$mgr->copyMessage($outbox, $_) for $inbox->messages;
warn scalar($outbox->messages) . " messages have been copied, but they will be cleared when the file is closed\n";
