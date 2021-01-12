#!/usr/bin/perl -w
# file: test_crash_windows_fork.pl

## use Win32::Process::Info;

use Win32::API;
use Win32API::Registry;

use Win32::OLE;
use Win32::OLE::Const;
use Win32::OLE::Variant;

if (my $pid = fork()) {
  print "Parent\n";
}
elsif(defined $pid) {
  print "Child\n";
  exit;
} else {
  print "Failed to fork:$!:\n";
}

