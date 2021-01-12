#!/usr/bin/perl -w

use strict;
use Test::More tests => 5;

{
    package LineSegment;

    use Moose;

    has start => (
        is      => 'ro',
        isa     => 'Num',
    );
    has end => (
        is      => 'ro',
        isa     => 'Num',
    );
    has length => (
        is      => 'ro',
        isa     => 'Num',
        lazy    => 1,
        default => sub {
            ::is( $_[0]->start, 4,      'start populated in default' );
            ::is( $_[0]->end,   10,     'end populated in default'   );
            return abs($_[0]->end - $_[0]->start);
        },
    );
}

my $obj = LineSegment->new(
    start       => 4,
    end         => 10
);

is $obj->start, 4,      "start";
is $obj->end,   10,     "end";
is $obj->length, 6,     "length";

