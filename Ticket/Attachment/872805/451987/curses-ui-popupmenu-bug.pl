#!/usr/bin/env perl
use strict;
use warnings;

use Curses::UI;

my $cui = new Curses::UI;
$cui->set_binding( sub { exit }, "q" );

## create first window
my $win1 = $cui->add( win1 => 'Window', -border => 1 );
$win1->add( help => 'Label', -text => "'q' to quit");
$win1->add( pop1 => 'Popupmenu',
            -x => 3, -y => 3,
            -border => 1,
            -values => [qw(eenie meenie minie moe)],
            -selected => 3 );


## create second window
my $win2 = $win1->add( win2 => 'Window',
                       -x => 20, -y => 10,
                       -width => 50, -height => 20,
                       -border => 1);

$win2->add( pop2 => 'Popupmenu',
            -x => 4, -y => 2,
            -border => 1,
            -values => [qw(fee fie fo fum)],
            -selected => 1 );


## create third window
my $win3 = $win2->add( win3 => 'Window',
                       -x => 5, -y => 5,
                       -width => 20,
                       -height => 10,
                       -border => 1 );

$win3->add( pop3 => 'Popupmenu',
            -x => 2, -y => 2,
            -border => 1,
            -values => [qw(foo bar baz blech)],
            -selected => 2 );

$cui->mainloop;

exit;
