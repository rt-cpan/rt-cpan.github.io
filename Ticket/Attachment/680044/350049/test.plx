#!/usr/bin/perl -w

use Test::More;
use Regexp::Common;

my $hexdigit    = qr{[\da-f]}i;                                         # hex digit
my $ipv6_16     = qr{$hexdigit{1,4}}x;                                  # 16 bits
my $ipv6_32     = qr{(?: $ipv6_16 : $ipv6_16 ) | $RE{net}{IPv4} }x;     # 32 bits
my $ipv6_address= qr{
                                                (?: $ipv6_16 : ){6} $ipv6_32        |
                                             :: (?: $ipv6_16 : ){5} $ipv6_32        |
       (?:                       $ipv6_16 )? :: (?: $ipv6_16 : ){4} $ipv6_32        |
       (?: (?: $ipv6_16 : ){0,1} $ipv6_16 )? :: (?: $ipv6_16 : ){3} $ipv6_32        |
       (?: (?: $ipv6_16 : ){0,2} $ipv6_16 )? :: (?: $ipv6_16 : ){2} $ipv6_32        |
       (?: (?: $ipv6_16 : ){0,3} $ipv6_16 )? :: (?: $ipv6_16 : ){1} $ipv6_32        |
       (?: (?: $ipv6_16 : ){0,4} $ipv6_16 )? ::                     $ipv6_32        |
       (?: (?: $ipv6_16 : ){0,5} $ipv6_16 )? ::                     $ipv6_16        |
       (?: (?: $ipv6_16 : ){0,6} $ipv6_16 )? ::
}x;

# Entries in this list are tested as IPv6 addresses
my @are_ipv6 = qw(
2001:0db8:85a3:0000:0000:8a2e:0370:7334
2001:db8:85a3:0:0:8a2e:370:7334
2001:db8:85a3::8a2e:370:7334
2001:0db8:0000:0000:0000:0000:1428:57ab
2001:0db8:0000:0000:0000::1428:57ab
2001:0db8:0:0:0:0:1428:57ab
2001:0db8:0:0::1428:57ab
2001:0db8::1428:57ab
2001:db8::1428:57ab
0000:0000:0000:0000:0000:0000:0000:0001
::1
::ffff:12.34.56.78
::ffff:0c22:384e
2001:0db8:1234:0000:0000:0000:0000:0000
2001:0db8:1234:ffff:ffff:ffff:ffff:ffff
2001:db8:a::123
fe80::
::ffff:192.0.2.128
::ffff:c000:280
);

# Entries in this list are not IPv6 addresses
my @are_not_ipv6 = qw(
123
ldkfj
2001::FFD3::57ab
2001:db8:85a3::8a2e:37023:7334
2001:db8:85a3::8a2e:370k:7334
1:2:3:4:5:6:7:8:9
1::2::3
1:::3:4:5
1:2:3::4:5:6:7:8:9
::ffff:2.3.4
::ffff:257.1.2.3
1.2.3.4
);

for my $ipv6 (@are_ipv6) {
    like $ipv6, qr/^$ipv6_address$/, "$ipv6 is IPv6";
}

for my $ipv6 (@are_not_ipv6) {
    unlike $ipv6, qr/^$ipv6_address$/, "$ipv6 is not IPv6";
}

done_testing;
