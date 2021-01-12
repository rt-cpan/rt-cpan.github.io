#!/usr/bin/perl

use YAML;
use Parse::Debian::Packages;

my $fh= IO::File->new("Packages");

my $parser = Parse::Debian::Packages->new( $fh );

 while (my %package = $parser->next) {
     if ($package{'Package'} eq "browser-plugin-vlc")
     {
     print Dump \%package;
     }
}
