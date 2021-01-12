#!/usr/bin/perl

use strict;
use warnings;
use Pod::Simple::XHTML;


my $in_file  = "test.pod";
my $out_file = "test.xhtml";

open my $xhtml_fh, '>', $out_file or die "Can't write to $out_file: $!";


my $parser = Pod::Simple::XHTML->new();
   $parser->output_fh($xhtml_fh);
   $parser->parse_file($in_file);

__END__