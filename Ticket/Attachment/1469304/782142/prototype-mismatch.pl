package rB;
use Moo::Role;
requires 'mA';
around 'mA' => sub ($) {
  my $orig = shift;
  return "rB->before();".$orig->(@_)."rB->after();";
};
1;

package cG;
use Moo;
#with 'rB';
sub mA($) {
  my $self = shift;
  return "cG->mA();";
}
1;

package cI;
use Moo;
extends 'cG';
around 'mA' => sub ($) {
  my $orig = shift;
  return "rB->before();".$orig->(@_)."rB->after();";
};
1;

package main;
use Test::More;
is( cI->new()->mA(), "rB->before();cG->mA();rB->after();", 'correct wrapping' );
1;

done_testing();

