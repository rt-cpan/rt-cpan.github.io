#!/usr/bin/perl
use strict;
use warnings;

use Tie::Handle;
use IO::Handle;

BEGIN {
    package My::TiedHandle;
    use vars qw(@ISA);
    @ISA = qw( Tie::StdHandle IO::Handle );
}

my $fh = IO::Handle->new;
tie *$fh, 'My::TiedHandle';

open *$fh, "+<$0" or die "couldnt open tied handle: $!";

$fh->blocking(0);
print "All is OK!\n";
exit;
