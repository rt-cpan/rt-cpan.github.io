use utf8;
use warnings;
use strict;


use Test::More tests => 1;
use CAM::PDF;

{
   my $pdf = CAM::PDF->new('t/test_th.pdf') || die $CAM::PDF::errstr;
   is( $pdf->getPageText(1) , 'ภาษาไทย', "Should get expected text");
}
