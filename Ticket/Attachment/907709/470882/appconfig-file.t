#!/usr/bin/perl

use strict ;
use warnings ;

use Test::More ;
use AppConfig qw{:expand :argcount} ;

my @args = [ qw{-delta D -alpha A -beta B -gamma G} ] ;

my %ACbase = (
                CASE     => 1,
                GLOBAL   => {
		  ARGCOUNT => ARGCOUNT_ONE,
		},
             ) ;

my $regex = q{^[a-z_]} ;
my @variables = qw{alpha beta gamma} ;
my $extravar  = q{delta} ;

my @tests = (
  {},
  {PEDANTIC => 0},
  {PEDANTIC => 1},
  {CREATE => $regex},
  {CREATE => $regex,PEDANTIC => 0},
  {CREATE => $regex,PEDANTIC => 1},
) ;

while ( my $parms = shift @tests ) {
  my %ACparms = ( %ACbase, %$parms ) ;
  
  my $create_status = exists $parms->{CREATE}?
    "CREATE is set to ".$parms->{CREATE} :
    "CREATE is not set" ;
    
  my $pedantic_status = exists $parms->{PEDANTIC}?
    "PEDANTIC is set to ".$parms->{PEDANTIC}:
    "PEDANTIC is not set" ;
  
  diag($create_status) ;
  diag($pedantic_status) ;
  
  my $c   = AppConfig->new(\%ACparms,@variables) ;
  my $ret = $c->file(q{test.conf}) ;
  
  diag(qq{Parser returned $ret}) ;
  
  my @parsed_values = map { defined $c->get($_)? $c->get($_) : "UNDEF" } (@variables,$extravar) ;
  diag(qq{Parsed values: @parsed_values})   ;
}

done_testing() ;
