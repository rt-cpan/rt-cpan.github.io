#!/usr/bin/perl

use strict;
use warnings;

use Net::SSH2;

package Net::SSH2;

my $host = 'localhost';
my $key = '/home/salva/.ssh/id_rsa',
my $user = 'salva';

system "ssh -l $user -i $key $host echo hello from remote host";

system "ls -l $key*";

warn "before ctor";
my $ssh2 = Net::SSH2->new();

warn "before connect";
$ssh2->connect("localhost", 22);

warn "before auth";
$ssh2->auth(privatekey => $key,
            publickey => "$key.pub",
            username => $user,
           )
    or warn "connection failed";

warn "the end"
