#!/usr/bin/perl -w

use DOCSIS::ConfigFile;
use Data::Dumper;

if($#ARGV ne 0) {
  print "Missing file argument!\n";
  exit(1);
}

my $filename=$ARGV[0];
my $outfile=$filename.".out";
die if(!open(OUT, "> $outfile"));

my $obj     = DOCSIS::ConfigFile->new(
		shared_secret   => 'foobar',
		advanced_output => 1,
		);

my $decoded = $obj->decode($filename);


my $encoded=$obj->encode($decoded);

print OUT $encoded;
close(OUT);
exit(0);
