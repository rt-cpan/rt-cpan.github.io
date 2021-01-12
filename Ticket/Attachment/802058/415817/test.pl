#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
#use Carp;
use vars qw( $xsd $xml $schema $parser $doc );

use XML::LibXML;


#
# MAIN
#
my $xsd = $ARGV[0];
my $xml = $ARGV[1];
 
$schema = XML::LibXML::Schema->new(location => $xsd);
$parser = XML::LibXML->new( recover => 2 );
$doc    = $parser->parse_file($xml);
eval { $schema->validate($doc) };

if ( $@ ) {
	warn "xmlfile <$xml> failed validation: $@" if $@; exit(1);
}
else { print "No issues found\n"; }


