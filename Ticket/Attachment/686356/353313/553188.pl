#!/usr/bin/perl

use Net::LDAP::Util qw(canonical_dn);

my $dn1 = "cn=tester\\, karl,ou=test,dc=example,dc=com";
my $dn2 = "cn=tester\\,  karl,ou=test,dc=example,dc=com";

print canonical_dn($dn1), "\n";
print canonical_dn($dn2), "\n";
