#!/usr/bin/perl

# HTML::TreeBuilder invokes HTML::Entities::decode on the contents of
# HREF attributes.  Some CGI-based sites use lang=en or such for
# internationalization.  When this parameter is after an ampersand,
# the resulting &lang is decoded, breaking the link.  "sub" is another
# popular one.

use warnings;
use strict;

use Test::More tests => 1;
use HTML::TreeBuilder;

my $tb = HTML::TreeBuilder->new();
$tb->parse(
	"<a href='http://wherever/moo.cgi?xyz=123&lang=en'>Test</a>"
);

my @links = $tb->look_down( sub { $_[0]->tag eq "a" } );
my $href = $links[0]->attr("href");

ok($href =~ /lang/, "href should contain 'lang' (is: $href)");

exit;
