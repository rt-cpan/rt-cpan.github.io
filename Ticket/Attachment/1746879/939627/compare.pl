#!perl

use strict;
use warnings;

my $HOST = '1.1.1.1';
my $USER = 'cisco';
my $PASS = 'cisco';
my $ENPS = $PASS;

my $TYPE = $ARGV[0];
my $AP = $ARGV[1];
my $BM = $ARGV[2];
my $NC = $ARGV[3];

use Net::SSH2::Cisco;
use Net::Telnet::Cisco;

my $c = ('Net::' . $TYPE . '::Cisco')->new(
    host => $HOST,
    dump_log => 'dump-' . $TYPE . '.txt',
    input_log => 'in-' . $TYPE . '.txt',
    output_log => 'out-' . $TYPE . '.txt',
);
$c->login($USER, $PASS);

$c->autopage($AP);
$c->binmode($BM);
$c->normalize_cmd($NC);

my (@out, $fh);
if (!$AP) {
    $c->cmd('term len 0');
}
@out = $c->cmd('show version');
open $fh, ">", $TYPE . "-ver.log";
for (@out) {
    print $fh $_;
}
@out = $c->cmd('disable');
@out = $c->enable($ENPS);
@out = $c->cmd('show run');
open $fh, ">", $TYPE . "-run.log";
for (@out) {
    print $fh $_;
}
close $fh;
$c->close;

system("xxd $TYPE-run.log $TYPE-run.log.xxd");
system("xxd $TYPE-ver.log $TYPE-ver.log.xxd");
