#!/usr/bin/perl
use strict;
use warnings;
use DateTime::TimeZone::Local;
use Template;
use Template::Stash::XS;
    
print "DateTime::TimeZone version: " . $DateTime::TimeZone::VERSION . "\n";
print "Template version: " . $Template::VERSION . "\n";

my $status = 'FAILED';

my $template = '[% crasher() %]';
my $output;

# Note that only the XS stash fails..
my $tt2 = Template->new( STASH => Template::Stash::XS->new );
$tt2->process(\$template, { crasher => \&crasher }, \$output);
print "Generated output: $output\n";

$status = 'SUCCESS';

sub crasher {
    DateTime::TimeZone::Local->TimeZone;
    warn "** In crasher(), about to return..";
    return 'foo';
}


sub END { print "Status: $status\n"; }
