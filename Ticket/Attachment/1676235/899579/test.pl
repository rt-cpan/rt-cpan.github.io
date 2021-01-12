use strict;
use warnings;

use PDF::API2 2.029;		# or 2.028, ...

my $pdf = PDF::API2->open("test.pdf");
my $page = $pdf->openpage(1);

# This line will crash with
# Can't locate object method "update"
# via package "PDF::API2::Basic::PDF::Array"
# at /usr/share/perl5/vendor_perl/PDF/API2/Page.pm line 322.
my $ann = $page->annotation;
