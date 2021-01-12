#!/usr/bin/env perl
use strict;
use warnings;
use Mail::IMAPClient;
use IO::Socket::SSL;
use List::Util qw( first );

my ($username, $password, $uid) = @ARGV;

# Connect to the IMAP server via SSL and get rid of server greeting message
my $socket = IO::Socket::SSL->new(
   PeerAddr => 'imap.gmail.com',
   PeerPort => 993,
  )
  or die "socket(): $@";

# Build up a client attached to the SSL socket and login
my $client = Mail::IMAPClient->new(
   Socket   => $socket,
   User     => $username,
   Password => $password,
  )
  or die "new(): $@";

print "I'm authenticated\n" if $client->IsAuthenticated();

my $folder = 'Inbox';
$client->select($folder) or die "Could not select: $@";

my $msgcount = $client->message_count($folder);
die "could not message_count(): $@" unless defined $msgcount;
print "there are $msgcount (s) in $folder\n";

if ($uid) {
   my $s = $client->get_bodystructure($uid)
      or die "you hit a bug!\n";
   require Data::Dumper;
   print Data::Dumper::Dumper($s);
}
else {
   print first {m/BODYSTRUCTURE\s+\(/i} $client->fetch($_, 'BODYSTRUCTURE')
     for $client->search('ALL');
}

$client->logout();
