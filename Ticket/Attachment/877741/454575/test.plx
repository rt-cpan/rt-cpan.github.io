#!/usr/bin/perl -w

no indirect;

use lib "$ENV{HOME}/tmp";
BEGIN {
    require TestMost;
    TestMost->import;
}
