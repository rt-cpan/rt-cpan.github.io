#! /usr/bin/perl

# Test case for bug...
# https://rt.cpan.org/Ticket/Display.html?id=46754

use 5.010;

use List::MoreUtils qw(any);

$val = 1;
given( $val ){
    when(1) {
        say 'any() ' . (( any{ 14 == $_ } 10..15) ? 'works' : 'broken' );
    }
}
