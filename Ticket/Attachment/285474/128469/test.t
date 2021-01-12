
use strict;
use Test::More tests => 21;
use_ok('Statistics::Lite', ':all');

is(min(1,2,3),1,'min');
is(max(1,2,3),3,'max');
is(range(1,2,3),2,'range');
is(sum(1,2,3),6,'sum');
is(count(1,2,3),3);

is(mean(1,2,3),2);
is(median(1,2,3),2);
is(mode(1,2,3),2);

ok(abs(variance(1,2,3)-0.66666666666666)<0.0000000001,'variance');
ok(abs(stddev(1,2,3)-0.81649658092772)<0.0000000001,'stddev');

my %stats= statshash(1,2,3);

is($stats{min},1);
is($stats{max},3);
is($stats{range},2);
is($stats{sum},6);
is($stats{count},3);

is($stats{mean},2);
is($stats{median},2);
is($stats{mode},2);

ok(abs($stats{variance}-0.66666666666666)<0.0000000001,'variance');
ok(abs($stats{stddev}-0.81649658092772)<0.0000000001,'stddev');
