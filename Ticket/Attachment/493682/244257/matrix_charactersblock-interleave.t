#!/usr/bin/perl -w

######################################################
# Author: Chengzhi Liang, Weigang Qiu, Peter Yang, Thomas Hladish, Brendan
# $Id: matrix_charactersblock-interleave.t,v 1.6 2007/02/22 20:46:50 vivek Exp $
# $Revision: 1.6 $


# Written by Gopalan Vivek (gopalan@umbi.umd.edu)
# Refernce : http://www.perl.com/pub/a/2004/05/07/testing.html?page=2
# Date : 2nd November 2006

use strict;
use warnings;
use Test::More 'no_plan';

use lib 'lib';
use Bio::NEXUS;
use Data::Dumper;


####################################
#  Test the [transpose,] Interleave and Statesformat subcommands in the FORMAT command in CHARACTERS Block
######################################

my ( $nexus, $blocks, $character_block, $taxa_block, $tree_block );

my %tests = ( 
	'file_name' => ["t/data/compliant/characters-block-interleave.nex", "t/data/compliant/HCRT_all_orths_pep1_msfed1.aln.nxs"], 
	'block_count' => [ 2, 2 ], 
	'otu_name' => ['A','Homo_sapiens'], 
	'char_count' => [ 59, 124 ] 
	);

my $i; 

for ( $i = 0; $i < 2; $i++ ) { 
	my $file_name = $tests{'file_name'}[$i];
	my $block_count = $tests{'block_count'}[$i];
	my $otu_name = $tests{'otu_name'}[$i];
	my $char_count = $tests{'char_count'}[$i];

printf( "\nTesting interleaved file '$file_name' (expect $char_count chars from OTU '$otu_name')\n" ); 

	eval {
			$nexus      = new Bio::NEXUS($file_name);   
			$blocks          = $nexus->get_blocks;
			$character_block = $nexus->get_block("Characters");
	};
	
	## Check whether the files are read successfully
		is( $@, '', 'Parsing nexus files' );
		isa_ok( $nexus, 'Bio::NEXUS', 'NEXUS object defined' );
	
	## Check for all the blocks
	
		is( @{$blocks}, $block_count, "$block_count blocks are present" );
		isa_ok( $character_block, "Bio::NEXUS::CharactersBlock",'Bio::NEXUS::CharactersBlock object present' );
		my $seq_array_hash = $character_block->get_otuset->get_seq_array_hash;
		my $chars = $seq_array_hash->{ $otu_name };
	    is( @{$chars}, $char_count, "$char_count characters are present in '$otu_name'" );
}

exit;
