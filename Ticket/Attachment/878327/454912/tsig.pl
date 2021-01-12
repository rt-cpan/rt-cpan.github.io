use Net::DNS;
use Net::IP;

#Set DNS server to query
$res = Net::DNS::Resolver->new();
$res->nameservers("jupiter.cs.brown.edu");
$res->port(7979);

#Set key for TSIG
$key_name = "yingdi-brown";
$key = "8bz86RaXjzxHioN3fKruQg==";

#Generate TSIG
$tsig = Net::DNS::RR->new("$key_name TSIG $key");
$tsig->fudge(300);

#Generate a Query
$query = Net::DNS::Packet->new("www.sjtu.edu.cn");

#Generate OPT
@iplist = qw(202 120 2 101);
my $opt = Net::DNS::RR->new(
        name => "",
        type => "OPT",
	class => 1024,
        extendedrcode => 0x00,
        ednsflags => 0x0000,
        optioncode => 0x51,
        optiondata => pack("C4", @iplist) 
);

#Push OPT into Query
$query->push(additional => $opt);

#Sign Query
$query->sign_tsig($tsig);

$query->print;

#Send Query
$response = $res->send($query);

if($response){
	foreach $_ ($response->answer){
		print $_->rdatastr."\n";
	}
}
