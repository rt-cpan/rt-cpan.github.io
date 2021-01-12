#!/usr/bin/perl

use strict;
use XML::Parser;
use Archive::Zip;
use Archive::Zip::MemberRead;

@Archive::Zip::MemberRead::ISA = qw( IO::Handle );

my $catalog_parser = new XML::Parser();

#$catalog_parser->parsefile('ltupl_hoteldetails'); exit;

my $zip = Archive::Zip->new('test.zip');
die "Failed to open ZIP file 'test.zip': $!" unless $zip;

foreach ($zip->members())
{
	print "Processing XML: " . $_->fileName() . ".\n";
	#$catalog_parser->parse($_->contents());
	$catalog_parser->parse($_->readFileHandle());
}
