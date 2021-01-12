# Read tree file in Phylo
use Bio::Phylo::IO;
use Data::Dumper;
my $file = 'simple_tree.tre';
my $tree = Bio::Phylo::IO->parse(
  '-file'   => $file,
  '-format' => 'newick',
)->first;
print Dumper($tree);
