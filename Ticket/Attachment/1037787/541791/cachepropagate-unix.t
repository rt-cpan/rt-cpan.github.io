#!/usr/bin/perl

use warnings;
use strict;

use IO::Socket;
use IO::Socket::UNIX;
use Test;

plan tests => 15;

my $socketpath = './testsock';

# start testing stream sockets:

my $listener = IO::Socket::UNIX->new(Type => SOCK_STREAM,
                                     Listen => 1,
                                     Local => $socketpath);
ok(defined($listener));

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
  my $connector = IO::Socket::UNIX->new(Peer => $socketpath);
  exit(0);
};

my $new = $listener->accept();

ok($new->protocol(), $p);
ok($new->sockdomain(), $d);
ok($new->socktype(), $s);

unlink($socketpath);
wait();

# now test datagram sockets:

$listener = IO::Socket::UNIX->new(Type => SOCK_DGRAM,
                                  Local => $socketpath);
ok(defined($listener));

$p = $listener->protocol();
ok(defined($p));
$d = $listener->sockdomain();
ok(defined($d));
$s = $listener->socktype();
ok(defined($s));

$new = IO::Socket::UNIX->new_from_fd($listener->fileno(), 'r+');

ok($new->protocol(), $p);
ok($new->sockdomain(), $d);
ok($new->socktype(), $s);

unlink($socketpath);
