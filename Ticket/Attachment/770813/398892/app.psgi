#!/usr/bin/perl

use strict;
use warnings;

use Plack::App::WrapCGI;

use File::Spec;
# __DIR__ is taken from Dir::Self __DIR__ fragment
sub __DIR__ () {
	File::Spec->rel2abs(join '', (File::Spec->splitpath(__FILE__))[0, 1]);
}

Plack::App::WrapCGI->new(script => __DIR__."/test.cgi")->to_app;

