#!/usr/bin/perl

# gitweb - simple web interface to track changes in git repositories
#          PSGI wrapper (see http://plackperl.org)

use strict;
use warnings;

use Plack::Builder;
use Plack::App::WrapCGI;
use CGI::Emulate::PSGI 0.07; # minimum version required to work

use File::Spec;
# __DIR__ is taken from Dir::Self __DIR__ fragment
sub __DIR__ () {
	File::Spec->rel2abs(join '', (File::Spec->splitpath(__FILE__))[0, 1]);
}

builder {
	enable 'Debug';
	Plack::App::WrapCGI->new(script => __DIR__."/gitweb.cgi")->to_app;
}
