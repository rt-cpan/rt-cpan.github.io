use Net::Twitter;

my $nt = Net::Twitter->new(
  traits   => [qw/API::REST/],
  username => 'user',
  password => 'pass' 
);

my $result = $nt->update('árvíztűrő tükörfúrógép');

eval {
  my $statuses = $nt->friends_timeline({ since_id => $high_water, count => 100 });
  for my $status ( @$statuses ) {
    print "$status->{time} <$status->{user}{screen_name}> $status->{text}\n";
  }
};
if ( my $err = $@ ) {
  die $@ unless blessed $err && $err->isa('Net::Twitter::Error');

  warn "HTTP Response Code: ", $err->code, "\n",
  "HTTP Message......: ", $err->message, "\n",
  "Twitter error.....: ", $err->error, "\n";
}

