#!/usr/bin/perl -w

BEGIN {
    unshift @INC, 'blib/lib', 'blib/arch';
}

$SIG{'ALRM'} = sub {
    die "DoS successful\n";
};
alarm(10);
use Socket::Class::SSL();
my $ssl = Socket::Class->new( 'remote_port' => 10001 );
print "Connected\n";

my $ssl2 = Socket::Class::SSL->new( 'remote_port' => 10001 ) or die Socket::Class->error;
$ssl2->write( 'test' . "\n" );
print "Connected - 2\n";

my $line = $ssl2->readline();

if ( $line =~ /conn/i ) {
    print "DoS failed - Server OK\n";
}
else {
    die "DoS successful\n";
}
