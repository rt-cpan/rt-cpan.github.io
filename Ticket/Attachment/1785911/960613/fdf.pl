#!/usr/bin/perl
use strict;
use warnings;
use CAM::PDF;
use PDF::FDF::Simple;
use Data::Dumper;

my $pdf = new CAM::PDF ( "Muster_10_D(7_2017).pdf" );
# print Dumper( $pdf->getFormFieldList() );
$pdf->setPrefs('', '', 1, 1, 1, 1);
# my $fdf = new PDF::FDF::Simple ({ filename => "test.fdf" });
# my $fdfcontent = $fdf->load;
my %data = (
  '8118_Telefonnummer' => "0221 940 564 19",
  '4205_Auftrag' => "Hubba Hopp!\n Trallala Hoppsassa!",
  '8501_eilt' => "On",
  '3110_Geschlecht_M' => 1,
  'Text1' => "Hubba Hopp",
  '4134_Kostentraegername' => "Test fuer Kostentraegername",
);


$pdf->fillFormFields(%data );
# $pdf->output("test.pdf");
$pdf->cleanoutput('test.pdf');
