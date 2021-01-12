#!/usr/bin/perl
use strict;
my $file = "webotech-html-menu.dtd";

use XML::DTD;
my $dtd = new XML::DTD;
open(FH,'< '.$file);
$dtd->parse(*FH);

1;
