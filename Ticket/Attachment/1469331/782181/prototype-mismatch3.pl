#!/usr/bin/env perl
use strict;
use warnings;

package rB;
use Moo::Role;
requires 'mA';
around 'mA' => sub ($$) {
  my $orig = shift;
  return "rB->before();".$orig->(@_)."rB->after();";
};
1;

package cG;
use Moo;
with 'rB';
sub mA($$) {
  my $self = shift;
  my $arg  = shift;
  return $arg;
}
1;

package main;
cG->new()->mA("arg1");
