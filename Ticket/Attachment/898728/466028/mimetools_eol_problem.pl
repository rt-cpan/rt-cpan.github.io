#!/usr/bin/perl

use warnings;
use strict;

use Data::Dumper;
use MIME::Parser 5.426;

my $msg = '/tmp/1297878396953-517.para';

my $parser = new MIME::Parser;
$parser->output_under("/tmp");
my $entity;

eval {
    $entity = $parser->parse_open($msg);
};
if ($@) {
    print Dumper('Kaboom');
    exit;
}
elsif ($parser->last_error) {
    print Dumper($parser->last_error);
}

#$entity->dump_skeleton;
#print Dumper($entity);
my $header = $entity->head();
my $ip = $header->get("x-rp-sendingip");
#chomp($ip);
#$ip =~ s/(\r|\n)//g;
$ip =~ s/\r/CR/g;
$ip =~ s/\n/LF/g;
print Dumper($ip);
