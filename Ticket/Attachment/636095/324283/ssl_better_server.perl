#!/usr/bin/perl

my $number = 1;

use Socket::Class;
use Socket::Class::SSL;

my $sock = Socket::Class->new(
    'local_port' => 10443,
    'listen'     => 10,
    'reuseaddr'  => 1,
    #  'private_key' => '/usr/local/apache/conf/ssl.key/server.key',
    #  'certificate' => '/usr/local/apache/conf/ssl.crt/server.crt',
) or die Socket::Class->error;

while ( my $c = $sock->accept ) {
#    my $pid = fork();
#    if ( not defined $pid ) {
#        die "fork failed!";
#    }
#    elsif ( $pid == 0 ) {

        # child
        my $ssl = Socket::Class::SSL->starttls($c)
          or die 'TLS initialization failed: ' . $sock->error;

        $ssl->set_certificate('/usr/local/apache/conf/ssl.crt/server.crt');
        $ssl->set_private_key('/usr/local/apache/conf/ssl.key/server.key');

        # read request header
        while ( my $l = $c->readline ) {
            print $l, "\n";
        }

        # send response header
        $c->write( "HTTP/1.0 200 OK\r\n" . "Server: SSL Server\r\n" . "\r\n" );

        # send response content
        $c->write($number);
        $number++;
#    }
#    else {
#
#        # parent
#    }
}

#}
#else {
#    waitpid($pid, 0);
#    exit 0;
#}
