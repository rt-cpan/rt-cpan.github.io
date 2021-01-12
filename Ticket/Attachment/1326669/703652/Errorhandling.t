#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use Data::Dumper;
use Test::More();

#===============================================================================
#
#  DESCRIPTION:  This test case is only for testing correct errorhandling
#
#      OPTIONS:  options
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  wese
#      COMPANY:  ---
#      VERSION:  1.0
#      CREATED:  14.02.2014 16:09:44 CET
#     REVISION:  ---
#===============================================================================



Test::More::use_ok('Amazon::S3');

my $aws_accesskeyid = "YourAccessKey";
my $aws_secret_access_key = "yoursecretaccesskey";
my $bucket_name = "NameYourBucket";

my $s3 = Amazon::S3->new(
  {   aws_access_key_id     => $aws_accesskeyid,
      aws_secret_access_key => $aws_secret_access_key,
      retry                 => 0
  }
);
my $bucket = $s3->bucket($bucket_name);
my $succ = $bucket->add_key(
    "aKey" , "Somedata",
    {
        'x-amz-storage-class' => 'REDUCED_REDUNDANCY',
        'content-md5'  => 'SurelyWrong',
    }
    );
Test::More::ok( !$succ, "Request wasn't successfull.");
Test::More::ok( defined($bucket->err()) && defined($bucket->errstr()), "err and errstr are defined" );

=cut
sample errormessage taken from 
L<http://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html#RESTErrorResponses>
=cut

my $offline_xml = <<EOT;
<?xml version="1.0" encoding="UTF-8"?>
<Error>
  <Code>NoSuchKey</Code>
  <Message>The resource you requested does not exist</Message>
  <Resource>/mybucket/myfoto.jpg</Resource> 
  <RequestId>4442587FB7D0A2F9</RequestId>
</Error>

EOT

my $re = Amazon::S3->_xpc_of_content($offline_xml);

Test::More::ok( exists($re->{'Error'}) && defined( $re->{'Error'} ), "parsed xml has {Error}" );
Test::More::cmp_ok( $re->{'Error'}->{'Code'}, "eq", "NoSuchKey", "The code is NoSuchKey" );


Test::More::done_testing();
