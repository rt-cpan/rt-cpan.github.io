#!/usr/bin/perl
use Net::DNS;
use Digest::MD5("md5_hex");

$t = 'v=DKIM1\; k=rsa\; t=y\; p=DEFfMA074X/SR+BW8yd4RaXMk+pSDwnr/SjT/b+HTNoZmxfkrYqk5eN5jnUewIDAQAB';
$rt = "porgy._domainkey.test3.com. IN TXT '$t'";
upd($rt);
exit;

sub upd {
my $ru = shift;
my $update = Net::DNS::Update->new("test3.com");
$update->push("update", rr_del("porgy._domainkey.test3.com. IN TXT"));
$update->push("update", rr_add($ru));
$update->sign_tsig("test3.com", "Yl1CRVlIQiZVLUldT08wSEEidm0jcFJ8aCJIWz0oZXI=");
my $res = Net::DNS::Resolver->new;
$res->nameservers('ns0.xtremeweb.de');
my $reply = $res->send($update);
print "\n------------------------- update:\n$ru\n";
# Did it work?
if ($reply) {
    if ($reply->header->rcode eq 'NOERROR') {
	print "Update succeeded\nNow make a 'host -a porgy._domainkey.test3.com. ns0.xtremeweb.de'\n";
    } else {
	print 'Update failed: ', $reply->header->rcode, "\n";
    }
} else {
    print 'Update failed: ', $res->errorstring, "\n";
}

}

