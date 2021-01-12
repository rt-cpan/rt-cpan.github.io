use Net::DNS;

  my $res = Net::DNS::Resolver->new(
        nameservers => [qw(172.17.144.144 172.17.170.175 172.19.231.103)],
        #nameservers => [qw(10.11.114.247)],

        recurse     => 0,
        debug       => 0,
  );

  $name = "provinzial.de";
  @mx = mx($res, $name);
  if (@mx) {
      foreach $rr (@mx) {
          print $rr->preference, " ",  Net::DNS::wire2presentation($rr->exchange), "\n";
      }
  }
  else {
      print "can't find MX records for $name: ", $res->errorstring, "\n";
  }

exit 0;

