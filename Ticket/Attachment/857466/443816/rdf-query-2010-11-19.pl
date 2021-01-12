### rdf-query-2010-11-19.pl  -*- Perl -*-

use strict;
use warnings;

require RDF::Query;
require RDF::Trine::Model;
require RDF::Trine::Serializer::Turtle;
require RDF::Trine::Store::Memory;

sub show_graph {
    my ($iter) = @_;
    my $s
        = new RDF::Trine::Serializer::Turtle ();
    print ($s->serialize_iterator_to_string ($iter), "\n");
}

sub show_results {
    my ($iterator) = @_;
    for ( ; my $row = $iterator->next (); ) {
        foreach my $k (keys (%$row)) {
            print (" ", $k, " ", $row->{$k});
        }
        print ("\n");
    }
}

die ("Usage: rdf-query-2010-11-19 TURTLE-FILE QUERY")
    unless (1 + $#ARGV == 2);

my ($file, $sparql) = @ARGV;

my $store
    = RDF::Trine::Store->new_with_config ({
        "storetype" => "Memory",
        "sources" => [
            {
                "file" => $file,
                "syntax" => "turtle",
                "base_uri" => "x-dummy:uri"
            } ] });
my $model
    = new RDF::Trine::Model ($store);

my $query
    = new RDF::Query ($sparql)
    or die ("Cannot create RDF:Query: ", $!, ": ");
my $iterator
    = $query->execute ($model);
if ($iterator->isa ('RDF::Trine::Iterator::Graph')) {
    show_graph ($iterator);
} else {
    show_results ($iterator);
}

## Local variables:
## fill-column: 72
## indent-tabs-mode: nil
## End:
### rdf-query-2010-11-19.pl ends here
