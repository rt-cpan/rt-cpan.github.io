#!/usr/bin/perl -w

use strict;
BEGIN {
	$|  = 1;
	$^W = 1;
}

use Test::More;

#use version;
use Perl::MinimumVersion;
my @examples_not=(
    q{use Foo "say"; say "Bar"},
    q{use Foo qw/ say /; say "Bar"},
    q{sub say; say "Bar"},
    q{sub say { print @_, "\n" } say "Bar"},
);
my @examples_yes=(
    q{say "Foo"},
    q{use AutoExportedSay; say "Foo"},
);
plan tests =>(@examples_not+@examples_yes);
foreach my $example (@examples_not) {
	my $p = Perl::MinimumVersion->new(\$example);
	is( $p->_perl_5010_say, '', $example )
	  or do { diag "\$\@: $@" if $@ };
}
foreach my $example (@examples_yes) {
	my $p = Perl::MinimumVersion->new(\$example);
	ok( $p->_perl_5010_say, $example )
	  or do { diag "\$\@: $@" if $@ };
}
