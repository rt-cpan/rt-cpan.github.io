#!/usr/bin/perl -w

use OpenOffice::OODoc;

my $file=shift||"bugreport.ods";
my $doc = odfText(file => $file);

my $data=$doc->getTableText("Sheet1");
$data=~s!(<<|>>)!!msgo;
chomp($data);
@rows=split(/\n/,$data);

foreach my $row (@rows) {
	print "# $row\n";
}
