#!/usr/bin/env perl

use strict;
use warnings;

package ProcManager::Test;

use parent 'FCGI::ProcManager';
use POSIX qw(:sys_wait_h);

sub pm_wait {
  my ($this) = FCGI::ProcManager::self_or_default(@_);
  while (1) {
    kill HUP => keys %{$this->{PIDS}};
     my $pid;
     while (($pid = waitpid(-1, WNOHANG)) > 0) {
         print "pid exited with status $?\n";
         delete $this->{PIDS}->{$pid};
         $this->pm_abort();
     }
  }
}

package main;

my $manager = ProcManager::Test->new({n_processes => 1});
$manager->pm_manage();
while (1) {
  1 while $manager->pm_received_signal("HUP");
}
