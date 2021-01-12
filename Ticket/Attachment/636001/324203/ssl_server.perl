#!/usr/bin/perl

my $number = 1;

use Socket::Class::SSL();

my $ssl = Socket::Class::SSL->new(
      'local_port' => 10443,
      'listen' => 10,
      'private_key' => '/usr/local/apache/conf/ssl.key/server.key',
      'certificate' => '/usr/local/apache/conf/ssl.crt/server.crt',
  ) or die Socket::Class->error;
  

while( my $c = $ssl->accept ) {
      # read request header
      while( my $l = $c->readline ) {
          print $l, "\n";
      }
      # send response header
      $c->write(
          "HTTP/1.0 200 OK\r\n" .
          "Server: SSL Server\r\n" .
          "\r\n"
      );
      # send response content
      $c->write( $number );
      $number++;
  }