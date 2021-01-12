#!/usr/bin/perl

use WWW::Search;
use WWW::SearchResult;
use warnings;
use strict;

my $search="IP:$ARGV[0]";

print $search,"\n";


my $sQuery = $search;
my $oSearch = new WWW::Search('MSN');
$oSearch->native_query($sQuery);
while (my $oResult = $oSearch->next_result())
    {
    my @line = $oResult->as_HTML;
    foreach my $i (@line) {
    		$line[$i] =~ m{ href="(.*?)"}i;
    print $1, "\n";
    }
    }