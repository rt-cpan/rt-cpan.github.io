#!/usr/bin/env perl 

use strict;
use warnings;
use utf8;

use File::Basename;
use Phash::FFI;

main: {
    my ( $fn1, $fn2 ) = @ARGV;

    $" = "\n";

    my $hash1 = calc_hash($fn1);
    my $hash2 = calc_hash($fn2);
    my $hd    = hd( $hash1, $hash2 );
    printf "Distance = %d <- from pHash\n", $hd;
    printf "Distance = %d <- from PP\n", hdpp( $hash1, $hash2, 64 );

    my $s;
    for ( 1 .. 8 ) {
        $s .= "[      ]";
    }
    printf "%s  %-16s %s\n", $s, "Hash in Hex", "Filename";

    my $a = sprintf "%064b", $hash1;
    my $b = sprintf "%064b", $hash2;

    printf "%s  %x %s\n", $a, $hash1, basename($fn1);
    printf "%s  %x %s\n", $b, $hash2, basename($fn2);

    my $d = 0;
    $s = undef;
    for ( 0 .. 63 ) {
        my $na = substr( $a, $_, 1 );
        my $nb = substr( $b, $_, 1 );
        my $diff = $na eq $nb ? 0 : 1;
        $d += $diff;
        $s .= $diff ? "^" : ' ';
    }
    print "$s\n";
} ## ---------- end main:

sub calc_hash {
    my ($fn) = @_;

    my $hash = Phash::FFI::dct_imagehash($fn);

    return ($hash);
} ## ---------- end sub calc_hash

sub hd {
    my ( $hash1, $hash2 ) = @_;

    my $hd = Phash::FFI::ph_hamming_distance( $hash1, $hash2 );

    return ($hd);
} ## ---------- end sub hd

sub hdpp {
    my ( $diff, $bits, $count, $mask ) = ( $_[0] ^ $_[1], $_[2] || 8, 0 );

    $mask = 1 << $_, $diff & $mask && ++$count for 0 .. $bits - 1;

    $count;
} ## ---------- end sub hdpp

