#!/usr/bin/env perl

use v5.14;
use warnings;

package MyApp {
	use Moo;
	use MooX::Cmd;
	use namespace::sweep;
	
	sub execute {
		warn "MyApp::execute() called";
	}
}

package MyApp::Cmd::cmd1 {
	use Moo;
	use MooX::Cmd;
	use namespace::sweep;
	
	sub execute {
		warn "cmd1 execute called";
	}
}

MyApp->new_with_cmd();
