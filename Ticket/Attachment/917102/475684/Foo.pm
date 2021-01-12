package Foo;

use Moo;
use Sub::Quote;
has with_sub  => (is => 'rw', isa => sub { $_[0] =~ /^[+-]?\d+$/ });
has with_qsub => (is => 'rw', isa => quote_sub q{ $_[0] =~ /^[+-]?\d+$/ });

1;
