#!/usr/bin/env perl

use strict;
use warnings;

use Getopt::Euclid;

if ($ARGV{'--message'}) {
	print "Message: $ARGV{'--message'}\n";
}
else {
	print "Nothing\n";
}


__END__

=head1 NAME

ge-debug.pl - Test Getopt::Euclid with debug

=head1 VERSION

This documentation refers to ge-debug.pl version 0.0.1

=head1 USAGE

    perl -d ge-debug.pl --message Hello

=head1 OPTIONS

=over

=item -m [=] <message> | --message [=] <message>

Message to display.

=back

=head1 AUTHOR

Daniel Dehennin <daniel.dehennin@baby-gnu.org>
