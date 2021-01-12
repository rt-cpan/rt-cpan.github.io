#!/usr/bin/perl

my $number = 1;

#use POSIX ":sys_wait_h";
use Socket::Class::SSL();

my $ssl = Socket::Class::SSL->new(
      'local_port' => 10443,
      'listen' => 10,
      'reuseaddr' => 1,
#      'private_key' => '/usr/local/apache/conf/ssl.key/server.key',
#      'certificate' => '/usr/local/apache/conf/ssl.crt/server.crt',
  ) or die Socket::Class->error;
  

while( my $c = $ssl->accept ) {
	my $pid = fork();
	if( not defined $pid ) {
		die "fork failed!";
	}
	elsif( $pid == 0 ) {
		### child ###
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
		exit;
	}
	else {
		### parent ###
		#do {
		#	$kid = waitpid( $pid , WNOHANG );
		#} while $kid > 0;
	}
}