#!/usr/bin/perl -w

use strict;
use Petal;
use File::Temp qw/ tempfile /;


print "Content-type:text/html; charset=utf-8\n\n";

my ($fh, $filename) = tempfile();
print $fh <<EOL;
<html>
<head><title>Test 1 - FFFD</title></head>
<body>Sean&nbsp;Connery</body>
</html>
EOL
close $fh;
die "$filename does not exist" unless (-e $filename);
my $template = Petal->new(
  file     => "$filename",
  base_dir => '/',
  input    => 'XHTML',
  output   => 'XHTML',
);
print $template->process (bar => 'BAZ');
print "\n";

