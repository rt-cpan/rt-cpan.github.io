use strict;
use warnings;

use Test::More;
plan tests => 1;

ok(system("perl test_server.pl 8099") == 0);
