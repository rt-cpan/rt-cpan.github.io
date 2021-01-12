use Socket::Class::SSL;
 
 $c = Socket::Class::SSL->new(
     'remote_port' => 10443,
 ) or die Socket::Class->error;
 
 # send request
 $c->write(
     "GET / HTTP/1.0\r\n" .
     "Host: localhost\r\n" .
     "\r\n"
 );
 
 # read response header
 while( $l = $c->readline ) {
     print $l, "\n";
 }
 
 # read response content
 $c->read( $buf, 1048576 );
 print $buf . "\n";