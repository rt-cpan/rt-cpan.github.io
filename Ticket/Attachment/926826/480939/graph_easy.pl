#!/usr/bin/perl

use strict;
use warnings;
use Graph::Easy;

my %dialog = (
    start    => [ qw/software schulung/ ],
    software => [qw/referenzen kompetenz/],
    referenzen => [qw/start/],
);

my $graph = Graph::Easy->new;

for my $page ( keys %dialog ) {
    for my $next ( @{ $dialog{$page} } ) {
        $graph->add_edge( $page, $next );
    }
}

if ( open my $out, '>', 'easy.svg' ) {
    print $out $graph->as_svg({
        standalone => 1,
    });
}

