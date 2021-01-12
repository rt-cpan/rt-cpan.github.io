#!/usr/bin/perl 

use strict;
use XML::SimpleObject::LibXML;

my $parser = new XML::LibXML;
my $xmlobj = new XML::SimpleObject::LibXML ($parser->parse_file("./bug_test.xml"));

my $datamodel = $xmlobj->child('datamodel');
print "return value of \$datamodel->children(\'data\'):\n";
foreach my $element ($datamodel->children("data")) {
  print "data: ".$element->value."\n";
}

print "\nreturn value of \$datamodel->child(\"data\"):\n";
if (defined $datamodel->child("data")) {
  print "data: " . $datamodel->child("data")->value . "\n";
} else {
  print "no data!\n";
}

