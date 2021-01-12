#!/usr/bin/perl

use strict;
use utf8;

use Lingua::StarDict::Gen;

my $dic = {'ZZZ00'=>'ZZZ00 article'};
for(my $i=1;$i<32;$i++)
{
  my $s=$i;
  $s="0".$s if length($s<2);
  $dic->{"aaa$s"}="aaa$s article";
}

Lingua::StarDict::Gen::writeDict($dic,"Wrong_Dict1","./");
