#!/usr/bin/perl

package Client;

use strict;
use warnings;

use Data::Dumper;
use POE;

use base qw(POE::Component::Client::Stomp);

use strict;
use warnings;

sub handle_connection {
    my ( $kernel, $heap, $self ) = @_[ KERNEL, HEAP, OBJECT ];

    print STDERR "We are handling a connection...\n";
    $heap->{message_counter} = 0;
    $heap->{messages_seen}   = {};

    my $nframe = $self->stomp->connect();
    $kernel->yield( 'send_data' => $nframe );

}

sub handle_connected {
    my ( $kernel, $self, $frame ) = @_[ KERNEL, OBJECT, ARG0 ];

    print STDERR "Connected...\n";

    my $nframe = $self->stomp->subscribe(
                                         {
                                           destination => $self->config('Queue'),
                                           ack         => 'client'
                                         }
    );
    $kernel->yield( 'send_data' => $nframe );
}

sub handle_message {
    my ( $kernel, $heap, $self, $session, $frame ) = @_[ KERNEL, HEAP, OBJECT, SESSION, ARG0 ];

    my $message_id = $frame->headers->{'message-id'};

    my $message = $frame->body();
    chomp $message;

    $heap->{message_counter} += 1;
    $heap->{messages_seen}->{$message} += 1 if ( $message =~ /^\d+$/ );

    print STDERR $message_id
      . " => $message ("
      . $heap->{message_counter} . ")\n";

    if ( $message eq "dump" ) {
        print STDERR "Dump:\n";
        foreach my $key ( sort { $a <=> $b } keys %{ $heap->{messages_seen} } ) {
            my $value = $heap->{messages_seen}->{$key};
            print STDERR "$key => $value\n";
        }
        print STDERR "Finished dumpring...\n";
    }

    if ( $message eq "check" ) {
        print STDERR "Check:\n";

        foreach my $key ( sort { $a <=> $b } keys %{ $heap->{messages_seen} } ) {
            my $value = $heap->{messages_seen}->{$key};
               if ( $value != 1 ) {
                print STDERR "E: $key => $value\n";
            }
        }
        print STDERR "Finished checking...\n";
    }

    if ( $message eq "clear" ) {
        print STDERR "Clearing...\n";
        $heap->{messages_seen}   = {};
        $heap->{message_counter} = 0;
    }

    if ( $message =~ m/^max(\d+)/ ) {
        my $max = $1;

        print STDERR "Max: $max\n\n";
        my $err_count = 0;
        foreach ( 1 .. $max ) {
            if ( !exists $heap->{messages_seen}->{$_} ) {
                print STDERR "$_ does not exist!\n";
                $err_count += 1;
            }
        }
        print STDERR "Errors: $err_count\n\n";
    }
    
    my $nframe = $self->stomp->ack( { 'message-id' => $message_id } );
    $kernel->yield( 'send_data', $nframe );
}

package main;

use POE;
use strict;

## This turns up without /queue because the /queue gets stripped
my $queue_name = "/queue/activemq/perl";

Client->spawn(
               Alias         => 'STOMPMDB',
               Queue         => $queue_name,
               RemoteAddress => 'localhost',
               RemotePort    => '61613',
);

$poe_kernel->run();

print STDERR "Finishing!";
exit 0;
