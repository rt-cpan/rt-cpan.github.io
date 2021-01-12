#!/usr/bin/perl

use warnings;
use strict;

use IO::Socket;
use IO::Socket::INET;
use Test;

plan tests => 8;

my $listener = IO::Socket::INET->new(Listen => 1,
                                     LocalAddr => '127.0.0.1',
                                     Proto => 'tcp');
ok(defined($listener));

my $port = $listener->sockport();

my $p = $listener->protocol();
ok(defined($p));
my $d = $listener->sockdomain();
ok(defined($d));
my $s = $listener->socktype();
ok(defined($s));

my $cpid = fork();
ok(defined($cpid));
if (0 == $cpid) {
  # the child:
  sleep(1);
  my $connector = IO::Socket::INET->new(PeerAddr => '127.0.0.1',
                                        PeerPort => $port,
                                        Proto => 'tcp');
  exit(0);
};

my $new = $listener->accept();

ok($new->protocol(), $p);
ok($new->sockdomain(), $d);
ok($new->socktype(), $s);

wait();
