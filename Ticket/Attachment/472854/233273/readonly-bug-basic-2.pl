#!perl
use strict;

package TieTest;
sub TIESCALAR {return bless {} }
sub FETCH {return 'DirHandle' }

package main;
use DirHandle;
tie my $CLASS, 'TieTest';
my $handle = $CLASS->new(q{.});
$handle = $CLASS->new(q{.});

