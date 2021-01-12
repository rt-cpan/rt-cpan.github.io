#! /usr/bin/perl

use warnings;
use strict;

use XML::Twig;

my $xmlsdir = $ARGV[0];

print "Reading dir $xmlsdir\n";

opendir (my $dir, $xmlsdir);
while (my $file = readdir($dir)) {
  print "$file\n";
  next unless $file =~ /\.xml$/;

  my $t = XML::Twig->new();
  $t->parsefile("$xmlsdir/$file");
}


