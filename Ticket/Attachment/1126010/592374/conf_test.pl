#!/usr/bin/perl -w

use v5.10;
use strict;
use Data::Dumper;

use Config::General qw{ParseConfig};

printf "[Using version %s of Config::General]\n", Config::General->VERSION;

for my $f ('myconf.ok', 'myconf.err') {
    die "No such config file '$f'" unless -r $f;

    say "Loading config from $f ...";
    eval {
        my %conf = ParseConfig(-ConfigFile      => $f,
                               -BackslashEscape => 1,
                               -CComments       => 0);
    
        if (my $partner_conf = $conf{location}{partner}) {
            printf "Successfully loaded config: %s\n", Dumper $partner_conf;
        } else {
            say "** Failed to load config from file '$f'";
        }
    };
    say "** Encountered error loading file '$f': $@" if $@;
}
