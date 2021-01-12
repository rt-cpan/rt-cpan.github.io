use Net::DNS;
use Net::DNS::Resolver;

my $dom = "yahoo.com";

my $res = Net::DNS::Resolver->new(debug => 1);
if (defined $res) {
  $res->persistent_udp(1);
}

print $res->string;

print("Net::DNS version: ".$Net::DNS::VERSION);

my $nsrecords;
print ("looking up NS for '$dom'");

my $query = $res->search($dom, 'NS');
my @nses = ();
if ($query) {
  foreach my $rr ($query->answer) {
    if ($rr->type eq "NS") { push (@nses, $rr->nsdname); }
  }
}
$nsrecords = [ @nses ];

print "\nfound " . join("\n", @$nsrecords);
