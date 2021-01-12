#! /usr/bin/env perl

print "Starting\n";

use strict;
use warnings;
use Bio::Phylo::IO;
use Bio::Phylo::Treedrawer;

my $in_file = 'VPT.tre';

print "Test\n";

# Function parameters
my $in_format = 'newick'; # [newick]
my $out_format = 'svg'; # [svg]
my $shape = 'diag'; # [rect|diag|curvy]
my $mode = 'phylo'; # [clado|phylo] # clado is slooooow...
my ($width, $height, $padding, $text_vert_offset, $text_horiz_offset,
  $text_width, $font_height, $stroke_width, $line_spacing) = (24279.38, 30696.38,
  1458.19, 3, 5, 548, 9, 2, 0.5);

# Parse tree
print "Parsing tree...\n";
my $tree = Bio::Phylo::IO->parse('-format' => $in_format, '-file' => $in_file)->first;
print "  done!\n";

# Clean / prepare tree
#$tree = remove_ancestor_names($tree);
#$tree = leaves_taxid_to_names($tree, $taxo_names);

# Create tree
print "Preparing SVG...\n";
my $treedrawer = Bio::Phylo::Treedrawer->new(
  -width             => $width,
  -height            => $height,
  -padding           => $padding,
  -text_vert_offset  => $text_vert_offset,
  -text_horiz_offset => $text_horiz_offset,
  -text_width        => $text_width,
  -shape             => $shape,  
  -mode              => $mode, 
  -format            => $out_format    
);
print "  done!\n";

print "Setting tree...\n";
$treedrawer->set_tree($tree);
print "  done!\n";


print "Drawing tree...\n";
#my $count = 1000;
my $count = 1;
for (my $i = 1; $i <= $count; $i++) {
  my $svg_tree = $treedrawer->draw;
}
print "  done!\n";
