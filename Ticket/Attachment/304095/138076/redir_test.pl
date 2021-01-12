#! /usr/bin/perl

use strict;
use warnings;

sub POE::Kernel::ASSERT_DEFAULT () { 1 }
use POE qw(Component::Server::TCP Component::Client::HTTP Filter::HTTPD);
use HTTP::Request::Common qw(GET);
use Socket;

POE::Component::Client::HTTP->spawn(Alias => 'UA', FollowRedirects => 7);

POE::Session->create
  (
   inline_states =>
   {
    _start => sub { $_[KERNEL]->alias_set('main') },
    set_port => sub { $_[KERNEL]->post(UA => request => response => GET "http://127.0.0.1:$_[ARG0]/") },
    response => sub { print $_[ARG1]->[0]->as_string, $_[KERNEL]->post(webserver => 'shutdown') }
   },
   options => { trace =>  1}
  );

POE::Component::Server::TCP->new
  (
   Alias => 'webserver',
   Address => '127.0.0.1',
   Port => 0,

   ClientInput => \&handle_request,
   ClientFlushed => sub { $_[HEAP]->{client}->shutdown_output },
   ClientFilter => 'POE::Filter::HTTPD',
   Started => sub {
     my ($kernel, $heap) = @_[KERNEL, HEAP];
     my $port = (sockaddr_in($heap->{listener}->getsockname))[0];

     $kernel->post('main', 'set_port', $port);
   }
  );

POE::Kernel->run;

sub handle_request {
  my ($kernel, $heap, $request) = @_[KERNEL, HEAP, ARG0];

  if ($request->isa("HTTP::Response")) {
    $heap->{client}->put($request);
    $kernel->yield("shutdown");
    return;
  }

  $heap->{client}->put(HTTP::Response->new(302, 'Found', [Location => 'http:///']));
}
