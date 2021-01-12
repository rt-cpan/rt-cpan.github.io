#!perl

use strict;
use warnings;
use HTTP::Request;

use constant DEBUG => 1;

use POE qw(Component::Client::HTTP);

POE::Component::Client::HTTP->spawn( Alias => 'ua' );

POE::Session->create(
	inline_states => {
		_start   => \&client_start,
		response => \&response_handler
	}
);

POE::Kernel->run();
exit;

sub client_start{
	my $request = HTTP::Request->new('GET', "http://www.google.com/");
	$_[KERNEL]->post( ua => request => response => $request );
	$_[KERNEL]->post( ua => cancel => $request );
}


sub response_handler {
	if (DEBUG) {
		my $response = $_[ARG1][0];
		print $response->as_string();
	}
}
