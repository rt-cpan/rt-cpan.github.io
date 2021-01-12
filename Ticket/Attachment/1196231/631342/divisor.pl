#!/usr/bin/env perl -w

use strict;
use warnings;

use Divisor;

my $div = Divisor->new(numerator => 1, denominator => 0);
say("The quotient is " . $div->quotient);
