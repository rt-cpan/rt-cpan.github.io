#!/usr/bin/perl
#
# pipethreadtest.pl
#
# Demonstrate hang joining joinable thread when main thread has
# a piped filehandle. 

use strict;
use threads;

if (scalar(@ARGV) < 2) {
  (my $bname = $0) =~ s/.*[\\\/]//;

  print <<"DONE";

  Missing parameter(s)

  Usage: $bname ifname ofname 
  
DONE
}

splitwork($ARGV[0], $ARGV[1], \&worker, {ncpu => 2} );


sub worker {
  my ($chunk) = @_;
  
  my $out;
  open (my $fh, '<', \$chunk) or die "Unable to open/read from CHUNK variable.";
  open (my $ofh, '>', \$out);
  
  # Not much of a worker function! (just copy lines);
  while (my $fline = <$fh>) { print $ofh $fline; }

  close($fh); close($ofh);
  
  return($out);
}


sub splitwork {  
  my ($ifname, $ofname, $func, $opt) = @_;
  
  my $MAX_BUFFERS = 64; 
  my ($fh, $ofh);  

  if ($ifname =~ /\.gz$/i) {
    my $pipe = "gzip -dc \"$ifname\" |";
    open($fh, $pipe);
  }
  else {
    open($fh, '<', $ifname) or die "Unable to open/write: $ifname";
  }

  if ($ofname =~ /\.gz$/i) {
    my $pipe = "| gzip -c > \"$ofname\"";
    open($ofh, $pipe);
  }
  else {
    open($ofh, '>', $ofname) or die "Unable to open/write: $ofname";
  }
  
  my %tids; my $nbuffalloc = 0;
  my $nlaunched = 0; my $nactive = 0; my $readall = 0;
  while (1) {
    if ($nactive < $opt->{'ncpu'} && !$readall && $nbuffalloc < $MAX_BUFFERS ) {
      # Read a chunk (just one line for demonstration purposes).
      my $chunk = <$fh>;
      if (!defined $chunk) { $readall = 1; next; }
      
      my $th = threads->create({'context' => 'list'}, $func, $chunk); 
      $tids{ $th->tid() } = undef;
      printf "Launched thread: %d\n", $th->tid();
      $nactive++;
      next;
    }
    
    # See if any threads are joinable.
    my @thr = threads->list(threads::joinable);
    if ($#thr == -1) {
      # 1 second is rather long for one line chunks...
      ## sleep(1); next;
      next;
    }
    
    # Store result(s) from each thread.
    foreach my $th (@thr) {
      printf "joining thread %d\n", $th->tid();
      my ($out) = $th->join();
      printf "joined thread %d\n", $th->tid();

      $tids{ $th->tid() } = $out;
      $nbuffalloc++;
      $nactive--;
    }
    
    # See if we can write out any of the buffers.
    foreach my $tid (sort { $a <=> $b } keys %tids ) {
      if (!defined $tids{$tid}) { last; }
      print $ofh $tids{$tid};
      print "Wrote result for thread: $tid\n";
      delete $tids{$tid};
      $nbuffalloc--;
    }
    
    if ($nactive == 0 && $readall) { last; }
  }
  
  close($ofh);
}

