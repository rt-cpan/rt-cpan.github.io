package Net::Amazon::S3::ACL;
use strict;
use warnings;
use Carp;

use Net::Amazon::S3;
use Data::Dumper;

use base qw(Class::Accessor::Fast);
__PACKAGE__->mk_accessors(qw( owner_id owner_displayname grants account ));

=head1 NAME

Net::Amazon::S3::ACL - convenience object for working with Amazon S3 Access Control Policies/Lists

=head1 SYNOPSIS

  use Net::Amazon::S3;

  my $bucket = $s3->bucket("foo");

  my $xml = $bucket->get_acl();   # gets ACL in XML format
  my $acl = $bucket->get_acl({}); # gets ACL as an object
  my $acl2 = $bucket->get_acl({key => $key});

  # Owner info
  my $owner_id = $acl->owner_id();
  my $owner_displayname = $acl->owner_displayname();

  while (my ($name, $grant) = each %{$acl->grants()}) {
     print "Policy for '$name':\n";
     print "   Type: $grant->{type}\n";
     if ($grant->{type} eq 'ID') {
        print "   AWS ID: $grant->{id}\n";
        print "   AWS Display Name: $grant->{displayname}\n";
     }
     elsif ($grant->{type} eq 'email') {
        print "   email address: $grant->{email}\n";
     }
     elsif ($grant->{type} eq 'URI') {
        print "   group definition URI: $grant->{URI}\n";
     }
     print '   Permissions: ', join(', ', @{$grant->{permissions}}), "\n";
  }

  $acl->clear(); # wipe all grants in ACL object

  # Straightforward addition of permissions, DWIM
  $acl->add(
     'foo@example.com' => 'READ',   # seems email, added as such
     'http://whatever/' => 'WRITE', # seems URI, added as such
     'dafadfda908940394...' => '*', # added as AWS identifier
  );

  # Detailed addition of permissions
  $acl->add(dummy => {
      id => 'long-AWS-ID-here',
      displayname => 'display-name-here',
      permissions => [qw( WRITE READ READ_ACP )],
  });

  $acl->delete($ID); # remove whole ACL for given ID
  $acl->delete($ID => 'READ'); # remove this permission only
  $acl->delete($ID => [qw( READ WRITE )]); # remove these permissions only

  $bucket->set_acl({acl => $acl});
  $bucket->set_acl({acl => $acl, key => 'whatever'});

  # If you need to play with this directly
  my $acl = Net::Amazon::S3::ACL->new();
  $acl->parse($xml);
  print $acl->stringify(); # stringifies to XML

  # If you have a Net::Amazon::S3 account object, pass it in!
  my $s3 = Net::Amazon::S3->new({...});
  my $acl = Net::Amazon::S3::ACL->new({account => $s3});

=head1 DESCRIPTION

This module represents an S3 Access Control List; it is a representation
of the XML ACL that is easier to handle. As such, there are methods 
that ease passing from one representation to the
other, namely L</parse> (to parse an XML document into an object) and
L</stringify> (to get the XML representation of the ACL).

An ACL is made of two main parts:

=over

=item B<owner>

the owner of the resource. It is represented by two different fields
in the ACL, namely:

=over

=item owner_id

that long string that identifies an AWS customer;

=item owner_displayname

the I<DisplayName> in Amazon's terminology.

=back

=item B<grants list>

the list of grants that are associated to the resource. It is
represented by a hash reference in which the keys identify the grantee,
and the values are hash references with the details.

You'll always find the following items:

=over

=item I<permissions>

array reference with a list of permissions, namely:

=over

=item READ

the resource can be read

=item READ_ACP

the Access Control Policy for the resource can be read

=item WRITE

the resource can be written

=item WRITE_ACP

the Access Control Policy for the resource can be written

=item FULL_CONTROL

commodity value that includes all of the above

=back

See Amazon's documentation for details about those values.


=item I<type>

Amazon S3 accepts the following types:

=over

=item ID

the grantee is specified through its AWS ID

=item email

the grantee is specified through the email address by which she has
registered to Amazon

=item URI

the grantee is actually a group identified by a URN. At the time of
writing, the following URIs are recognised:

=over

=item http://acs.amazonaws.com/groups/global/AuthenticatedUsers

for granting the permission to all AWS customers

=item http://acs.amazonaws.com/groups/global/AllUsers

for granting anonymous access

=back

=back

=back

Depending on the L</type>, you can also find the following items:

=over

=item I<id> (only with type I<ID>)

the AWS ID of the grantee

=item I<displayname> (only with type I<ID>)

the DisplayName of the grantee

=item I<email> (only with type I<email>)

=item I<URI> (only with type I<URI>)

=back

As a general note, you don't need to bother with grants list internals
if you want to set it: just use the L</add>, L</delete> and L</clear>
convienience methods, that try to DWIM.

=back

=head1 METHODS

=head2 new

Create a new ACL object. Expects a hash containing these arguments:

=over

=item account (optional)

a Net::Amazon::S3 object. Net::Amazon::S3::ACL never accesses the network
to do traffic, but this account object comes handy to perform parsing.
If you don't provide one, it will lazily get one by itself.

=item xml (optional)

if present, it's parsed as an XML document via L</parse>

=item owner_id

=item owner_displayname

owner-related info

=item grants

the ACL, i.e. the list of grants for this ACL. You shouldn't normally
use this parameter, but go through the L</add> method; in any case,
you can pass the ACL if you know what you're doing (e.g. it's ok to pass
the acl coming from another N::A::S3::ACL object).

=back

=cut

sub new {
   my $class = shift;

   my $params = shift || {};
   my $xml    = delete $params->{xml};
   my $self   = $class->SUPER::new($params);

   $self->parse($xml) if defined $xml;
   $self->grants({}) unless $self->grants();

   return $self;
} ## end sub new

# Lazy method to get a Net::Amazon::S3 account object. This is needed
# by the "parse" method in order to use the same parsing approach as
# Net::Amazon::S3 itself. This method initialises the "account"
# field if it's not already present. The account details for the
# object aren't important, because no network traffic will be
# generated.
sub _get_account {
   my $self = shift;

   my $account = $self->account();

   if (!$account) {
      $self->account(
         $account = Net::Amazon::S3->new(
            {
               aws_access_key_id     => 'dummy_id',
               aws_secret_access_key => 'dummy_secret',
            }
         )
      );
   } ## end if (!$account)

   return $account;
} ## end sub _get_account

=head2 parse

Parse and XML document and fills the ACL. The previous contents
of the ACL are wiped, if any.

Expects a single string with the XML document to parse.

Returns a reference to the ACL object.

=cut

sub parse {
   my ($self, $xml) = @_;

   my $xpc = $self->_get_account()->_xpc_of_content($xml);

   my ($owner_id, $owner_displayname) = $self->_parse_owner($xpc);
   $self->owner_id($owner_id);
   $self->owner_displayname($owner_displayname);

   $self->grants($self->_parse_grants($xpc));

   return $self;
} ## end sub parse

sub _parse_owner {
   my ($self, $xpc) = @_;

   my $id          = $xpc->findvalue('//s3:Owner/s3:ID');
   my $displayname = $xpc->findvalue('//s3:Owner/s3:DisplayName');

   return ($id, $displayname);
} ## end sub _parse_owner

sub _parse_grants {
   my ($self, $xpc) = @_;

   return {map { $self->_parse_grant($xpc, $_); }
        $xpc->findnodes('.//s3:AccessControlList/s3:Grant')};
} ## end sub _parse_acl

sub _parse_grant {
   my ($self, $xpc, $node) = @_;

   # Grantee
   my ($name, %grant);
   if (my $URI = $xpc->findvalue('.//s3:Grantee/s3:URI', $node)) {
      ($name = $URI) =~ s{.*/}{}mxs;
      $name =
          ($name eq 'AllUsers')           ? 'ALL'
        : ($name eq 'AuthenticatedUsers') ? 'AUTH'
        :                                   $URI;
      $grant{URI}  = $URI;
      $grant{type} = 'URI';
   } ## end if (my $URI = $xpc->findvalue...
   elsif (my $email =
      $xpc->findvalue('.//s3:Grantee/s3:EmailAddress', $node))
   {
      $name = $grant{email} = $email;
      $grant{type} = 'email';
   } ## end elsif (my $email = $xpc->findvalue...
   else {
      $grant{id} = $xpc->findvalue('.//s3:Grantee/s3:ID', $node);
      $name = $grant{displayname} =
        $xpc->findvalue('.//s3:Grantee/s3:DisplayName', $node);
      $grant{type} = 'ID';
   } ## end else [ if (my $URI = $xpc->findvalue...

   # Permission
   $grant{permissions} =
     [map { $_->to_literal() } $xpc->findnodes('.//s3:Permission', $node)];

   return $self->canonical($name, \%grant);
} ## end sub _parse_acl_grant

=head2 stringify

Renders the ACL object as an XML document that can be sent to S3.

Does not take parameters.

Returns the XML document.

=cut

sub stringify {
   my $self = shift;

   my $owner_chunk  = $self->_stringify_owner();
   my $grants_chunk = $self->_stringify_grants();

   # Indent for pretty printing
   s/^/   /mxsg for $owner_chunk, $grants_chunk;

   return <<"END_OF_ACL";
<?xml version="1.0" encoding="UTF-8"?>
<AccessControlPolicy>
$owner_chunk$grants_chunk
</AccessControlPolicy>
END_OF_ACL
} ## end sub stringify

sub _stringify_owner {
   my ($self) = @_;

   defined(my $owner_id = $self->owner_id()) or return '';
   my $owner_displayname = $self->owner_displayname();
   $owner_displayname = '' unless defined $owner_displayname;

   return <<"END_OF_OWNER";
<Owner>
   <ID>$owner_id</ID>
   <DisplayName>$owner_displayname</DisplayName>
</Owner>
END_OF_OWNER
} ## end sub _stringify_owner

sub _stringify_grants {
   my ($self) = @_;

   my $list = join "\n",
     map { $self->_stringify_grant($_); } values %{$self->grants()};

   $list =~ s/^/   /mxsg;    # indented
   return "<AccessControlList>\n$list\n</AccessControlList>";
} ## end sub _stringify_acl

sub _stringify_grant {
   my ($self, $item) = @_;

   my $grantee =
     $item->{type} eq 'ID'
     ? _grantee_by_id($item->{id}, $item->{displayname})
     : $item->{type} eq 'URI'   ? _grantee_by_URI($item->{URI})
     : $item->{type} eq 'email' ? _grantee_by_email($item->{email})
     :                            die 'you found a bug: ', Dumper $item;
   $grantee =~ s/^/   /mxsg;

   return join "\n", map {
      ;
      "<Grant>\n$grantee   <Permission>$_</Permission>\n</Grant>";
   } @{$item->{permissions}};
} ## end sub _stringify_grant

sub _grantee_by_id {
   my ($id, $displayname) = @_;

   # The DisplayName attribute is actually ignored by AWS, but for
   # sake of completeness we're including it here
   $displayname = '' unless defined $displayname;
   return <<"END_OF_GRANTEE";
<Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="CanonicalUser">
   <ID>$id</ID>
   <DisplayName>$displayname</DisplayName>
</Grantee>
END_OF_GRANTEE
} ## end sub _grantee_by_id

sub _grantee_by_email {
   my ($email) = @_;
   return <<"END_OF_GRANTEE";
<Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="AmazonCustomerByEmail">
   <EmailAddress>$email</EmailAddress>
</Grantee>
END_OF_GRANTEE
} ## end sub _grantee_by_email

sub _grantee_by_URI {
   my ($URI) = @_;
   return <<"END_OF_GRANTEE";
<Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="Group">
   <URI>$URI</URI>
</Grantee>
END_OF_GRANTEE
} ## end sub _grantee_by_URI

my %permission_normalisation_for = (
   WRITE        => 'WRITE',
   W            => 'WRITE',
   '>'          => 'WRITE',
   READ         => 'READ',
   R            => 'READ',
   '<'          => 'READ',
   FULL_CONTROL => 'FULL_CONTROL',
   'FULL-CONTROL' => 'FULL_CONTROL',
   FULL         => 'FULL_CONTROL',
   F            => 'FULL_CONTROL',
   '*'          => 'FULL_CONTROL',
   'WRITE_ACP'  => 'WRITE_ACP',
   'WP'         => 'WRITE_ACP',
   'WRITE-ACP'  => 'WRITE_ACP',
   'READ_ACP'   => 'READ_ACP',
   'RP'         => 'READ_ACP',
   'READ-ACP'   => 'READ_ACP',
);

my %group_URI_for = (
   'AUTHENTICATED' =>
     'http://acs.amazonaws.com/groups/global/AuthenticatedUsers',
   'AUTH' => 'http://acs.amazonaws.com/groups/global/AuthenticatedUsers',
   'ALL'  => 'http://acs.amazonaws.com/groups/global/AllUsers',
   'ANY'  => 'http://acs.amazonaws.com/groups/global/AllUsers',
   'ANONYMOUS' => 'http://acs.amazonaws.com/groups/global/AllUsers',
   'ANON'      => 'http://acs.amazonaws.com/groups/global/AllUsers',
   '*'         => 'http://acs.amazonaws.com/groups/global/AllUsers',
);

=head2 canonical

Gets the canonical representation for an item in the grants list of
the ACL.

It accepts the following positional parameters:

=over

=item target

the grantee to which the ACL applies. Note that it can be overridden
by the contents of the I<item> parameter if the conditions apply
(see below).

It can be given in different forms, which will be canonicalised:

=over

=item C<AUTHENTICATED>

=item C<AUTH>

refers to the group of "all authenticated AWS customers". This is
canonicalised to the URI of the group, i.e.
C<http://acs.amazonaws.com/groups/global/AuthenticatedUsers>.

=item C<ALL>

=item C<ANY>

=item C<ANONYMOUS>

=item C<ANON>

=item C<*>

refers to the anonymous user group, i.e. any user without authentication.
It's canonicalised to the URI of the group, i.e.
C<http://acs.amazonaws.com/groups/global/AllUsers>.

=item anything resembling a I<HTTP URI>

the target is left as-is and the I<item> type can be set to C<URI> if the
conditions apply.

=item anything with an C<@> inside

the target is left as-is and the I<item> type can be set to I<email> if
the conditions apply.

=item anything else

the target is left as-is and the I<item> type can be set to I<ID> if the
conditions apply.

=back


=item item

this can be different things, which yield to different behaviours:

=over

=item a string

in this case, the string is intepreted as a single permission. The
canonicalisation for this permission (case-insensitive) is based on
the following mappings:

=over

=item C<READ>

=item C<R>

=item C<< < >>

set the C<READ> permission

=item C<WRITE>

=item C<W>

=item C<< > >>

set the C<WRITE> permission

=item C<READ_ACP>

=item C<READ-ACP>

=item C<RP>

set the C<READ_ACP> permission

=item C<WRITE_ACP>

=item C<WRITE-ACP>

=item C<WP>

set the C<WRITE_ACP> permission

=item C<FULL_CONTROL>

=item C<FULL>

=item C<F>

=item C<< * >>

set the C<FULL_CONTROL> permission

=back

=item an array reference

this fall back to the string case, because every item in the array
is interpreted as a string above.

=item a hash reference

in this case the hash reference is supposed to be a valid acl element,
so no canonicalisation actions are performed except that duplicate
permissions are wiped out.

=back

=back

If the I<item> parameter is already a "valid" acl element, then the
I<target> parameter could be completely overridden and read from the
I<item> itself. For example, if the input I<item> is the following
hash reference:

   {
      type =>  'email',
      email => 'whatever@example.com',
   }

the I<target> will be set to the email address whatever the input value
is.

On the other hand, if the I<item> part is not a valid acl element,
the I<target> will be used to guess the actual item type and set the
I<item> accordingly. This is the very base of the DWIM behaviour.

=cut

sub canonical {
   my ($self, $target, $item) = @_;

   $item = [$item] unless ref $item;
   $item = {permissions => $item} unless ref($item) eq 'HASH';
   if (!exists $item->{type}) {    # guess what type it is...
      if (exists $item->{ID}) {
         $item->{type} = 'ID';
      }
      elsif (exists $item->{URI}) {
         $item->{type} = 'URI';
      }
      elsif (exists $item->{email}) {
         $item->{type} = 'email';
      }
      elsif ($target =~ /@/) {
         $item->{type}  = 'email';
         $item->{email} = $target;
      }
      elsif (exists $group_URI_for{uc $target}) {
         $item->{type} = 'URI';
         $item->{URI}  = $group_URI_for{uc $target};
      }
      else {
         $item->{type} = 'ID';
         $item->{id}   = $target;
         $item->{name} = '';
      }
   } ## end if (!exists $item->{type...

   $target =
       $item->{type} eq 'ID'    ? $item->{id}
     : $item->{type} eq 'URI'   ? $item->{URI}
     : $item->{type} eq 'email' ? $item->{email}
     :                            die 'you found a bug: ', Dumper $item;

   my %flag;
   $item->{permissions} = [
      grep   { !$flag{$_}++ }
        grep { defined }
        map  { $permission_normalisation_for{uc $_} }
        @{$item->{permissions} || []}
   ];

   return ($target, $item);
} ## end sub canonical

=head2 add

Adds permissions for a given list of grantees.

Accepts either a reference to a hash of grants to be added,
or a list which is interpreted as a sequence
of I<target>/I<permissions> pairs:

=over

=item target (or keys in the hashref)

the grantee to which this addition apply. The actual target
will be derived by means of L</canonical>, so you can refer to
items that are represented differently in the acl. For example,
if yo specify a C<*> target, the actual target will be the URI
for the anonymous group. See L</canonical> for more details about
how you can specify a target.

=item permissions (or values in the hashref)

this can be either a string with a single permission to be added,
or an array reference with a list of permissions to be added,
or an acl item (see L</DESCRIPTION> to know how acl items are
structured).

=back

Note that when given as a list, this is B<NOT> transformed into
a hash before the operations. This lets you specify the same
target multiple times, and the permissions for each occurrence will
be taken into account.

Also, note that this method's name is a bit misleading at the moment.
It seems that AWS only supports a single permission for each
grantee, so for example you can't set both READ and READ_ACP permissions
for a given grantee on a given resource. Hopefully, things will change
in the future. The bottom line is that the last thing that you "add"
is the one that is actually set remotely.

=cut

sub add {
   my $self = shift;
   my @grants = ref($_[0]) ? %{$_[0]} : @_;
   while (my ($target, $item) = splice @grants, 0, 2) {
      $self->_add($target, $item);
   }
   return;
} ## end sub add

sub _add {
   my $self = shift;
   my ($target, $item) = $self->canonical(@_);

   my $grants = $self->grants();
   $self->grants($grants = {}) unless $grants;

   my $previous = $grants->{$target} ||= $item;
   my %flag;    # to filter out duplicates
   $previous->{permissions} = [
      grep { !$flag{$_}++ } @{$previous->{permissions} || []},
      @{$item->{permissions} || []}
   ];

   delete $grants->{$target} unless @{$previous->{permissions}};

   return;
} ## end sub _add

=head2 delete

Removes permissions for a given list of grantees.

Accepts either a reference to a hash of grants to be deleted,
or a list which is interpreted as a sequence
of I<target>/I<permissions> pairs:

=over

=item target (or keys in the hashref)

the grantee to which this deletion apply. The actual target
will be derived by means of L</canonical>, so you can refer to
items that are represented differently in the acl. For example,
if yo specify a C<*> target, the actual target will be the URI
for the anonymous group. See L</canonical> for more details about
how you can specify a target.

=item permissions (or values in the hashref, optionally populated)

this can be either a string with a single permission to be removed,
or an array reference with a list of permissions to be removed,
or an acl item (see L</DESCRIPTION> to know how acl items are
structured).

If absent or undef or containing an undefined I<permissions> item,
the whole grant for the target is deleted.

=back

Note that when given as a list, this is B<NOT> transformed into
a hash before the operations. This lets you specify the same
target multiple times, and the permissions for each occurrence will
be taken into account.

=cut

sub delete {
   my $self = shift;
   my @grants = ref($_[0]) ? %{$_[0]} : @_;
   while (my ($target, $item) = splice @grants, 0, 2) {
      $self->_delete($target, $item);
   }
   return;
} ## end sub delete

sub _delete {
   my $self = shift;
   my ($target, $item) = $self->canonical(@_);

   my $grants = $self->grants() or return;
   my $perms = $item->{permissions} || [];
   if (scalar(@$perms)) {
      my $previous = $grants->{$target} or return;
      my %forbidden = map { $_ => 1 } @$perms;
      $previous->{permissions} =
        [grep { !$forbidden{$_} } @{$previous->{permissions} || []}];
      delete $grants->{$target} unless @{$previous->{permissions}};
   } ## end if (defined($item->{permissions...
   else {
      delete $grants->{$target};
   }
   return;
} ## end sub _delete

=head2 clear

Remove all grants in the ACL.

=cut

sub clear { $_[0]->grants({}); }

1;
__END__

=head1 SEE ALSO

L<Net::Amazon::S3> and L<Net::Amazon::S3::Bucket>.

=cut
