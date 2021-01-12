#!/usr/bin/perl

################################################################################
# BUG REPORT Net::SSLeay
################################################################################

use strict;
use warnings;

use Net::SSLeay;
use Data::Dumper;

my $bio = Net::SSLeay::BIO_new_file( 'example_cert.crt.pem', 'r' );
my $x509 = Net::SSLeay::PEM_read_bio_X509($bio);

my @subjAltNames = Net::SSLeay::X509_get_subjectAltNames($x509);

Net::SSLeay::BIO_free($bio);
print Dumper @subjAltNames;