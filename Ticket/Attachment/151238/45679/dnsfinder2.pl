#!/usr/bin/perl
#
# DNSFINDER.pl v0.2 - DNS Server Scanner (multithread)
#
#   by The Dark Raver <darkraver@open-labs.org> (10/12/2005)
#
#
# Scans a range of IP address looking for open DNS servers.
#
# Example:
#
# ./dnsfinder.pl 192.168.0.1-254 -v
#

use strict;
use warnings;
use threads;
use Net::DNS;	# Not thread safe in Cygwin with +200 threads :(
 	


my $verbose=0;
my $found=0;


if(!$ARGV[0]) { print "Usage: ./dnsfinder.pl xx.xx.xx.xx[-xx] [-v]\n"; exit; }


my @target=split(/-/, $ARGV[0]);
my $start=$target[0];
my @ip=split(/\./, $start);
my $end=$ip[3];
if($target[1]) { $end=$target[1]; } else { $verbose=1; }
if($end > 255) { $end=255; }

if(defined $ARGV[1] and $ARGV[1] eq "-v") { $verbose=1; }

print "\n-- DNSFINDER by The Dark Raver --\n\n";
#print "IP_START: $ip[0].$ip[1].$ip[2].$ip[3]\n\n";

print "
IP Address      Host Name                 Bind Version          Recursive Cache
-------------------------------------------------------------------------------
"; 


my @iplist;

for(my $i=$ip[3];$i<=$end;$i++) {
  push(@iplist, $ip[0].".".$ip[1].".".$ip[2].".".$i);
  }


my $child;
my @child_list;

foreach my $iplist (@iplist) {
  $child = threads->new(\&scan_host, $iplist, $verbose);
  push(@child_list, $child);
  sleep(1);
}

#print "P\n"; select(STDOUT);

foreach $child (@child_list) {
  my $returned_data = $child->join;
  #print "Child thread returned: $returned_data\n";
  if($returned_data==1) { $found++; }
  }

print "\n-- Found $found Active DNS Servers --\n\n";

exit;



sub scan_host {
  my ($ipname, $my_verbose) = @_;
  my $ok=0;
  my $recursive=0;
  my $caching=0;  
  my $name="";
  my $version="";
  my $random="www.random.org";


  #print "C\n"; select(STDOUT);


format STDOUT =
@<<<<<<<<<<<<<< @<<<<<<<<<<<<<<<<<<<<<<<< @<<<<<<<<<<<<<<<<<<<<<<<<<<< @> @>>>>
$ipname, $name, $version, $recursive, $caching
.


  my $res = Net::DNS::Resolver->new();
    
  $res->nameservers($ipname);

  
  #__QUERY1__
  
  my $query = $res->search($ipname);
  
  if($query) {
    $ok=1;
    foreach my $rr ($query->answer) {
      if($rr->type eq "PTR") { 
        $name=$rr->ptrdname; 
        #print "PTR: ".$rr->ptrdname."\n"; 
        }
    }
  } else {
    if($my_verbose) { print "QUERY1 ($ipname): ".$res->errorstring."\n"; select(STDOUT); $| = 1; }
    if($res->errorstring eq "NOERROR") { $ok=1; $name="(none)"}
  }
    
    
  if($ok) {
    
    #__VERSION.BIND__
    
    $query = $res->search("version.bind", "TXT", "CH");

    if($query) {
      foreach my $rr ($query->answer) {
        if($rr->type eq "TXT") { 
          $version=$rr->txtdata; 
          #print "TXT: ".$rr->txtdata."\n"; 
          }
      }
    } else {
      if($my_verbose) { print "QUERY2 ($ipname): ".$res->errorstring."\n"; select(STDOUT); $| = 1; }
      if($res->errorstring eq "NOTIMP") { $version="(not_implemented)";}
      if($res->errorstring eq "SERVFAIL") { $version="(server_failed)";}
    }
    
    #__IS.RECURSIVE__
      
    $query = $res->search($random);
      
    if($query) { $recursive=1; }
      else { if($my_verbose) { print "QUERY3 ($ipname): ".$res->errorstring."\n"; select(STDOUT); $| = 1; } }
      
    #__IS.CACHING__
      
    $res->recurse(0);
      
    $query = $res->search($random);
            
    if($query) { $caching=1; } 
      else { if($my_verbose) { print "QUERY4 ($ipname): ".$res->errorstring."\n"; select(STDOUT); $| = 1; } }
      
  
    write; 
    select(STDOUT); $| = 1;
    return 1;
    
  }
    
  return 0;

}