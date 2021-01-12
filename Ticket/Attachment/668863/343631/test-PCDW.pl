#!/usr/bin/perl
use utf8;   # vim:set sts=4 sw=4 et:
use strict;
use warnings;

use POE qw(Component::Daemon::Win32);


my $log_file = @ARGV ? $ARGV[0] : "$0.log";

open(my $log, '>:utf8', $log_file);
select( (select($log), $| = 1 )[0] ); # Autoflush
close(STDOUT);
close(STDERR);
*STDOUT = *STDERR = $log;

my $count = 0;

sub service_state
{
    my ($state, $message) = @_[ARG0, ARG1];

    print scalar localtime(), ' ', $state, "\n";

    # service start pending
    if ($state == SERVICE_START_PENDING) {
      # do some sort of initialization here
    }
    if ($state == SERVICE_RUNNING) {
        $count++;
        if ($count == 4) {
            my $pid = fork();
            unless ($pid) {
                print "Child start\n";
                sleep 5;
                print "Child end\n";
                exit 0;
            }
        }
    }
    $poe_kernel->yield ('next_state');
}


print scalar localtime(), " Begin\n";

POE::Component::Daemon::Win32->spawn(
    Alias => 'svc',
    Callback => \&service_state,
    PollInterval => 1,
);

POE::Kernel->run;
print scalar localtime(), " End\n";
