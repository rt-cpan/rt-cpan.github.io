#!/usr/bin/perl

use AppConfig;

my $config = AppConfig->new( 'poll_file|f=s', { EXPAND => AppConfig::EXPAND_UID } );

# Some parameters on the command-line may be needed to bootstrap the process
$config->getopt();
printf "Passed the first one OK (%s)\n", $config->get('poll_file');

$config->file('a.config');  # This call fails
printf "Passed the second one OK (%s)\n", $config->get('poll_file');

exit 0;

