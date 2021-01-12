package My::WebServer;
use base qw/Test::HTTP::Server::Simple HTTP::Server::Simple/;

package main;
use Test::More tests => 2;

my $s = My::WebServer->new();

my $url_root = $s->started_ok("start up my web server");
ok(1, 'Done');
