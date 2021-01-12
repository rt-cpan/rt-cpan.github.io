#!/usr/bin/perl -w

use strict;

use Fcntl qw(:DEFAULT :flock);
use Log::Dispatch::FileShared;

my $file = "/tmp/log_dispatch_fileshared.lock";

unlink $file;

defined (my $pid = fork()) or die "fork failed";
if ($pid == 0) {
    child();
    exit;
}

parent();
wait();

sub parent{
    open my $h, ">>", $file or die "open >> $file failed";
    printf "parent: file $file opened, waiting 1s\n";
    sleep 1;
    flock($h, LOCK_EX) or die "flock failed: $!";
    printf "parent: locked for 3s\n";
    sleep 5;
    flock($h, LOCK_UN);
    printf "parent: unlocked\n";
}

sub child {
    my $output = Log::Dispatch::FileShared->new(
						name      => 'test',
						min_level => 'info',
						filename  => $file,
					       ) or die "Log::Dispatch::FileShared->new failed";

    for my $i (1 .. 7) {
	print STDERR "child:$$: ->log('info',$i)\n";
	$output->log( level => 'info', message => "$$: test message: $i.\n" );
	print STDERR "child:$$: ->log('info',$i): done\n";
	sleep 1;
    }
}



