#!/usr/bin/perl -w

use Devel::CallParser;

sub f {
  my $arg = shift;

  { my $arg; } # ???
  print $arg ? "ok\n" : "not ok\n";
}

f(1);
