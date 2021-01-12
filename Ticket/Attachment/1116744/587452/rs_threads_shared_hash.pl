#!/usr/bin/perl

use strict;
use warnings;

use threads;
use threads::shared;

use constant GENE       => 0;
use constant ANNO_TERM  => 1;

use constant ROUND_NUM  => 2;

use constant TRUE       => -1;
use constant FALSE      => 0;

use constant SUCCESS    => -1;
use constant FAILURE    => 0;

my $which_go        = 'C';   # BP, CC, or MF?
my $goa_file        = 'MinGOA';
my $rss_tab_file    = 'used_rss_cc';


#======== Subroutine protypes ========

sub load_gene_term_list($\@);
sub load_term_rss_lookup_tab(\%);   # \% - %rss_lookup_tab
sub gen_gene_pair_rss(\@\%);      	# \@ - @go_annos
                                    # \% - %rss_lookup_tab
sub rnd_sim_thread_safe($$;$);      # $ - $start_index
                                    # $ - $end_index
                                    # $ - $thread_index

#===== End of subroutine protypes =====



####========  Main procedure begins  ========####
my @genes;
my %rssLookup   :shared;

my $thread_id;
my @thread_ids;
my $thread_num      = 2;    # total thread number(including main thread)


if ($thread_num > 0) {  # multi-thread mode

    $thread_id = threads->create(\&load_term_rss_lookup_tab,
                    \%rssLookup );

    load_gene_term_list($goa_file, @genes);

    if ($thread_id->join() == FAILURE) {die 'Load %rssLookup failure.', "\n";}
    else {
        print STDERR scalar keys %rssLookup, ' returned in %rssLookup.' ,"\n";
    }

    my $step    = int( ROUND_NUM / $thread_num );
    my $ei      = ROUND_NUM;
    my $si      = $ei - $step;

    while ( --$thread_num ) {

        $thread_id = threads->create( \&rnd_sim_thread_safe, 
                            ($si, $ei, $thread_num) );
        push @thread_ids, $thread_id;
        $ei -= $step;
        $si -= $step;
    }

    rnd_sim_thread_safe(0, $ei, 0); # thread_id 0 always refers to myself.
                                    # and, i should finish the rest rounds
                                    # of simulation (remain undispatced).

    foreach $thread_id (@thread_ids) {
        $thread_id -> join();
    }

} # if($thread_num > 0)
else {  # single-thread mode
    load_gene_term_list($goa_file, @genes);

    load_term_rss_lookup_tab(%rssLookup);

    rnd_sim_thread_safe(0, ROUND_NUM);
}


print STDERR 'Done!', "\n";

#---- Thread-safe code begins ----
sub rnd_sim_thread_safe($$;$) {

    my ($s_index, $e_index, $thread_id) = @_;
	my $rss_dist_hashref;

    if ( !defined($s_index) || !defined($e_index) ) {
        print STDERR "Bad paras: rnd_sim($s_index, $e_index, $thread_id).\n";
        return FAILURE;
    }

    if ( !defined($thread_id) ) { $thread_id = '0'; } # master thread

    { lock(%rssLookup);
    # Shared hash will fail in correct generating 'keys' in different threads!
    print STDERR 'Check size of main data structures in thread ', $thread_id, ":\n",
		"\t\%rss\t", scalar keys %rssLookup, "\n",
            	"\t\@genes\t", scalar @genes, "\n";
    if ($thread_id eq '0') {
        print(Dumper(\%rssLookup));
    } else {
        print(STDERR Dumper(\%rssLookup));
    }
}

    print STDERR scalar localtime, 
        "| Thread $thread_id runs [$s_index, $e_index).\n";

    for (my $i = $s_index; $i < $e_index; $i += 1) {
        print STDERR scalar localtime, "| Thread $thread_id\tRound $i\n";

        { lock(%rssLookup);
          $rss_dist_hashref = gen_gene_pair_rss(@genes, %rssLookup);
      }
	
	write_dist($rss_dist_hashref);
    }

    return SUCCESS;
}
#---- Thread-saft code ends ----

####========  Main procedure ends  ========####


#============  Subroutines definitions  ============#

sub load_gene_term_list($\@) {
#1. Load GOA file into a hash, terms annotated to same gene(product) will be
#	pushed into a list referenced by hash-value of that gene(used as key).
#2. Transform GOA hash into GOA AoAoA.

    my ($goa_file, $goa_ref) = @_;
	my %goa;
    my $item;
    my @fields;
    my $GF;

    if ( !defined($goa_file) || !defined($goa_ref) ) {
        return FAILURE;
    }

    open($GF, $goa_file) or return FAILURE;

    while ($item = <$GF>) {
        chomp $item;
        @fields = split "\t", $item;
        push @{$goa{$fields[GENE]}}, $fields[ANNO_TERM];
    }

    close($GF);

	undef @$goa_ref;	# Clear
	foreach $item (keys %goa) {
		push(@$goa_ref, [$item, $goa{$item}] );
	}

    return scalar @$goa_ref;

}


sub load_term_rss_lookup_tab(\%) {
# Input:
#     %lookup_hash;
# Output:
#     $number of rows if success, otherwise 0(i.e. FAILURE).

    my $rss_lookup_ref = shift;
    my $row_num;

    if ( !defined($rss_lookup_ref) ) {
        print STDERR "Bad paras: load_lookup($rss_lookup_ref).\n";
        return FAILURE;
    };

    open( IF, $rss_tab_file )
			or die 'Fail to open hash data file - ', $!, ".\n";

	$row_num = 0;
	while (<IF>) {
		$row_num ++;
		chomp;
		my ($term1, $term2, $rss) = split "\t";
		$rss_lookup_ref->{"$term1-$term2"} = $rss;
    }
	
	close(IF);
	
    return $row_num;
}


sub gen_gene_pair_rss(\@\%) {

    my ($goa_ref, $rss_of_ref) = @_;
    my ($pi, $qi, $pterm, $qterm);
    my ($rss, $max_rss, $zone);
    my %count_of    = ( '[0.0]'         => 0,
                        '(0.0, 0.1]'    => 0,
                        '(0.1, 0.2]'    => 0,
                        '(0.2, 0.3]'    => 0,
                        '(0.3, 0.4]'    => 0,
                        '(0.4, 0.5]'    => 0,
                        '(0.5, 0.6]'    => 0,
                        '(0.6, 0.7]'    => 0,
                        '(0.7, 0.8]'    => 0,
                        '(0.8, 0.9]'    => 0,
                        '(0.9, 1.0]'    => 0,
                        );

    if ( !defined($goa_ref) || !defined($rss_of_ref) ) {
        return FAILURE;
    }
    
        
    for ($pi = 0; $pi <= $#$goa_ref; $pi += 1) {
        for ($qi = $pi; $qi <= $#$goa_ref; $qi += 1) { # ($qi = $pi + 1) ?

            $rss = 0.0;
            $max_rss = 0.0;

            foreach $pterm (@{$goa_ref->[$pi]->[ANNO_TERM]}) {
                foreach $qterm (@{$goa_ref->[$qi]->[ANNO_TERM]}) {
                    if (exists $rss_of_ref->{"$pterm-$qterm"} ) {
                        $rss = $rss_of_ref->{"$pterm-$qterm"}
                    }
                    else {
                        $rss = $rss_of_ref->{"$qterm-$pterm"}
				    }
				    if ( defined($rss) ) {
					    if ($rss > $max_rss) {$max_rss = $rss;}
				    }
			    } # foreach $qterm
		    } # foreach $pterm
			
			# for each gene-pair, we check for which zone its rss falls into.
			$zone = $max_rss = 0    ? '[0.0]'
				  : $max_rss <= 0.1 ? '(0.0, 0.1]'
				  : $max_rss <= 0.2 ? '(0.1, 0.2]'
				  : $max_rss <= 0.3 ? '(0.2, 0.3]'
				  : $max_rss <= 0.4 ? '(0.3, 0.4]'
				  : $max_rss <= 0.5 ? '(0.4, 0.5]'
				  : $max_rss <= 0.6 ? '(0.5, 0.6]'
				  : $max_rss <= 0.7 ? '(0.6, 0.7]'
				  : $max_rss <= 0.8 ? '(0.7, 0.8]'
				  : $max_rss <= 0.9 ? '(0.8, 0.9]'
				  : $max_rss <= 1.0 ? '(0.9, 1.0]'
				  :                   undef
				  ;
			if ( defined($zone) ) { $count_of{$zone} += 1 }
#			else { #TODO: Warning? }
			
	    } # foreach $qi

    } # foreach $pi

    return \%count_of;
}


sub write_dist($) {

    my $dist_hashref = shift;

    print $dist_hashref->{'[0.0]'       }, "\t";
    print $dist_hashref->{'(0.0, 0.1]'  }, "\t";
    print $dist_hashref->{'(0.1, 0.2]'  }, "\t";
    print $dist_hashref->{'(0.2, 0.3]'  }, "\t";
    print $dist_hashref->{'(0.3, 0.4]'  }, "\t";
    print $dist_hashref->{'(0.4, 0.5]'  }, "\t";
    print $dist_hashref->{'(0.5, 0.6]'  }, "\t";
    print $dist_hashref->{'(0.6, 0.7]'  }, "\t";
    print $dist_hashref->{'(0.7, 0.8]'  }, "\t";
    print $dist_hashref->{'(0.8, 0.9]'  }, "\t";
    print $dist_hashref->{'(0.9, 1.0]'  }, "\n";    # EOL

}

#============  Subroutine definition ends  =============#
