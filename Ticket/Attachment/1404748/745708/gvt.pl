#!/usr/bin/env perl

use strict;
use warnings;
use GraphViz2;

my $g = GraphViz2->new(
    global => { directed =>1 },
);

$g->add_node( name => $_ ) for 1..2;
$g->add_edge( from => 1, to =>2 );

$g->run( output_file => 'empty_labels.svg' );

print $g->dot_input();
