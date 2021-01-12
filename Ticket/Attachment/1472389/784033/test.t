use strict;
use warnings;

$ENV{PERLDOC} = '';
print "With no PERLDOC:\n";

my $cmd = "perldoc script/crypt_file";
my $data = qx($cmd);
printf "%s wrote %d bytes\n", $cmd, length($data);

$cmd = "$^X script/crypt_file -m";
$data = qx($cmd);
printf "%s wrote %d bytes\n", $cmd, length($data);

$ENV{PERLDOC} = '-t';
print "With no PERLDOC=-t:\n";

$cmd = "perldoc script/crypt_file";
$data = qx($cmd);
printf "%s wrote %d bytes\n", $cmd, length($data);

$cmd = "$^X script/crypt_file -m";
$data = qx($cmd);
printf "%s wrote %d bytes\n", $cmd, length($data);
