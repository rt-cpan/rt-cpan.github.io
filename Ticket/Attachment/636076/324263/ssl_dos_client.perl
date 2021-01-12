use Socket::Class::SSL;
 
 $c = Socket::Class::SSL->new(
     'remote_port' => 10443,
 ) or die Socket::Class->error;

while($c->readline()){}