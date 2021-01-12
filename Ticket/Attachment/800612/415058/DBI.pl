#!/usr/bin/perl
use strict;
use warnings;

use POE;
use POE::Component::SimpleDBI;

POE::Session->create(
    inline_states => {
        _start => \&_start,
        'quote_handler' =>  \&FooHandler,
    },
);

sub _start {
    POE::Component::SimpleDBI->new( 'SimpleDBI' ) or die 'Unable to create the DBI session';
    $_[KERNEL]->post( 'SimpleDBI', 'CONNECT',
            'DSN'           =>  "DBI:SQLite:dbname=/var/lib/Billingd.db",
            'USERNAME'      => '', 
            'PASSWORD'      => '', 
            'EVENT'         => 'conn_handler',
            );  

}
# Run POE!
POE::Kernel->run();
exit;

