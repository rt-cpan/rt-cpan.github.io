#!/usr/bin/perl

use strict;
use warnings;

use Carp;
$Carp::Verbose = 1;

use Data::Dumper;

use Net::Stomp;

my $client = Net::Stomp->new( {
    hostname => 'localhost',
    port => '61613',
});

print STDERR "About to connect...\n\n";
$client->connect({ login => '', passcode => ''});

my $message_counter = 0;
my $messages_seen = {};

$client->subscribe( {
    destination => '/queue/activemq/perl',
    ack => 'client',
});

while (1) {
    my $frame = $client->receive_frame();
    $client->ack( { frame => $frame});
    
    my $message = $frame->body();
    chomp $message;

    $message_counter++;
    $messages_seen->{$message} += 1 if ( $message =~ /^\d+$/ );

    print STDERR "Message: $message ($message_counter)\n";
    
    if ( $message eq "dump" ) {
        print STDERR "Dump:\n";
        foreach my $key ( sort { $a <=> $b } keys %{ $messages_seen } ) {
            my $value = $messages_seen->{$key};
            print STDERR "$key => $value\n";
        }
        print STDERR "Finished dumping...\n";
    }

    if ( $message eq "check" ) {
        print STDERR "Check:\n";

        foreach my $key ( sort { $a <=> $b } keys %{ $messages_seen } ) {
            my $value = $messages_seen->{$key};
               if ( $value != 1 ) {
                print STDERR "E: $key => $value\n";
            }
        }
        print STDERR "Finished checking...\n";
    }

    if ( $message eq "clear" ) {
        print STDERR "Clearing...\n";
        $messages_seen   = {};
        $message_counter = 0;
    }

    if ( $message =~ m/^max(\d+)/ ) {
        my $max = $1;

        print STDERR "Max: $max\n\n";
        my $err_count = 0;
        foreach ( 1 .. $max ) {
            if ( !exists $messages_seen->{$_} ) {
                print STDERR "$_ does not exist!\n";
                $err_count += 1;
            }
        }
        print STDERR "Errors: $err_count\n\n";
    }
}

$client->disconnect();

print STDERR "Disconnected...\n\n";
1;