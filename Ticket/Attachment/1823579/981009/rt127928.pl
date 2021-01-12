#!/usr/bin/env perl
use strict;
use warnings;
use IO::Async::Loop;
use Future;
use IPC::Open3;
use Symbol 'gensym';

my $cmd = 'echo "stdout"';
#my $cmd = 'echo "stdout" && >&2 echo "stderr"';
my $code = sub {
  # works with regular pipe open
  #my $pid = open my $stdout, '-|', $cmd or die "open failed: $!";
  # hangs with open3
  print STDERR "D1\n";
  my $pid = open3(my $stdin, my $stdout, my $stderr = gensym, $cmd);

  print STDERR "D2\n";
  print $_ while <$stdout>;

  print STDERR "D3\n";
  waitpid $pid, 0;

  print STDERR "D4\n";
  return $?;
};

my $out = '';
my $exit;

if(0) {
   open my $fake_out, '>', \$out or die "open failed: $!";
   select $fake_out;
   $exit = $code->();
   select STDOUT;
   print "STDOUT:\n$out\nExit: $exit\n";
}

$out = '';
my $loop = IO::Async::Loop->new;
my $f = $loop->new_future;
my $p = $loop->open_process(
  code => $code,
  stdout => { into => \$out },
  stderr => { into => \my $err },
  on_finish => sub { $f->done($_[1]) },
);
print "pid: " . $p->pid . "\n";

$exit = Future->wait_any($f, $loop->timeout_future(after => 10))->get;
print "STDOUT:\n$out\nExit: $exit\n";
