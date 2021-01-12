BEGIN {
  #sub Pod::Simple::DEBUG() { 2 }
}
use Pod::Usage;
use strict;
use warnings;

my $fh;
open $fh, $0 or die;
pod2usage(-verbose => 2, -input => $fh);

=head1 NAME

Test

=head1 SYNOPSIS

perl podusagetest.pl

=head1 DESCRIPTION

This is a test.

=cut
