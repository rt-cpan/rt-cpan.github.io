#!/usr/bin/perl -Tw

#
# This file is for testing problems with HTML::FillInForm/HTML::Parser under
# FreeBSD/perl 5.6.1
# Based on api_version => 2 of HTML::Parser
#

use Data::Dumper;
use CGI;

{
  package MyParser;
  use Data::Dumper;
  use lib qw(/local/web/adcmw/perl/lib/perl5/site_perl /local/web/adcmw/perl/lib/perl5);
  use base 'HTML::Parser';

  sub start {
    my ($self, $tagname, $attr, $attrseq, $origtext) = @_;
    print Dumper($attr);
    print "Type = " . $attr->{'type'} if exists $attr->{'type'};
  }
}

my $html = <<EOF;
<html>
<head><title>Test</title></head>
<body><h1>Test h1</h1>
<form name="form1">
<input type="text" name="textfield1">
<input type="radio" name="radio1">
</form>
</body>
</html>
EOF


# print HTML output
print "Content-type: text/html\n\n";

my $p = MyParser->new;
#my $p = HTML::Parser->new();
$p->attr_encoded(1);
$p->parse($html) || die "Error during parse: $!";
print "\n";
