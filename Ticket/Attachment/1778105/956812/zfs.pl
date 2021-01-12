#!/usr/bin/perl -w

use strict;

use Filesys::ZFS;

my $ZFS = Filesys::ZFS->new();

$ZFS->init();
