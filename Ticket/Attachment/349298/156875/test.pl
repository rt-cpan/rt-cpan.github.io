#!/usr/bin/perl
use strict;
use warnings;
use Mail::Box::Manager;

my $mgr = Mail::Box::Manager->new( access => 'r' );
my $f = $mgr->open( folder => "test.mbox" );

select STDERR;

print '1: ', $f->[0]->get("to"), "\n";
print '2: ', $f->[0]->get("no-such-header"), "\n";
print '3: ', $f->[0]->get("reply-to"), "\n";
print '4: ', $f->[0]->get("subject"), "\n";

print '5: ', $f->[0]->study("to"), "\n";
print '6: ', $f->[0]->study("no-such-header"), "\n";
print '7: ', $f->[0]->study("reply-to"), "\n";
print '8: ', $f->[0]->study("subject"), "\n";



