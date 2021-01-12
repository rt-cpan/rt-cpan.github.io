#!perl

use strict;
use warnings;
use Test::More;

use XML::LibXML;
my $xml_filename_or_url = "in.xml";
my $schema_filename_or_url = "schema.xsd";

my $doc = XML::LibXML->new->parse_file($xml_filename_or_url);
my $xmlschema = XML::LibXML::Schema->new( location =>$schema_filename_or_url );
print $xmlschema->validate( $doc ); 


