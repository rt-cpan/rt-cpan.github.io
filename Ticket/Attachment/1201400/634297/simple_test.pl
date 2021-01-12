#!/usr/bin/env perl

use strict;
use warnings;

use Net::FTPSSL;
use Carp;

{
   my %proxy = ( "proxy-host" => "142.168.66.218", "proxy-port" => 8000 );

   if ($#ARGV != 4 && $#ARGV != 3) { die ("Usage: host port user password\n"); }

   my ($host, $port, $usr, $pwd, $ans) = @ARGV;
   my $ftps;
   my %callback_hash;

   my $simple_log = "myLog.txt";

   open (OLDERR, ">&STDERR");
   open (STDERR, "> $simple_log") or die ("Can't redirect STDERR to a log file!\n");

   print "\n";
   print "Connecting to server $host ...\n";

   eval {
      if (defined $ans && $ans =~ m/^n*$/i) {
         $ftps = Net::FTPSSL->new ($host, Debug=>1, Trace=> 1, Encryption=>EXP_CRYPT, Port=>$port, Croak=>1);
      } else {
         $ftps = Net::FTPSSL->new ($host, Debug=>1, Trace=> 1, Encryption=>IMP_CRYPT, Port=>$port, Croak=>1, ProxyArgs=>\%proxy);
      }

      $ftps->login ($usr, $pwd);

      # $ftps->set_callback (\&callback_func, \&end_callback_func, \%callback_hash);

      print "Running test 1 ...\n";
      carp ("\n\n=====================================================\n");
      my @lst = $ftps->nlst();
      carp ("\n-----------------------------------------------------\n" .
            "Listing 1: ", join (", ", @lst), "\n");

      print "Running test 2 ...\n";
      carp ("\n\n=====================================================\n");
      @lst = $ftps->list ();
      carp ("\n-----------------------------------------------------\n" .
            "Listing 2: ", join ("\n         : ", @lst), "\n");

      print "Running test 3 ...\n";
      carp ("\n\n=====================================================\n");
      @lst = $ftps->nlst();
      carp ("\n-----------------------------------------------------\n" .
            "Listing 3: ", join (", ", @lst), "\n");

      print "Closing the connection!\n";
      carp ("\n\n=====================================================\n");

      $ftps->quit();
   };

   open (STDERR, ">&OLDERR");

   if ($@) {
      die ("\n" . $@ . "\n");
   }

   print "\nPlease return the log file: $simple_log\n\n";

   close (OLDERR);
}

sub callback_func
{
   my $ftps_function_name = shift;
   my $data_ref = shift;
   my $data_len_ref = shift;
   my $total_len = shift;
   my $callback_dta_ref = shift;

   print "Data: ", ${$data_ref}, "\n";
}

sub end_callback_func
{
   my $ftps_function_name = shift;
   my $total_len          = shift;
   my $callback_dta_ref  = shift;
   return ("");
}

