#!/usr/bin/perl
use strict;
my $file = "webotech-html-menu.dtd";

use XML::DTD::Parser;
my $dp = XML::DTD::Parser->new(1);
open(FH,'< '.$file);
my $rt = '';
$dp->parse(*FH, $rt, $file);

1;

