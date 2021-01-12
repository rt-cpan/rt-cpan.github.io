#!/usr/bin/perl

use warnings;
use strict;

use WWW::Search;
use WWW::SearchResult;
use WWW::Search::MSN;

my $search="IP:$ARGV[0]";

print $search,"\n";

print "Version == ", WWW::Search::MSN->VERSION(), "\n";


my $sQuery = $search;
my $oSearch = new WWW::Search('MSN');

$oSearch->native_query($sQuery);
while (my $oResult = $oSearch->next_result())
    {
    my @line = $oResult->as_HTML;
    foreach my $l (@line) {
    		$l =~ m{ href="(.*?)"}i;
    print $1, "\n";
    }
    }
