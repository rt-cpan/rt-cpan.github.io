#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'XML::RPC' );
}

diag( "Testing Roman $XML::RPC::VERSION, Perl $], $^X" );
