#!/usr/bin/env perl

use strict;
use Data::Dumper;
use Carp;
use English qw( -no_match_vars );
use warnings FATAL => 'all';

use Bio::DB::Sam;

print 'Bio::DB::Sam version: ',Bio::DB::Sam->VERSION,"\n";

my $d_count = 0;

my $bam = shift @ARGV;
my $chr = shift @ARGV;
my $pos = shift @ARGV;

my $sam = Bio::DB::Sam->new(-bam  => $bam,
                            -split_splices => 1);
my @alignments = $sam->get_features_by_location(-seq_id => $chr,
                                                -start  => $pos,
                                                -end    => $pos);
print "Raw feature_by_location: ";
print (scalar @alignments);
print "\n";


my $segment = $sam->segment(-seq_id=>$chr,-start=>$pos,-end=>$pos);
my ($coverage) = $segment->features('coverage');
print "coverage: ",$coverage->coverage,"\n";

my $pos_str = $chr.':'.$pos.'-'.$pos;
$sam->pileup($pos_str,\&depth_callback);
print "pileup: $d_count\n";

$d_count = 0;
$sam->fast_pileup($pos_str,\&fast_depth_callback);
print "fast_pileup: $d_count\n";
print $d_count,"\n";


sub depth_callback {
  my ($seqid,$pos_l,$pileup) = @_;
  if($pos_l == $pos) {
    foreach my $p(@{$pileup}) {
      next if($p->is_refskip);
      $d_count++;
    }
  }
}

sub fast_depth_callback {
  my ($seqid,$pos_l,$pileup, $t_sam) = @_;
  if($pos_l == $pos) {
    foreach my $p(@{$pileup}) {
      next if($p->is_refskip);
      $d_count++;

    }
  }
}
