#!/usr/bin/env perl

package main v0.1.0;

my $i;

$SIG{INT} = sub {
    print "--- SIGINT\n";

    exit if ++$i > 2;

    return;
};

while (1) {
    print "ALIVE\n";

    sleep 1;
}

1;
__END__
