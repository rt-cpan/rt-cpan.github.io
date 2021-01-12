#!/usr/bin/perl
use strict;
use warnings;
use CAM::PDF;

my $doc = CAM::PDF->new($ARGV[0]) || die "$CAM::PDF::errstr\n";

foreach my $p (1 .. $doc->numPages())
{
	my $content = $doc->getPageContent($p);
	$doc->setPageContent($p, $content);
}

# ************************
# ************************
print " # Writing output file...\n";
$doc->output("output.pdf");
