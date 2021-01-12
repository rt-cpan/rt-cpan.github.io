#!/usr/bin/env perl

use strict;
use warnings;

BEGIN {
	push @INC, qw( /home/noctux/perl5/lib/perl5/x86_64-linux-thread-multi /home/noctux/perl5/lib/perl5 /usr/lib/perl5/5.28/site_perl /usr/share/perl5/site_perl /usr/lib/perl5/5.28/vendor_perl /usr/share/perl5/vendor_perl /usr/lib/perl5/5.28/core_perl /usr/share/perl5/core_perl);
}

use Poppler;
use Search::Xapian;
use Data::Dumper;

my $pdf = Poppler::Document->new_from_file($ARGV[0]);

my $n_pages  = $pdf->get_n_pages;

for my $pagenr (2) {
	my $page = $pdf->get_page($pagenr);
	my $mappings = $page->get_annot_mapping();
	for my $mapping ($mappings) {
		next unless $mapping;
		my $annot = $mapping->annot;
		my $type  = $annot->get_annot_type();
		if ($type eq "highlight") {
			study 1;
			my @quads = $annot->get_quadrilaterals();
			#for my $quad (@$quads) {
				##print "  " . ref($quad) . "\n";
			#}
		} else {
			# TODO: DEBUG
			print "Unsupported Annotation type: $type\n";
		}
	}
}
