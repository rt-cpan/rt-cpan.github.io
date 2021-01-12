# vim: filetype=perl :
use strict;
use warnings;

use Test::More tests => 111; # last test to print

my $module = 'Net::Amazon::S3::ACL';

require_ok($module);

my $xml = <<'END';
<?xml version="1.0" encoding="UTF-8"?>
<AccessControlPolicy xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
  <Owner>
    <ID>yadda</ID>
    <DisplayName>whatever</DisplayName>
  </Owner>
  <AccessControlList>
    <Grant>
      <Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="AmazonCustomerByEmail">
        <EmailAddress>foo@example.com</EmailAddress>
      </Grantee>
      <Permission>READ_ACP</Permission>
    </Grant>
    <Grant>
      <Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="CanonicalUser">
        <ID>yadda</ID>
        <DisplayName>whatever</DisplayName>
      </Grantee>
      <Permission>FULL_CONTROL</Permission>
    </Grant>
    <Grant>
      <Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="Group">
        <URI>http://acs.amazonaws.com/groups/global/AllUsers</URI>
      </Grantee>
      <Permission>READ</Permission>
    </Grant>
  </AccessControlList>
</AccessControlPolicy>
END

{
   my $acl = $module->new();
   $acl->parse($xml);

   is($acl->owner_id(),          'yadda',    'owner_id');
   is($acl->owner_displayname(), 'whatever', 'owner_displayname');

   ok(my $grants = $acl->grants(), 'grants list exists');

   is(scalar(keys %$grants), 3, 'acl has right number of elements');

   {
      ok(exists($grants->{yadda}), 'ID yadda is in acl');
      ok(my $by_id = $grants->{yadda}, 'yadda points to something');
      is($by_id->{type}, 'ID',    'yadda is of type ID');
      is($by_id->{id},   'yadda', 'id is yadda');
      is($by_id->{displayname}, 'whatever',
         "yadda's display name is correct");
      is($by_id->{permissions}[0], 'FULL_CONTROL', "yadda's permissions");
   }

   {
      ok(exists($grants->{'foo@example.com'}), 'email is in acl');
      ok(my $by_email = $grants->{'foo@example.com'},
         'email points to something');
      is($by_email->{type}, 'email', 'email is of the right type');
      is($by_email->{email}, 'foo@example.com', 'email is correct');
      is($by_email->{permissions}[0], 'READ_ACP', "email's permissions");
   }

   {
      my ($anonkey) = grep { /AllUsers/ } keys %$grants;
      ok($anonkey, 'anonymous is in acl');
      like($anonkey, qr{\A http://}mxs, 'anonymous is specified by URI');
      ok(my $by_uri = $grants->{$anonkey}, 'anonymous points to something');
      is($by_uri->{type}, 'URI',    'anonymous is of the right type');
      is($by_uri->{URI},  $anonkey, 'URI is correct');
      is($by_uri->{permissions}[0], 'READ', "URI's permissions");
   }

   # Delete anonymous
   $acl->delete('*');
   is(keys(%$grants), 2, 'one less key after deletion');
   ok(! scalar(grep { /AllUsers/ } keys %$grants), 'anonymous was deleted');

   $acl->delete('yadda');
   $acl->delete('foo@example.com');
   is(keys(%$grants), 0, 'no more grants in acl');

   # Add new items
   $acl->add(
      foo               => 'READ',
      'bar@example.com' => '*',
      authenticated     => 'W',
      '*' => '*',
   );

   {
      ok(exists($grants->{foo}), 'ID foo created in acl');
      ok(my $by_id = $grants->{foo}, 'foo points to something');
      is($by_id->{type}, 'ID',  'foo is of type ID');
      is($by_id->{id},   'foo', 'id is foo');
      is($by_id->{displayname}, undef,
         "foo's display name is correctly not set");
      is($by_id->{permissions}[0], 'READ', "foo's permissions");
   }

   {
      ok(exists($grants->{'bar@example.com'}), 'email created in acl');
      ok(my $by_email = $grants->{'bar@example.com'},
         'email points to something');
      is($by_email->{type}, 'email', 'email is of the right type');
      is($by_email->{email}, 'bar@example.com', 'email is correct');
   }

   {
      my ($anonkey) = grep { /AllUsers/ } keys %$grants;
      ok($anonkey, 'anonymous is in acl');
      like($anonkey, qr{\A http://}mxs, 'anonymous is specified by URI');
      ok(my $by_uri = $grants->{$anonkey}, 'anonymous points to something');
      is($by_uri->{type}, 'URI',    'anonymous is of the right type');
      is($by_uri->{URI},  $anonkey, 'URI is correct');
      is($by_uri->{permissions}[0], 'FULL_CONTROL', "URI's permissions");
   }

   {
      my ($anonkey) = grep { /AuthenticatedUsers/ } keys %$grants;
      ok($anonkey, 'anonymous is in acl');
      like($anonkey, qr{\A http://}mxs, 'anonymous is specified by URI');
      ok(my $by_uri = $grants->{$anonkey}, 'anonymous points to something');
      is($by_uri->{type}, 'URI',    'anonymous is of the right type');
      is($by_uri->{URI},  $anonkey, 'URI is correct');
      is($by_uri->{permissions}[0], 'WRITE', "URI's permissions");
   }

   my %variants = (
      WRITE => [qw( w write WriTE > )],
      READ => [qw( r read rEAd < )],
      FULL_CONTROL => [qw( f FULL fuLL_COntrol full-conTROL * )],
      WRITE_ACP => [qw( wP write_acp WriTE-acp )],
      READ_ACP => [qw( Rp read-ACp rEAd_acp )],
   );

   while (my ($main, $variants) = each %variants) {
      for my $variant (@$variants) {
         $acl->delete('foo');
         ok(! $grants->{foo}, 'foo deleted');
         $acl->add(foo => $variant);
         ok($grants->{foo}, 'foo re-added');
         is($grants->{foo}{permissions}[0], $main, "$main permission");
      }
   }

   my $xml_out = $acl->stringify();
   for my $regex (
      qr/AllUsers/,
      qr/AuthenticatedUsers/,
      qr/foo/,
      qr/bar\@example\.com/,
      qr/>WRITE</,
      qr/>READ_ACP</,
      qr/>FULL_CONTROL</,
   ) {
      like($xml_out, $regex, "$regex");
   }
}
