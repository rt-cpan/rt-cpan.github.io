#! /usr/bin/perl

use strict;

use XML::LibXSLT;
use XML::LibXML;

my $parser = XML::LibXML->new();
my $xslt = XML::LibXSLT->new();
print "VERSION =",XML::LibXSLT::LIBXSLT_RUNTIME_VERSION(),"\n" ;


my $source = $parser->parse_string(<<'EOT');
<?xml version="1.0" standalone="no"?>
<!DOCTYPE article SYSTEM "article.dtd">
<article>
</article>
EOT

my $style_doc = $parser->parse_string(<<'EOX');
<?xml version="1.0" encoding="utf-8"?>
  <xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                 xmlns="http://www.w3.org/1999/xhtml">
  <xsl:template match="/">
    <xsl:message>hello</xsl:message>
</xsl:template>
</xsl:transform>
EOX
print $source->toString(1);

my $stylesheet = $xslt->parse_stylesheet($style_doc);

my $results = $stylesheet->transform($source);


$stylesheet->output_string($results);

print $source->toString(1);
