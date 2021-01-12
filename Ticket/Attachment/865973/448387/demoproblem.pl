#!/usr/bin/perl

use IO::Socket::SSL 1.35 qw(debug3);
use Net::SSLeay;
use LWP::Simple;

use warnings;
use strict;

# perversely reject connections 10% of the time, based on the wall clock:
sub verify {
  my $x = (time() % 10);
  if ($x > 0) {
    printf("verify called (%d ok)\n", $x);
    return 1;
  } else {
    printf("verify called (%d nope)\n", $x);
    return 0;
  }
}

IO::Socket::SSL::set_ctx_defaults(
                                  verify_callback => sub { return verify(@_); },
                                  verify_mode => 0x03,
                                  # this argument is irrelevant, but currently required -- see http://bugs.debian.org/606243
                                  ca_path => '.',
                                 );

my $content = LWP::Simple::get('https://encrypted.google.com/');
if (defined($content)) {
  printf("got %d characters\n", length($content));
} else {
  printf("connection failed\n");
}
