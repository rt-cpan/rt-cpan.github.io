#!/usr/bin/perl
( $#ARGV==-1 or ($#ARGV==0 and $ARGV[0] eq "-n" ) )
  or die "Usage: check_status [-n] < message";

use MIME::Parser;
use Mail::GnuPG;
use Email::Filter;

my $email = Email::Filter->new();

mkdir "/tmp/$$",0700; chdir "/tmp/$$";
my $parser = new MIME::Parser;
$parser->decode_bodies(0);
$entity = $parser->parse_data( $email->simple->as_string ) or
  die "parse failed\n";
my $mg = new Mail::GnuPG();

if( $mg->is_signed($entity) ){
  print "Message was signed\n";
  my ($code, $keyid, $email) = $mg->verify($entity);
  if($code==0) {
    print "The signature valid\n";
   } else {
    print "The signature was invalid\n";

   }
} 
`rm -rf /tmp/$$`; # Tempdir must die.
