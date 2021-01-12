#!/usr/bin/perl
# Set up search paths for Perl modules.
use lib qw(/home/marhind1/usr/local/lib/perl5 
           /home/marhind1/usr/local/lib/perl5/site_perl
           /home/dojones1/hsap/lib
           /vobs/cbtsp-tools/cmbp/bin);


use strict;
use Convert::ASN1;
use Data::Dumper;
use np_asn1;
 
                           #303E300602010002010BA0341A064E4F49535932A003020100020100301E1A093138302E34323433321A0732332E343536371A08333435362E3738390202012C
print Dumper np_asn_decode("303e300602010002010ba0341a064e4f49535932a003020100020100301e1a093138302e34323433321a0732332e343536371a08333435362e3738390202012c");
#print Dumper np_asn_decode("300d300602010002010ba1030a0102");
die;

my %msg = (
           'hdr' => { 
                       'np-ids-major-version' => $NP_IDS_MAJOR_VERSION,
                       'np-ids-minor-version' => $NP_IDS_MINOR_VERSION
                    },
           'pdu' => { 
                       'np-neighborprocconfigreq-pdu' => {
                          'np-hsap-id' => "NOISY2",
                          'np-current-config-version' => 0 
                        }
                    }
          );

print "Msg\n";
print Dumper %msg;
print "\n";

print Dumper char2hex(np_asn_encode(\%msg));

