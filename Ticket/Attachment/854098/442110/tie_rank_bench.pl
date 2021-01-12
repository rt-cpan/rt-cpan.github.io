#!/usr/bin/perl

use strict;
use Benchmark qw/cmpthese :hireswallclock/;

use Tie::Hash::Rank;

my %hash = ();

for ( my $i = 0 ; $i < 2_000 ; $i++ ) {
    $hash{ 'FooBar' . $i } = int( rand(100_000) % 50_000 );
}

cmpthese(
    10,
    {
        'onstore' => sub {
            tie my %onstore, 'Tie::Hash::Rank', ( RECALCULATE => 'onstore' );
            %onstore = %hash;
            join '', map { $onstore{$_} } keys %onstore;
            untie %onstore;
        },
        'onfetch' => sub {
            tie my %onfetch, 'Tie::Hash::Rank', ( RECALCULATE => 'onfetch' );
            %onfetch = %hash;
            join '', map { $onfetch{$_} } keys %onfetch;
            untie %onfetch;
        },
        'onfetchchange' => sub {
            tie my %onfetchchange, 'Tie::Hash::Rank',
              ( RECALCULATE => 'onfetchchange' );
            %onfetchchange = %hash;
            join '', map { $onfetchchange{$_} } keys %onfetchchange;
            untie %onfetchchange;
        },
    }
);
