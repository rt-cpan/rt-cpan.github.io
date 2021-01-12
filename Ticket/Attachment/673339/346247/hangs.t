#!perl -w

use Test qw( plan );
use IPC::Run3;
use strict;

plan tests => 1;

my $system_child_error = eval
{
    local $SIG{CHLD} = "IGNORE";
    system $^X, '-e', 0;
    $?;
};
