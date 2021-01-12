#!perl

use strict;
use warnings;

use Test::More tests => 12;

use_ok('Net::LDAP::LDIF');
use_ok('IO::File');
use_ok('PerlIO::eol');


CHECK_UNIX: {

	my $fh = IO::File->new();
	
	ok( $fh->open("< unix_lf.ldif"), "Openning the unix test file.");

	my $ldif = Net::LDAP::LDIF->new( $fh );
	
	my @contacts;
	
	while( not $ldif->eof )
	{
		my $entry = $ldif->read_entry;
		
		push @contacts, {
		
			email => [($entry->get_value('mail'))],
			name  => [($entry->get_value('cn'))],
		};
	}
	
	is( $#contacts, 7, "Checking to make sure we get the correct number of entries.");
	
	$fh->close;
}

CHECK_UNIX_WITH_CONVERT: {

	my $fh = IO::File->new();
	
	ok( $fh->open("< unix_lf.ldif"), "Openning the unix test file.");
	
	binmode $fh, ":raw:eol(LF)";
	
	my $ldif = Net::LDAP::LDIF->new( $fh );
	
	my @contacts;
	
	while( not $ldif->eof )
	{
		my $entry = $ldif->read_entry;
		
		push @contacts, {
		
			email => [($entry->get_value('mail'))],
			name  => [($entry->get_value('cn'))],
		};
	}
	
	is( $#contacts, 7, "Checking to make sure we get the correct number of entries.");
	
	$fh->close;
}

CHECK_DOS_WITH_CONVERT: {

	my $fh = IO::File->new();
	
	ok( $fh->open("< dos_lf.ldif"), "Openning the unix test file with the eol(LF) converted.");
	
	binmode $fh, ":raw:eol(LF)";	
	
	my $ldif = Net::LDAP::LDIF->new( $fh );
	
	my @contacts;
	
	while( not $ldif->eof )
	{
		my $entry = $ldif->read_entry;
		
		push @contacts, {
		
			email => [($entry->get_value('mail'))],
			name  => [($entry->get_value('cn'))],
		};
	}
	
	is( $#contacts, 7, "Checking to make sure we get the correct number of entries");
}


CHECK_DOS: {

	my $fh = IO::File->new();
	
	ok( $fh->open("< dos_lf.ldif"), "Openning the dos test file, no preconversion attempted.");
	
	my $ldif = Net::LDAP::LDIF->new( $fh );
	
	my @contacts;
	
	while( not $ldif->eof )
	{
		my $entry = $ldif->read_entry;
		
		push @contacts, {
		
			email => [($entry->get_value('mail'))],
			name  => [($entry->get_value('cn'))],
		};
	}
	
	is( $#contacts, 7, "Checking to make sure we get the correct number of entries");
	
	$fh->close;
}
