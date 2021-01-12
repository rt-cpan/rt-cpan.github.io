use warnings;
use strict;
use Benchmark qw(:all);
use Bio::Phylo::IO 'parse';
use Bio::Phylo::Treedrawer;

# Read tree data
my $file = 'itol_newick.tre';
my $tree = parse( -format => 'newick', -file => $file )->first;

# Create SVG tree string
my $treedrawer = Bio::Phylo::Treedrawer->new(
  -width             => 800,
  -height            => 600,
  -shape             => 'CURVY',
  -format            => 'SVG'
);
my $nof_reps = 10;
for my $mode ('PHYLO', 'CLADO') {
  $treedrawer->set_mode($mode);
  $treedrawer->set_tree($tree);
  my $start = new Benchmark;
  for my $i (0..$nof_reps-1) {
    my $svg_tree = $treedrawer->draw;
  }
  my $end = new Benchmark;
  my $time = timestr(timediff($end, $start));
  print "Drawing the tree in $mode mode $nof_reps times took $time\n";
}
