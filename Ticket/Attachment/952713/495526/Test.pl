#!/usr/bin/perl
use strict;
use warnings;
use 5.010;

use Getopt::Long qw(VersionMessage HelpMessage);

#use Pod::Usage;

our $VERSION = 2009.006018;

GetOptions(
    'debug' => \( my $debug = 0 ),

    'help|?'  => sub { HelpMessage( -verbose => 1, -input => \*main::DATA ) },
    'man'     => sub { HelpMessage( -verbose => 2, -input => \*main::DATA ) },
    'usage'   => sub { HelpMessage( -verbose => 0, -input => \*main::DATA ) },
    'version' => sub { VersionMessage() },
) or HelpMessage( -verbose => 0, -input => \*main::DATA );

print "debug = $debug\n";

__DATA__

=head1 NAME

Test

=head1 USAGE

For testing.  Changes daily.

=head1 AUTHOR

Thomas J. Dillman
