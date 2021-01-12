#!/usr/bin/env perl

use strict;
use warnings;

use Net::DNS;

my $res = Net::DNS::Resolver->new;
my $p   = $res->send( 'www.net-dns.org' );

my $rr = Net::DNS::RR->new( 'www.net-dns.org.	100	IN	A	213.154.224.135' );

$p->unique_push( answer => $rr );

$p->print;
