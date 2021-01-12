#!/bin/env perl

use IPC::Run qw( run timeout start harness  finish pump);  # IPC::Run version 0.91
use strict;
use warnings;
use IO::Pipe;

my $write = IO::Handle->new();;
my $read = IO::Handle->new();
$write->autoflush(1);
my $pipe = IO::Pipe->new($read, $write);

my @args  = ( [
    '/home/dhawal/perl_script/transform_sep.pl',
      '--in-seperator', '|',
    ],
    '<' , $read,
    '2>','/home/dhawal/log/transform_sep_err.log',
    '>', '/home/dhawal/log/transform_sep_out.log'
);

my $h = start (@args); 

open(LRGE_FH, '/home/dhawal/data/test_big_data.dat');
while (<LRGE_FH>) {
    print $write $_;
}

close ($write);
close ($read);

finish $h;
if ( defined $h->result && $h->result != 0 ) {
    print STDERR "Error in executing cmd transform_sep \n";
}
print " IPC::Run::finish completed successfully \n";
exit;
