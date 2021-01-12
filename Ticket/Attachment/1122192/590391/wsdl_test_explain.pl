#!/usr/bin/perl

use strict ;
use warnings ;

use Data::Dumper ;
use XML::Compile::WSDL11;
use XML::Compile::SOAP11;
use XML::Compile::Transport::SOAPHTTP;
# use Log::Report mode => 'DEBUG';  # enable debugging

foreach my $w (qw/simple_bad.wsdl simple_good.wsdl simple_good2.wsdl/) {
    print "Examining $w\n" ;
    eval {
        tryWSDL($w) ;
    } ;
    warn $@ if $@ ;
    print '-x' x 10, "\n" ;
}

sub tryWSDL {
    my ($wsdlfile) = @_ ;
    my $wsdl = XML::Compile::WSDL11->new($wsdlfile);

    # warn "Compiling" ;
    my $call = $wsdl->compileClient( 'testOp'
                                         , transport_hook => \&fake_server
                                     );

    # warn "Executing" ;
    my ($answer, $trace) = $call->( { testInReq => {} } ) ;
    print "Answer is " . Dumper($answer) ;

    # warn "Explaining" ;
    print $wsdl->explain( 'testOp',
                          PERL => 'INPUT',
                          recurse => 1,
                      );
}

sub fake_server($$)
{   my ($request, $trace) = @_;
    my $content = $request->decoded_content;
    $content =~ s/></>\n</g;
#    print $content;

    my $answer = <<_ANSWER;
<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope
   xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
   xmlns:x0="boo">
  <SOAP-ENV:Body>
     <x0:hasVersion>3.14</x0:hasVersion>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
_ANSWER

    use HTTP::Response;

    HTTP::Response->new
      ( HTTP::Status::RC_OK
      , 'answer manually created'
      , [ 'Content-Type' => 'text/xml' ]
      , $answer
      );
}

