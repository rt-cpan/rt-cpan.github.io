#!/usr/bin/perl
use warnings;
use strict;
use Config::General;
my $conf = Config::General->new(
 -ConfigFile        => 'in',
# -SplitPolicy       => 'equalsign',
);
my %SETTING = $conf->getall;
$conf->save_file('out', \%SETTING);
