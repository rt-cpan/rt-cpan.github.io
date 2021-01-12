#!/usr/bin/perl -w

use Net::SIP;
use Net::SIP::Debug;

Net::SIP::Debug->level(200);

my $buf = 
'SIP/2.0 180 Ringing
allow: ACK,BYE,CANCEL,INFO,INVITE,NOTIFY,OPTIONS,PING,REFER,REGISTER,SUBSCRIBE
call-id: 2368909d39576afcaa947cbff24892ab
contact: <sip:any@10.5.0.1:5060>
content-length: 0
cseq: 1 INVITE
from: 0919376649 <sip:0919376649@sfr.fr>;tag=f8ff602e4f2143cab4ae3246a7d0df68
to: 0972807269 <sip:0972807269@sfr.fr>;tag=397496836
via: SIP/2.0/UDP 10.5.0.63;branch=z9hG4bK5a40f5a153a46ad6f2e6c8e08ec71b1c9775ead74afd00e19f6348a548ce96f5
Content-Length: 0

';

my $packet = eval { Net::SIP::Packet->new( $buf ) };

print "Packet=/n".$packet->dump(100);