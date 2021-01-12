#!/usr/bin/perl
use strict;
use warnings;
use IO::File;
use Devel::Leak;
use XML::RAI;

sub test {
	my $rss = XML::RAI->parse_string(shift);
}

my $file = IO::File->new("rss.xml");
my $rss = join("", $file->getlines());
test($rss);

my $handle;
my $count = Devel::Leak::NoteSV($handle);
for(1..10) {
	test($rss);
}
Devel::Leak::CheckSV($handle);
