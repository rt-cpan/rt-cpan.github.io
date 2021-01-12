### rdf-query-2010-11-04.pl  -*- Perl -*-

use strict;
use warnings;

require RDF::Query;
require RDF::Trine::Model;
require RDF::Trine::Store::Memory;

die ("Usage: rdf-query-2010-11-04 TURTLE-FILE QUERY")
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
    = RDF::Query->new ($sparql);
for (my $iterator = $query->execute ($model);
     my $row = $iterator->next ();
    ) {
    foreach my $k (keys (%$row)) {
        print (" ", $k, " ", $row->{$k});
    }
    print ("\n");
}

## Local variables:
## fill-column: 72
## indent-tabs-mode: nil
## End:
### rdf-query-2010-11-04.pl ends here
