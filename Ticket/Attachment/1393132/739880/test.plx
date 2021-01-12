package Foo;

use Moo;
use Test::More;
use Data::Dumper;
$Data::Dumper::Deparse = 1;

note "Moo version: $Moo::VERSION";

my %has_args = (
  is        => 'rw',
  isa       => sub { !ref $_[0] },
  coerce    => sub { ref $_[0] ? "$_[0]" : $_[0] },
  default   => sub {
      ok !$SIG{__DIE__} or note explain $SIG{__DIE__};
      1;
  }
);

has with_coerce     => %has_args;

delete $has_args{coerce};
has without_coerce  => %has_args;

my $obj = Foo->new;
note "with_coerce";
$obj->with_coerce;

note "without_coerce";
$obj->without_coerce;

done_testing;

__END__
# Moo version: 1.005
not ok 1
#   Failed test at /Users/schwern/tmp/test.plx line 15.
# sub {
#     package Method::Generate::Accessor;
#     BEGIN {${^WARNING_BITS} = "\377\377\377\377\377\377\377\377\377\377\377\377\377\377?"}
#     use strict;
#     our($Method::Generate::Accessor::CurrentAttribute, $Method::Generate::Accessor::OrigSigDie);
#     my $sigdie = $OrigSigDie && $OrigSigDie != \&_SIGDIE ? $OrigSigDie : sub {
#         die $_[0];
#     }
#     ;
#     return &$sigdie(@_) if ref $_[0];
#     my $attr_desc = _attr_desc(@$CurrentAttribute{'name', 'init_arg'});
#     &$sigdie("$$CurrentAttribute{'step'} for $attr_desc failed: $_[0]");
# }
ok 2
# with_coerce
# without_coerce
1..2
# Looks like you failed 1 test of 2.
