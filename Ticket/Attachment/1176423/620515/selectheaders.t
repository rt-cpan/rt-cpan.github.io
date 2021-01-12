#!/usr/bin/perl -w
use strict;
use Pod::Usage;

print "Pod::Parser is ",$Pod::Parser::VERSION,
  ", Pod::Usage is ",$Pod::Usage::VERSION,"\n";

my $h2 = shift or die qq{Pass "Foo" or "Bar"\n};

Pod::Usage::pod2usage(
  '-verbose' => 99,
  '-exitval' => 1,
  '-sections' => "Name/$h2/!.+",
);

=head1 Name

Testing

=head2 Foo

This is foo

=head3 Foo bar

This is foo bar.

=head2 Bar

This is bar.

=head3 Bar baz

This is bar baz.

=cut

