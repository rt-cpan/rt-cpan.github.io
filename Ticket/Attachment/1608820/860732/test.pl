require strict;
use PDF::API2;
use POSIX;
use File::Basename 'basename';

my $nowDate	= strftime( "%Y%m%d%H%M%S", localtime());
my $pdf = PDF::API2->open("./sample.pdf") or die "Can't open PDF file $source: $!";
my  %h = $pdf->info(
        'CreationDate' => $nowDate,
        'ModDate'      => $nowDate,
        'Creator'      => "foo",
		'Producer'     => "bar",
		'Keywords'     => "bar",
    );
	
$pdf->saveas("./sample_testok.pdf");