#!/usr/bin/perl -wT
use strict;

use Template;
use CGI;

use Scalar::Util qw(tainted);
use Devel::Peek;

my $cgi = new CGI;

# MUST run as perl -wT test.cgi comment=X
# setting it here doesn't work (even using a tainted source value)
#$cgi->param('comment', $ENV{PATH});

print $cgi->header('text/plain');

my $template = new Template;
my $message;
my $ttext = <<EOT;
[% USE CGI %]
[% IF CGI.param("comment") && CGI.param("comment").length > 0 %]
[% END %]
EOT
$template->process(\$ttext, {}, \$message);

my $a = 'x';
my $b = "test\x{2012}unicode";
my $summary = $a . ':' . $b;

# Devel::Peek prints to STDERR :(
$| = 1;
my $dump = '';
close (STDERR);
open(STDERR, '>', \$dump) or die "Can't redirect STDERR";

print STDERR "BEFORE:\n";

Dump $summary;

$summary =~ s/^[^:]+://;

print STDERR "\nAFTER:\n";

Dump $summary;

close STDERR;

print $dump;
