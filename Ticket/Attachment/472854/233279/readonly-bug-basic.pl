#!perl
use strict;

use DirHandle;
use Readonly;

Readonly my $CLASS => 'DirHandle';
my $handle = $CLASS->new(q{.});
$handle = $CLASS->new(q{.});

