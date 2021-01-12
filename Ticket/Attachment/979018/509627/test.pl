#!/usr/bin/perl

use Sphinx::Search;

my $host= 'host' ;
my $port = 'port';
my $query = 'test';

my $sph = Sphinx::Search->new();
$sph->SetServer($host, $port);
$sph->Open();

for my $k (1..10){
    if ($k==5) {# on 5-th iteration wait for broken connection (reindex with rotate, or just stop and start sphinx)
        while(<STDIN>){ last if $_ =~/\n/ }
    }
    my $res = $sph->Query($query);
    if ($res) {
        print $res->{'total_found'}."\n";
    } else {
        print $sph->GetLastError()."\n";
    }
    sleep(1);
}

$sph->Close();

