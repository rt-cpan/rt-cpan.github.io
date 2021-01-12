#!/usr/bin/perl -T

use strict;
use warnings;
use CGI::Fast;
use CGI::Carp qw/fatalsToBrowser/;
use Scalar::Util qw(tainted);
while ( my $q = new CGI::Fast ) {

    print $q->header;
    print $q->start_html;
    print "PID: ", $q->b($$);
    print $q->br;
    my $param = $q->param('param');
    print $q->b($param);
    print $q->br;
    print '$param is tainted' if ( tainted($param) );
    print $q->br;
    print "Taint Mode active" if ( ${^TAINT} );
    print $q->end_html;

}
