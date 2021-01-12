#!/usr/bin/perl
use strict;
use warnings;

use TryCatch;
use XML::SAX::Expat;

my $parser = XML::SAX::Expat->new(
	Handler => MyHandler->new(),
);

$parser->parse_string(<<EOF);
<foo>
 <bar id="1">
 </bar>
 <bar id="2">
 </bar>
 <bar id="3">
 </bar>
 <bar id="4">
 </bar>
</foo>
EOF

print "Completed successfully\n";

package MyHandler;
use base qw(XML::SAX::Base);
use TryCatch;

sub end_element {
	try {
		die "error message";
	} catch( $e when { $_ =~ /message/ } ){
		print "caught message\n";
	}
}
