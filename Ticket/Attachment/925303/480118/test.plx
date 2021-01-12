#!/usr/bin/env perl


{
    package Foo;
    use Moose;
    use Moose::Util::TypeConstraints;

    subtype 'Label', as 'Str';
    coerce  'Label', from 'Undef',  via { "" };
    coerce  'Label', from 'Object', via { "$_" };

    has this =>
      is        => "rw",
      isa       => "HashRef[Label]",
      coerce    => 1,
      default   => sub { {} }
    ;
}

use Test::More tests => 1;

my $obj = Foo->new( this => { foo => undef } );
is_deeply $obj->this, { foo => "" };
