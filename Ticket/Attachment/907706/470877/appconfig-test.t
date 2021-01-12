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
  {},                               [qw{A B G}],
  {PEDANTIC => 0},                  [qw{A B G}],
  {PEDANTIC => 1},                  [],
  {CREATE => $regex},               [qw{A B G D}],
  {CREATE => $regex,PEDANTIC => 0}, [qw{A B G D}],
  {CREATE => $regex,PEDANTIC => 1}, [qw{A B G D}],
) ;

while ( my ($parms,$expected_results) = splice(@tests,0,2) ) {
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
  my $ret = $c->args( [@args] ) ;
  
  diag(qq{Parser returned $ret}) ;
  
  my $varindex = 0 ;
  foreach my $varname (@variables,$extravar) {
    my $parsed_value   = $c->get($varname) ;
    my $expected_value = $expected_results->[$varindex++] ;
    is($parsed_value,$expected_value,qq{Comparing $varname}) ;
  }
}

done_testing() ;
