#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 3;
use_ok('Template');
use_ok('Template::Stash::XS');
    
diag("Template version: $Template::VERSION");

# Note that only the XS stash fails..
my $tt2 = Template->new( STASH => Template::Stash::XS->new );
$tt2->process(
    \'[% crasher() %]',
    { crasher => sub { eval "use Nonexistent::Class" } },
) or warn "Failed to process..\n";

ok(1, 'Reached end of test without crashing');
