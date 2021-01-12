#!/usr/bin/perl

use warnings;
use strict;

use IO::Socket;
use IO::Socket::INET;
use Test;

plan tests => 7;

my $listener = IO::Socket::INET->new(LocalAddr => '127.0.0.1',
                                     Proto => 'udp');
ok(defined($listener));

my $p = $listener->protocol();
ok(defined($p));
my $d = $listener->sockdomain();
ok(defined($d));
my $s = $listener->socktype();
ok(defined($s));

my $new = IO::Socket::INET->new_from_fd($listener->fileno(), 'r+');

ok($new->protocol(), $p);
ok($new->sockdomain(), $d);
ok($new->socktype(), $s);
