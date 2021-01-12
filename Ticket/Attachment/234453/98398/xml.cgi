#!C:/Perl/bin/perl.exe
use SOAP::Lite;
use SOAP::Transport::HTTP;
use strict;

# This works for SOAP-Lite-0.60
# *SOAP::Serializer::as_string = \&SOAP::XMLSchema1999::Serializer::as_base64;

# This doesn't work for SOAP-Lite-0.69
#*SOAP::Serializer::as_string =  \&SOAP::Serializer::as_base64Binary;

SOAP::Transport::HTTP::CGI
  -> dispatch_to('Apache::XML_test')
  -> handle;

package Apache::XML_test;
use strict;
use warnings;
sub fetch {
  my $self = shift;
  my $xml_file = "C:/test.xml";
  my $rv = '';
  if (-e $xml_file) {
    local $/;
    open(XML, "<$xml_file") or die qq{Cannot open $xml_file: $!};
    $rv = <XML>;
    close(XML);
  }
  return $rv;
}

1;
