#!/usr/bin/perl

use strict;
use threads;
use utf8;
use warnings;

use Archive::Extract;
use Cwd;
use English;
use File::HomeDir;


sub do_stuff {
    my ($name) = @ARG;
    my $archive = new Archive::Extract(archive => "$name.zip");
    
    $archive->extract(to => File::HomeDir->my_home);
    print "$name\n";
}

die if getcwd eq File::HomeDir->my_home;

my $use_threads = 1;
my %data = (
    x => \&do_stuff,
    y => \&do_stuff,
);

if ($use_threads) {
    $data{$ARG} = threads->create($data{$ARG}, $ARG) for sort keys %data;
    $data{$ARG}->join() for sort keys %data;
}
else {
    $data{$ARG}->($ARG) for sort keys %data;
}
