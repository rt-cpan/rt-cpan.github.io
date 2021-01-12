#!/usr/bin/perl -w
#
use Config::General;
use strict;
#my $conf = new Config::General(-ConfigFile => \*STDIN);
my $conf = new Config::General(-ConfigFile => '/tmp/conf');
my %config = $conf->getall();

print "yay\n";
