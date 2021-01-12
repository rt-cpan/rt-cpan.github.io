#!/usr/bin/env perl 

use strict;
use warnings;
use utf8;

use Path::Tiny qw( path );

use Module::Metadata;

for my $file ( path('/tmp/files.txt')->lines_raw({ chomp => 1 }) ) {
    my $fullpath = path($file)->absolute("/tmp/portage/dev-perl-Net-UPS-0.150.0/work/Net-UPS-0.15/");
    my $mm = Module::Metadata->new_from_file( "$fullpath", collect_pod => 0 );
    if ( not $mm ) {
        printf "%s\t?\t?\n", $file;
        next;
    }
    my $name = $mm->name();
    if ( not $name ) { 
        printf "%s\t?\t?\n", $file;
        next;
    }
    my $version = $mm->version();
    if ( not defined $version ) {
        printf "%s\t%s\t?\n", $file, $name;
        next;
    }
    printf "%s\t%s\t%s\n", $file, $name, $version;
}
