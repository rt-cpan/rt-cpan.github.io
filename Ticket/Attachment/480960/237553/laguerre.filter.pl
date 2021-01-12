#!/usr/bin/perl

use List::Util qw(max min);

sub Median {    # median may or may not be an element of the array
	            # got this from Math::NumberCruncher

	my $arrayref = shift;
	return undef unless defined $arrayref && @$arrayref > 0;
	my @array = sort { $a <=> $b } @$arrayref;
	if ( @array % 2 ) {
		$median = $array[ @array / 2 ];
	}
	else {
		$median = ( $array[ @array / 2 - 1 ] + $array[ @array / 2 ] ) / 2;
	}
	return $median;
}

sub FIR {

	my $price1 = $_[0];
	my $price2 = $_[1];
	my $price3 = $_[2];
	my $price4 = $_[3];

	return ( ( $price1 + 2 * $price2 + 2 * $price3 + $price4 ) / 6 );

}

sub dollar_round {
	my $n = shift;
	my $minus = $n < 0 ? '-' : '';
	$n = abs($n);
	$n = int( ( $n + .005 ) * 100 ) / 100;
	$n .= '.00' unless $n =~ /\./;
	$n .= '0' if substr( $n, ( length($n) - 2 ), 1 ) == '.';
	chop $n if $n =~ /\.\d\d0$/;
	return "$minus$n";
}

my $L0;
my $L1;
my $L2;
my $L3;
my $gamma  = .8;    #Starting Gamma, will change
my $length = 20;    #Set Days for gamma adjustment
my $counter;

# used last 50 odd days of IWM for testdata

@testdata = qw (
  70.92	71.67	71.68	70.37	70.55	71.23	71.90	72.38	71.74	71.40
  72.63	72.55	72.27	72.86	71.56	71.71	71.50	73.07	73.49	73.40
  73.55	73.95	73.97	73.70	72.65	73.17	72.21	73.32	73.66	74.41
  74.67	73.99	73.84	74.30	76.20	73.92	73.68	73.14	71.87	72.02
  73.32	73.78	73.72	73.13	73.74	72.57	71.89	70.70	71.50	69.66
  69.73	69.05);

$L0 = $L1 = $L2 = $L3 = $testdata[0];

foreach $datum (@testdata) {

	# gcf array holds the variances between the latest price and the last
	# filter value

	push @gcf, abs( $datum - $firfilter[ $counter - 1 ] ) if $counter > 0;

	shift @gcf
	  if $counter >= $length;    # we only want to see the last $length values

	$L0A = $L0;
	$L1A = $L1;
	$L2A = $L2;
	$L3A = $L3;

	$L0 = $gamma * $datum + ( 1 - $gamma ) * $L0A;
	$L1 = -( 1 - $gamma ) * $L0 + $L0A + ( 1 - $gamma ) * $L1A;
	$L2 = -( 1 - $gamma ) * $L1 + $L1A + ( 1 - $gamma ) * $L2A;
	$L3 = -( 1 - $gamma ) * $L2 + $L2A + ( 1 - $gamma ) * $L3A;

	push @firfilter, FIR( $L0, $L1, $L2, $L3 );
	$counter++;

	if ( $counter >= $length ) {    # we have enough values

		my $highesthigh = max(@gcf);    # the greatest variance
		my $lowestlow   = min(@gcf);    # the least variance

		my @lastfive = @gcf;            # splice off the last five of this below
		my @gammafinder;

		# calculates the gamma as per the paper; the author recommended
		# the last five bars

		for ( splice( @lastfive, $#lastfive - 4 ) ) {
			if ( $highesthigh - $lowestlow != 0 ) {
				push @gammafinder,
				  ( $_ - $lowestlow ) / ( $highesthigh - $lowestlow );
			}
		}

		# voila, adjustable gamma
		$gamma = Median( \@gammafinder );
		print dollar_round($gamma), "\t",
		  dollar_round( $firfilter[ $counter - 1 ] ), "\n";

	}

}
