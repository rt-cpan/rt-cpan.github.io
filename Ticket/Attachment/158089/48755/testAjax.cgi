#! /usr/bin/perl -w

use strict;
use CGI;      # or any other CGI:: form handler/decoder
use CGI::Ajax;

my $cgi = new CGI;
my $pjx = new CGI::Ajax( 'exported_func' => \&perl_func );

print $pjx->build_html( $cgi, \&Show_HTML);

sub perl_func {
    my $input = shift;
    # do something with $input
    my $output = $input . " was the input!";
    return( $output );
}

sub Show_HTML {
    
    my $html = <<EOHTML;
    <HTML>
	<BODY>
EOHTML

$html .= "Using CGI::Ajax version ".$CGI::Ajax::VERSION."</br>\n";
    $html .= <<EOHTML;
	Enter something: 
        <input type="text" name="val1" id="val1"
	onkeyup="exported_func( ['val1'], ['resultdiv'] );">
	<br>
	<div id="resultdiv"></div>
	</BODY>
	</HTML>
EOHTML
	return $html;
}
