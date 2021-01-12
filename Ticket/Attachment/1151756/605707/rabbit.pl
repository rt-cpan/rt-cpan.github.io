use warnings;
use strict;
use Data::Dumper;
use lib '.';
use Siebel::Monitor::Config;

my $file = shift;

my $mon_conf = Siebel::Monitor::Config->new( file => $file );

print join( "\n",
    $mon_conf->gateway, $mon_conf->enterprise, $mon_conf->srvrmgrPath ),
  "\n";

print Dumper( $mon_conf->servers ), "\n";

print ref($mon_conf->servers()), "\n";

#foreach my $server ( @{ $mon_conf->servers } ) {
#
#    foreach my $component ( @{ $server->components } ) {
#
#        print join( "\n", $component->name, $component->OKStatus ), "\n";
#
#    }
#
#}
