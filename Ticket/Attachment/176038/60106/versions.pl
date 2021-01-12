#!/usr/local/bin/perl

use warnings;
use strict;

no strict 'refs';

foreach my $pkg_file (sort keys %INC) {
    my $pkg_name = $pkg_file;
    $pkg_name =~ s{/}{::}g;
    $pkg_name =~ s/.pm$//;

    my $ver = ${"${pkg_name}::VERSION"};
    $ver = '<undef>' if ! defined $ver;

    printf("%-50s %s\n", $pkg_name, $ver);
}
