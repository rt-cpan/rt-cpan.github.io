#!/bin/perl

use XML::LibXML;
use XML::LibXSLT;

my $parser = XML::LibXML->new();
my $xslt = XML::LibXSLT->new();

my $source = $parser->parse_string(<<'EOT');
<hello>
	<msg>Hello LibXSLT</msg>
</hello>
EOT

my $styledoc = $parser->parse_string(<<'EOT');
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
	<xsl:value-of select="hello/msg"/>
</xsl:template>
</xsl:stylesheet>
EOT

my $stylesheet = $xslt->parse_stylesheet($styledoc);
# if we exit now, LibXSLT does not cause Perl to core dump

my $result = $stylesheet->transform($source);
# if we exit now, LibXSLT will cause Perl to core dump

print STDOUT "transformed document " . $result->toString();
# yet Hello LibXSLT will appear in the standard output before the core

exit();

