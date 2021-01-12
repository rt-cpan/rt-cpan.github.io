#!/usr/bin/env perl

use strict;
use warnings;

use Poppler;
use Data::Dumper;

my $pdf = Poppler::Document->new_from_file($ARGV[0]);

my $n_pages  = $pdf->get_n_pages;
my $title    = $pdf->get_title;
my $author   = $pdf->get_author;
my $keywords = $pdf->get_keywords;


my $i = 0;
for my $pagenr (0 .. $n_pages-1) {
	my $page = $pdf->get_page($pagenr);
	for my $mapping ($page->get_annot_mapping()) {
		my $annot = $mapping->annot;
		my $type  = $annot->get_annot_type();
		if ($type eq "highlight") {
			my $quads = $annot->get_quadrilaterals();
			for my $quad (@$quads) {
				my $p1 = $quad->p1;
				print $p1->x . "\n";
			}
		}
	}
}
