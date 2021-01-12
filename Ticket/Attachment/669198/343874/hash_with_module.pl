#!/usr/pkg/bin/perl

use Digest::SHA1;
use Audio::Digest::MP3;

my $info = Audio::Digest::MP3->scan(shift @ARGV, 'SHA1');
return unless $info;
print "SHA1-" . $info->digest() . "\n";
