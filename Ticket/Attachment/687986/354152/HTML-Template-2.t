#!/usr/bin/perl -w
use strict;
use Test::More qw(no_plan);

use_ok('HTML::Template::Pro');

my ($output, $template, $result);

# test using HTML_TEMPLATE_ROOT with path
{
    local $ENV{HTML_TEMPLATE_ROOT} = "templates";
    $template = HTML::Template->new(
                                    verbose => 7,
                                    path => ['searchpath'],
                                    filename => 'three.tmpl',
                                   );
    $output =  $template->output;
    ok($output =~ /THREE/);
}

