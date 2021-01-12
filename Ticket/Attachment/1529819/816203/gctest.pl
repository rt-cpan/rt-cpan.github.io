#!/usr/bin/env perl

use strict;
use warnings;

use Unicode::GCString;

my $str_gcs = Unicode::GCString::->new("5");
print "String: " , $str_gcs->columns , "\n";

my $num_gcs = Unicode::GCString::->new(5);
print "Number: " , $str_gcs->columns, "\n";


