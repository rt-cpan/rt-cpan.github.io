# This is -*-Perl-*- code#
# Bioperl Test Harness Script for Modules#
# $Id: protgraph.t,v 1.1 2004/03/13 23:45:32 radams Exp

use vars qw($NUMTESTS $DEBUG $ERROR);
use strict;
$DEBUG = $ENV{'BIOPERLDEBUG'} || 0;

BEGIN {
	# to handle systems with no installed Test module
	# we include the t dir (where a copy of Test.pm is located)
	# as a fallback
	eval { require Test; };
	$ERROR = 0;
	if ( $@ ) {
		use lib 't';
	}
	use Test;
	$NUMTESTS  = 10;
	plan tests => $NUMTESTS;
	eval { require Graph; };
	if ( $@ ) {
		warn("Perl's Graph required by the bioperl-network package, skipping tests");
		$ERROR = 1;
	}
}

END {
	foreach ( $Test::ntest..$NUMTESTS) {
		skip("Missing dependencies. Skipping tests",1);
	}
}
exit 0 if $ERROR == 1;

require Graph::Undirected;
require Graph::Traversal::DFS;
require Digest::MD5;

#
# The purpose of these tests is to check to see if particular 
# bugs have been fixed in Perl's Graph
#
my $g = Graph::Undirected->new(refvertexed => 1);

ok 1;

my $seq1 = Digest::MD5->new;
my $seq2 = Digest::MD5->new;
my $seq3 = Digest::MD5->new;
my $seq4 = Digest::MD5->new;

my $str = "ljfgouyouiyougs";

$g->add_vertices($seq1,$seq2,$seq3,$seq4);
$g->add_edges([$seq1,$seq2],[$seq3,$seq4],[$seq3,$seq2]);

my @vs = $g->vertices; # OK
ok $vs[0]->add($str);

my $c = $g->complete; # OK
@vs = $c->vertices;
ok $vs[0]->add($str);

my $comp = $g->complement; # OK
@vs = $comp->vertices;
ok $vs[0]->add($str);

@vs = $g->interior_vertices; # OK
ok $vs[0]->add($str);

my $apsp = $g->APSP_Floyd_Warshall;
@vs = $apsp->path_vertices($seq1,$seq4); # OK
ok $vs[0]->add($str);

my $seq = $g->random_vertex; # OK
ok $seq->add($str);

my @rts = $g->articulation_points;
ok @rts;

my $t = Graph::Traversal::DFS->new($g);
$t->dfs;
@vs = $t->seen;
for my $seq (@vs) {
	ok $seq->add($str); # NOT OK in version .73
}

@vs = $g->articulation_points; 
ok $vs[0]->add($str); # OK in version .70
ok scalar @vs, 2;

my @cc = $g->connected_components;
for my $ref (@cc) {
	for my $seq (@$ref) {
		ok $seq->add($str); # OK in version .70
	}
}

my @bs = $g->bridges;
ok $bs[0][0]->add($str); # NOT OK in version .73

my $cg = $g->connected_graph;
@vs = $cg->vertices;
ok $vs[0]->add($str); # NOT OK in version .73 - is my usage correct?

my @spd = $g->SP_Dijkstra($seq1,$seq4); # OK in version .70

my @spbf = $g->SP_Bellman_Ford($seq1,$seq4); # OK in version .70

__END__
