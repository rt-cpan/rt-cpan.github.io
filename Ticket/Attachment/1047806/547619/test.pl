#/bin/perl -w

use strict;

use Audio::Scan;
use Getopt::Long;

my $file;
my $data;

GetOptions(
	'file=s' => \$file,
);

print "$file\n";

$data = Audio::Scan->scan_tags($file);

print "$data\n";

;
