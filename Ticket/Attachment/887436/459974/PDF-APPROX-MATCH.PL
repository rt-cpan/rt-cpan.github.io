#!/usr/bin/perl -w
use CAM::PDF;
use Text::Metaphone qw(Metaphone);
use String::Approx qw(amatch adist);

my (%val, @arr);
my ($search, $metaph, $editdist, $file_name, $pdf);

my $illArg = "Illegal Argument!\nProgramm will be terminated!\n\n";

for(my $i=0; $i<=$#ARGV; $i++) {
	@arr = split("=", $ARGV[$i]);
	$val{$arr[0]} = $arr[1];
}

if( ($val{"metaphone"} eq 1) || ($val{"metaphone"} eq 0)) { 
	$metaph = $val{"metaphone"}; 
} else { die ($illArg) }

$editdist = $val{"editdist"};
$search = $val{"search"} || die ($illArg);
$file_name = $val{"file"} || die ($illArg);
$pdf = CAM::PDF->new($file_name);

my $linenumber = 0;
my $mphn1 = Metaphone($search);

for my $page (1 .. $pdf->numPages()) {
	my $text =  $pdf->getPageText($page);
	@lines = split (/\n/, $text);

	foreach (@lines) {
		@arr = split(/ /, $_);	
		foreach (@arr) {
			my $mphn2 = Metaphone($_); 

			if (!$metaph && amatch($search, ["i",$editdist], $_)) {		
				print "SEARCHED: $search, FOUND: $_\n";
				print "IN FILE: $file_name LINE: $linenumber\n\n";
			} 

			if($metaph) {
				if (amatch($mphn1, ["i",$editdist], $mphn2)) {
					print "WORDS: $search, $_\n";				
					print "METAPHONES: $mphn1, $mphn2\n\n";
				}
			}
		}
		$linenumber++;
	}
}


# Programmaufruf: pdf-approx-match.pl search=lookstr metaphone=[0|1] editdist=[0..3] file=file.pdf
# find . -name "*.pdf" -exec perl ./PDF-APPROX-MATCH.PL search=posttranscriptional metaphone=0 editdist=0 file={} \;
