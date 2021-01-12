#!/usr/bin/perl

use Text::Iconv;
use strict;


my $a = "äöüéà";

sub fcStringShow {
	my $v = shift;

	print "String: {{" . $v . "}}\n";
	print "\tlength = " . length( $v ) . "\n";

	print "\t"; my $i = 0; while ( $i < length( $v ) ) {
		printf "\\x{%.2x}" , ord( substr( $v , $i ) );
		$i = $i + 1;
	} print "\n";
}

fcStringShow( $a );

print "\nUTF-8 to UTF8\n";
my $converter = Text::Iconv->new( "UTF-8", "UTF-8" );
my $v = $converter->convert( $a );
fcStringShow( $v );

print "\nUTF-8 to Latin1 (ISO-8859-1)\n";
my $converter = Text::Iconv->new( "UTF-8" , "ISO-8859-1" );
my $v = $converter->convert( $a );
fcStringShow( $v );

print "\nLatin1 (ISO-8859-1) to UTF-8\n";
my $converter = Text::Iconv->new( "ISO-8859-1" , "UTF-8" );
my $v = $converter->convert( $a );
fcStringShow( $v );

