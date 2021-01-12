use strict;
use warnings;

use lib 'lib';
use lib 't/lib';

use Test::More 'no_plan';
use FileTempTFH;
use File::Basename qw( basename );

use TAP::Harness;
use_ok( 'TAP::Formatter::HTML' );

my @tests = glob( 't/data/*.pl' );
my $h = TAP::Harness->new({ merge => 1, formatter_class => 'TAP::Formatter::HTML' });
$h->runtests(@tests);


