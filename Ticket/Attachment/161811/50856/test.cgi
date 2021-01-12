#!/usr/bin/perl

use warnings;
use strict;
use CGI;

my $cgi    = new CGI;
my $server = 'localhost';

print $cgi->header( -expires => 'now', -charset => 'ISO-8859-1' ),
    $cgi->start_html(
                      -title       => 'Testing IE',
                      -lang        => 'en-US',
                      -encoding    => 'ISO-8859-1',
                      -declare_xml => 0
    );

print $cgi->p( 'I am '
,$cgi->script_name() );

print $cgi->p( 'My complete address is ', $cgi->url() );

print $cgi->end_html();

