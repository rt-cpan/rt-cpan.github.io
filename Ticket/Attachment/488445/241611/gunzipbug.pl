#!/usr/bin/perl

use strict;
use warnings;

use IO::Uncompress::Gunzip qw(gunzip $GunzipError) ;

gunzip('linux.bin.gz' => '/dev/null', BinModeOut => 1);
