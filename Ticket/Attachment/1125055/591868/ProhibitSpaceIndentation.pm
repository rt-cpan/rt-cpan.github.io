package Perl::Critic::Policy::CodeLayout::ProhibitSpaceIndentation;

use strict;
use warnings;
use Readonly;

our $VERSION = '1.00';

use Perl::Critic::Utils qw{ :booleans :severities };
use base qw(Perl::Critic::Policy);

Readonly::Scalar my $DESC => q{Spaces used for indentation};

# Match possibly some blank lines, then indentation with at least one space
# (possibly among tabs).
Readonly::Scalar my $SPACE_INDENT_REGEX => qr/^(\n*)\t* +\t*/;

sub supported_parameters {
	return ();
}

sub default_severity {
	return $SEVERITY_LOW;
}

sub default_themes {
	return qw(cosmetic);
}

sub applies_to {
	return 'PPI::Token';
}

sub violates {
	my ($self, $elem, undef) = @_;

	# Only a violation at line start
	if ($elem->location->[1] == 1 && $elem =~ $SPACE_INDENT_REGEX) {
		return $self->violation($DESC, undef, $elem);
	} else {
		return;
	}
}

1;
__END__
=head1 NAME

Perl::Critic::Policy::CodeLayout::ProhibitSpaceIndentation - Use tabs instead
of spaces.


=head1 DESCRIPTION


For projects which have a policy of using tabs for indentation, you want to
ensure there are no spaces used for that purpose. This Policy catches all
such occurrences so that you can be sure when the tab sizes are reconfigured,
spaces won't make indented code look wrong.

This policy can be used together with
L<Perl::Critic::Policy::CodeLayout::ProhibitHardTabs|CodeLayout::ProhibitHardTabs>
by setting C<allow_leading_tabs> option of the latter to C<1>.

Putting hard tabs in your source code (or POD) is one of the worst
things you can do to your co-workers and colleagues, especially if
those tabs are anywhere other than a leading position.  Because
various applications and devices represent tabs differently, they can
cause you code to look vastly different to other people.  Any decent
editor can be configured to expand tabs into spaces.
L<Perl::Tidy|Perl::Tidy> also does this for you.

This Policy catches all tabs in your source code, including POD,
quotes, and HEREDOCs.  The contents of the C<__DATA__> section are not
examined.


=head1 CONFIGURATION

This Policy is not configurable except for the standard options.


=head1 NOTES

If there are blank lines before a violating line, the first blank line will be
reported as the violation location, because all the whitespace forms a single
token which Perl::Critic gives to the policy.


=head1 AUTHOR

Infoxchange Australia <devs@infoxchange.net.au>


=head1 COPYRIGHT

Copyright (c) 2012 Infoxchange Australia.  All rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.  The full text of this license
can be found in the LICENSE file included with this module.

=cut
