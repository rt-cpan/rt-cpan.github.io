#!/usr/bin/perl
use strict;
use warnings;
use Template;
use Template::Stash::XS;
    
print "Template version: " . $Template::VERSION . "\n";

my $status = 'FAILED';

my $template = '[% crasher() %]';
my $output;

# Note that only the XS stash fails..
my $tt2 = Template->new( STASH => Template::Stash::XS->new );
$tt2->process(\$template, { crasher => \&load_subclass }, \$output)
    or warn "Failed to process..\n";

$status = 'SUCCESS';

sub END { print "Status: $status\n"; }

sub load_subclass {
    eval "use Nonexistent::Class";
    if ($@) {
        warn "Caught expected failure to use Nonexistent::Class";
    }
}
