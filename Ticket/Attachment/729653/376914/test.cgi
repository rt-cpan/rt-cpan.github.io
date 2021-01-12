#!/usr/bin/perl
use strict;
use warnings;

use Carp ();
use Fcntl ':seek';
use Net::OpenSSH;

*Net::OpenSSH::croak = \&Carp::confess;

print "Content-Type: text/plain\n\n";

my $ssh;
my $answer = eval {
    open IN, "<", "/dev/null"; # dummy

    $ssh = Net::OpenSSH->new("localhost",
        user => "username",
        passwd => "123456",
        master_opts => [-o => "StrictHostKeyChecking=no"],
        default_stdin_fh => \*IN,
    );

    my (undef, $out, undef, $pid) = $ssh->open_ex({ stdout_pipe => 1 }, "echo Hello, world!")
        or die $ssh->error;

    my $ret = do { undef $/; <$out> };

    waitpid $pid, 0;
    return $ret;
};

print $@ || $answer;
