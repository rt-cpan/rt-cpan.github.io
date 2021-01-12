#!/usr/bin/perl

use strict;
use warnings;

use Test::Schema;
use Data::Dumper;

my $db_file = 'test.db';
my $dsn = "dbi:SQLite:dbname=$db_file";
my $user = 'test';
my $pass = 'test';


unlink $db_file if -e $db_file;

my $schema = Test::Schema->connect($dsn, $user, $pass, {AutoCommit => 1});
$schema->deploy();
$schema->storage->debug(1);

my $stat_rs = $schema->resultset('Statistics')->search(
    {
        'me.targetLineId' => '554BA6E0-B410-11DF-BF0D-ED7CFF98A82D',
    },
    {
        select => [ 'me.sourceLineId' ],
        as     => [qw/ line_id /],
    }
);


$stat_rs = $stat_rs->search(undef,
    {
        '+select' => [
            { SUM => 'me.impressions', -as => 'impressions' },
            { SUM => 'me.clicks',      -as => 'clicks' },
            { SUM => 'me.leads_reach', -as => 'leads_reach' },
            { SUM => 'me.leads',       -as => 'leads_uniq' },
            { SUM => 'me.leads_nu',    -as => 'leads_nu' },
        ],
        '+as' => [qw/
            impressions
            clicks
            leads_reach
            leads_uniq
            leads_nu
        /],
    }
);

print "Correct SQL: '", Dumper($stat_rs->as_query), "'\n";

$stat_rs = $stat_rs->search(undef,
    {
        '+select' => ['me.profileId', 'me.bannerId'],
        '+as'     => [qw/profile_id banner_id/],
        group_by  => ['me.sourceLineId'],
        having    => [
            '-and' => { impressions => { '!=', 0 }},
                { clicks => { '!=', 0 }},
                { leads_reach => { '!=', 0 }},
                { leads_uniq => { '!=', 0 }},
                { leads_nu => { '!=', 0 }},
        ],
    }
);


print "Wrong SQL: '", Dumper($stat_rs->as_query), "'\n";

exit 0;


