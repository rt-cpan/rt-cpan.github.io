#!/usr/bin/perl

use Test::More;

use File::Temp;
use File::Path;
use autodie;

rmtree "testing";
mkdir "testing";
chdir "testing";

{
    mkdir "tmp";

    my $dir = File::Temp->newdir( DIR => "tmp" );

    mkdir "hide";
    chdir "hide";
}

chdir "..";
ok !-d "tmp" or diag "ls:\n".`ls`;

done_testing;
