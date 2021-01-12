#!/usr/bin/perl 

use v5.10;
use strict;
use warnings;

use Net::SSLeay;
use threads;

#$Net::SSLeay::trace = 2;

my $i = 1;

while (1) {
    threads->new('create_thread') for (1 .. 3);

    foreach (threads->list) {
        $_->join;
    }

    say "loop(", $i++, ") ", '-' x 20;
} ## end while (1)

sub create_thread {
    my $tid = threads->tid;

    threads->set_thread_exit_only(1);

    print "\tcreate_thread($tid)";

    sleep(rand(3));

    my ($page, $response, %reply_headers)
        = Net::SSLeay::get_https('localhost', 443, '/');

    say join " ", "\tresp-code:", $response, "length:", length($page);

    threads->exit(0);
} ## end sub create_thread

