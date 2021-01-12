use warnings;
use strict;

#use Siebel::Srvrmgr::ListParser::Output::ListParams;
use Storable qw(retrieve);

my $file = shift;

#my $comp = Siebel::Srvrmgr::ListParser::Output::ListParams->load($file);
my $comp = retrieve($file);

print $comp->get_comp_alias(), "\n";
