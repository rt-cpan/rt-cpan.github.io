#!perl

use strict;
use warnings;

use Parse::BACKPAN::Packages;
use Getopt::Long;
use Data::Dumper;

my $index_url;
GetOptions( 'index' => \$index_url );

my @args = $index_url ? { index_url => $index_url } : ();
my $backpan = Parse::BACKPAN::Packages->new(@args);

unless ( @ARGV ) {
  die <<USAGE;
usage:
  $0 dist Dist-Name
  $0 dist_by CPANID
USAGE
}

my $cmd = shift;
my $arg = shift;

my $res;
if ( $cmd eq 'dist' ) {
  $res = { dist_name => $arg, dists => [ $backpan->distributions( $arg ) ] };
} elsif ( $cmd eq 'dist_by' ) {
  $res = { author_id => $arg, dists => [ $backpan->distributions_by( $arg ) ] };
} else {
  die "unknown command '$cmd'\n";
}

print Dumper( $res );

__END__

=head1 NAME

eg/demo.pl - a simple demo for Parse::BACKPAN::Packages

=head1 USAGE

  $ perl eg/demo.pl dist Dist-Name

  $ perl eg/demo.pl dist_by CPANID

=head1 DESCRIPTION

This demo creates a Parse::BACKPAN::Packages instance,
which downloads from web and parses a BACKPAN index
and then shows up either the distributions of a given
name or the the distributions of a certain CPAN author.

