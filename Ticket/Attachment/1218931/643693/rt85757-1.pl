#!/usr/bin/perl

use strict;
use warnings;

use Argv;

my $cmd=Argv->new({autochomp=>1,autofail=>1,dbglevel=>2});

# Verify internal environment is empty
print ("Internal environment:\n");
foreach my $key ( sort( keys(%ENV) ) )
{
  printf( "%s=%s\n", $key, $ENV{$key} );
}

# Compare external environment
print ("External environment:\n");
$cmd->env->system;

# Call external command
print ("Calling external command:\n");
$cmd->git("--version")->system;

exit (0);
