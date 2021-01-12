#!/usr/bin/perl

$| = 1;

use strict;
use warnings;

use Carp;

use Net::Stomp;

## This turns up as just "mdb" because the /queue gets stripped
my $queue_name = "/queue/activemq/perl";

my $stomp = Net::Stomp->new( { hostname => 'localhost', port => '61613' } );
$stomp->connect();

my $count = 5000;

while ($count-- > 0) {
    my $body = $count;
    $stomp->send( { destination => $queue_name, body => $body } );    
}

$stomp->send( {destination => $queue_name, body => 'check'});
$stomp->send( {destination => $queue_name, body => 'max$count'});


$stomp->disconnect();
