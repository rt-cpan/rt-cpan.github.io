use HTTP::Tiny;
use IO::Socket::SSL;
use Net::SSLeay;
use Data::Dumper;
use strict;

die "Please specify the domain" unless $ARGV[0];
print "Versions: $HTTP::Tiny::VERSION / $IO::Socket::SSL::VERSION / $Net::SSLeay::VERSION\n";
my $probe = HTTP::Tiny->new( agent => "Mozilla/5.0", verify_SSL => 1, timeout => 10, SSL_options => { SSL_verify_callback => sub { print Dumper(\@_) } } );
$probe->head("https://$ARGV[0]/");
