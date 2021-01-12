#!/usr/bin/perl

use strict;
use Encode;
use bytes; # to show length in bytes (i.e. not in characters)

sub fcStringShow {
	my $v = shift;

	print "String: {{" . $v . "}}\n";
	print "\tlength = " . length( $v ) . "\n";

	print "\t"; my $i = 0; while ( $i < length( $v ) ) {
		printf "\\x{%.2x}" , ord( substr( $v , $i ) );
		$i = $i + 1;
	} print "\n";
}

sub fcTest {
	my $a = shift;

	print "Not encoded string is: " . $a . "\n";
	fcStringShow( $a );

	my $b = Encode::encode_utf8( $a );
	print "Encoded string is: " . $b . "\n";
	fcStringShow( $b );

	print "\n";
}

fcTest( "abcde" );
fcTest( "äöüéà" );
