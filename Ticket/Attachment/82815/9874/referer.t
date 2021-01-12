#!/usr/bin/perl -w
use strict;
use FindBin;

use Test::More tests => 11;
use_ok('WWW::Mechanize');

SKIP: {
eval { require HTTP::Daemon; };
skip "HTTP::Daemon required to test the referrer header",8
  if ($@);

# We want to be safe from non-resolving local host names
delete $ENV{HTTP_PROXY};

# Now start a fake webserver, fork, and connect to ourselves
open SERVER, qq'"$^X" $FindBin::Bin/referer-server |'
  or die "Couldn't spawn fake server : $!";
sleep 1; # give the child some time
my $url = <SERVER>;
chomp $url;

my $agent = WWW::Mechanize->new();
$agent->get( $url );
diag $agent->res->message
  unless is($agent->res->code, 200, "Got first page");
is($agent->content, "Referer: ''", "First page gets send with empty referrer");
$agent->get( $url );
diag $agent->res->message
  unless is($agent->res->code, 200, "Got second page");
is($agent->content, "Referer: '$url'", "Referer got sent for absolute url");
$agent->get( '.' );
diag $agent->res->message
  unless is($agent->res->code, 200, "Got third page");
is($agent->content, "Referer: '$url'", "Referer got sent for relative url");
$WWW::Mechanize::headers{Referer} = '';
$agent->get( $url );
diag $agent->res->message
  unless is($agent->res->code, 200, "Got fourth page");
is($agent->content, "Referer: ''", "Referer can be set to empty again");
$WWW::Mechanize::headers{Referer} = "This is not the referer you are looking for *jedi gesture*";
$agent->get( $url );
diag $agent->res->message
  unless is($agent->res->code, 200, "Got fourth page");
is($agent->content, "Referer: 'This is not the referer you are looking for *jedi gesture*'", "Custom referer can be set");


};

END {
  close SERVER; # boom
};
