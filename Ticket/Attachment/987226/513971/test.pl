#! /usr/bin/perl

use strict;
use warnings;
use Bio::Graphics;
use Bio::SeqFeature::Generic;

my @formats = ('png', 'svg');

for my $format (@formats) {
   print "Creating an $format plot\n";
   plot($format);
}

sub plot {
   my ($format) = @_;
   my $image_class = 'GD';
   if ($format eq 'svg') {
      $image_class .= '::'.uc($format);
   }
   my $panel = Bio::Graphics::Panel->new(
      -length      => 2000,
      -width       => 200,
      -image_class => $image_class,
   );

   my $function_feat = Bio::SeqFeature::Generic->new(
      -display_name => 'Unknown',
      -start        => 100,
      -end          => 700,
   );

   $panel->add_track(
      $function_feat,
      -glyph        => 'generic',
      -label        => 1,
      -description  => 1,
      -linewidth    => 1,
      -bgcolor      => 'white',
      -fgcolor      => 'black',
   );

   $function_feat = Bio::SeqFeature::Generic->new(
      -display_name => 'Assigned',
      -start        => 1000,
      -end          => 1600,
   );

   $panel->add_track(
      $function_feat,
      -glyph        => 'generic',
      -label        => 1,
      -description  => 1,
      -linewidth    => 4,
      -bgcolor      => 'white',
      -fgcolor      => 'black',
   );

   my $file = "output.$format";
   open my $fh, '>', $file or die "Error: Could not write file $file\n$!\n";
   print $fh $panel->$format;
   close $fh;
   $panel->finished; 
}



