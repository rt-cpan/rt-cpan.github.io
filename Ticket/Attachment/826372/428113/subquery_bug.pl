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

my $count = $schema->resultset('Mediaplan')->count;
print "The number of rows is '$count'\n";

my $line_rs = $schema->resultset('Line')->search(
    {
        'line.type'        => 'sitePixel',
        'line.mediaplanId' => { '=' => \'me.id' },
    },
    { alias => 'line' }
);
my $subquery = $line_rs->get_column('startDate')->min_rs->as_query;
warn "SUBQUERY: '".Dumper($subquery)."'\n";

my $mediaplan_rs = $schema->resultset('Mediaplan')->search(
    {
        'me.title' => 'Test Mediaplan'
    },
    {
        join   => [qw/advertiser/],
        select => [
            'me.title',
            'me.id',
            'advertiser.title',
            $line_rs->get_column('startDate')->min_rs->as_query,
            $line_rs->get_column('stopDate')->max_rs->as_query,
        ],
        as => [qw/
            title
            id
            advertiser
            min_date
            max_date
        /],
    }
);


my $result = [ map +{ $_->get_columns() }, $mediaplan_rs->all];
print Dumper($result);


exit 0;


