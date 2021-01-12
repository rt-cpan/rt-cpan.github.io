#!/usr/bin/perl
use HTTP::Message;
use Data::Dumper qw(Dumper);

while(<>) { $h .= $_; }
$h =~ s/^HTTP.+?\n//;

my $header = HTTP::Message->parse($h);
print Dumper($header);



