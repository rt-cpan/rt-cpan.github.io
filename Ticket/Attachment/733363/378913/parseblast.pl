#!/usr/bin/perl

use Bio::SearchIO;
my $in = new Bio::SearchIO(-format => 'blastxml',
                           -file   => 'xmlresults.xml',
                                -blasttype=>'psiblast');

while( my $result = $in->next_result ) {
  ## $result is a Bio::Search::Result::ResultI compliant object
	print "BLOCK for RESULT\n\n";  
while( my $hit = $result->next_hit ) {
    ## $hit is a Bio::Search::Hit::HitI compliant object
        print "\n\n";
    while( my $hsp = $hit->next_hsp ) {
      ## $hsp is a Bio::Search::HSP::HSPI compliant object
      if( $hsp->length('total') > 100 ) {
        if ( $hsp->percent_identity >= 50 ) {
          print "Query=",   $result->query_name,
            " Hit=",        $hit->name,
            " Length=",     $hsp->length('total'),
            " Percent_id=", $hsp->percent_identity, "\n";
        }
      }
    }
  }
}

