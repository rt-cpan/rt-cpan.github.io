#!/usr/bin/perl -w

use warnings;
use strict;

use Test::More tests => 1;
use CAM::PDF;

# tests the patch for bug report 53698

my $doc = CAM::PDF->new('t/rt53698.pdf') || die $CAM::PDF::errstr;
ok($doc->fillFormFields(qw( AuftragNr 0901234 Datum 15 )), 'fields filled');
