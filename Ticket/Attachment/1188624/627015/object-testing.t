package Quote;

use Moose;
use Modern::Perl;

has 'security_desc'     => (is => 'ro', required => 1);
has 'asx_code'          => (is => 'ro', required => 1);

# DEBUG say "Testing $qbe->security_desc . " (" . $qbe->asx_code . ")";

use Test::Simpler tests => 3;
our $TODO;

# Instantiate a Quote for QBE...
my %QBE_RAW_DATA = (
                 'security_desc' => 'QBE Insurance Grp',
                 'asx_code' => 'QBE',
             );
my $qbe = Quote->new(%QBE_RAW_DATA);

# Test object and attributes....
ok( defined($qbe) && ref $qbe eq 'Quote', 'Quote->new() works' );
ok( $qbe->security_desc eq 'QBE Insurance Grp', 'get security_desc' );

TODO:{

    local $TODO = q{Purposely fail retrieving asx_code ('QBE' != 'EQB') 
    to see how Test::Simpler reports it.};
    
    ok( $qbe->asx_code eq 'EBQ','get asx_code' );
    
}




