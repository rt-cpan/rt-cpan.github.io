#!/usr/bin/perl -w

use Graph;
use Test::More;
use strict;

plan tests => 3;

print STDERR "# Graph v$Graph::VERSION\n";

my $graph = Graph->new( multiedged => 1, undirected => 1 );

isnt ($graph->multiedged(), 0, 'is multiedged');

my $from = 'Berlin'; my $to = 'Bonn';

my $id = $graph->add_edge_get_id($from, $to);
is ("$graph", "Berlin=Bonn", 'only one edge');

print STDERR "# edge ID is $id\n";

print STDERR "# add attribute for edge $from $to\n";
$graph->set_edge_attributes_by_id($from, $to, $id, { color => 'silver' } );

is ("$graph", "Berlin=Bonn", 'only one edge');
