#!/usr/bin/perl

use strict;
use warnings;

use WWW::Mechanize::PhantomJS;

my $ghostdriver_path =
    '/usr/local/share/perl5/WWW/Mechanize/PhantomJS/ghostdriver/main.js';
my $mech = WWW::Mechanize::PhantomJS->new(launch_arg => [ $ghostdriver_path ]);

$mech->viewport_size({ width => 1388, height => 792 });
$mech->get('http://www.google.com');
$mech->render_content(
    format => 'png',
    filename => 'viewport_perl.png'
);
