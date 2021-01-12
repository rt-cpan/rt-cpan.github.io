#!/usr/bin/env perl
use strict;
use warnings FATAL => 'all';
use Test::Most;

{
    package Foo;
    use Moose;
    has foo => ( traits => ['Counter'] );
    no Moose;
    1;
}

TODO: {
    local $TODO = 'defaults do not appear to work';

    my $foo = Foo->new();

    can_ok $foo, 'inc_foo';
}

done_testing();
