#!/usr/bin/perl -w

use strict;
use warnings;

use Getopt::Euclid;
use Data::Dumper;

print Dumper(%ARGV);

exit 1;

__END__

=head1 NAME

test.pl - sample Getopt::Euclid test program


=head1 REQUIRED ARGUMENTS

=over

=item --groups [=] <group>... | -g [=] <group>...

List of groups

=for Euclid:
    group.type: string

=item --hosts [=] <hostname>... | -h <hostname>...

List of hostnames.

=back

=cut

