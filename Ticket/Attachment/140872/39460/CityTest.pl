#!/nm/sw/perl/bin/perl
use strict;

use PHP::Interpreter;

my $php = PHP::Interpreter->new();
$php->include_once("city.php");

my $city = $php->instantiate("City","Raleigh", "NC");

# Both of these calls return 'NC' or whatever the last param to instantiate() is.
print STDERR $city->getName(), "\n";
print STDERR $city->getState(), "\n";


# This call Seg Faults
$city->setName('Charlotte');
