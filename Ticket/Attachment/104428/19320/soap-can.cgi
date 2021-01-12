

#!/usr/local/bin/perl -w

use SOAP::Transport::HTTP;

SOAP::Transport::HTTP::CGI
  -> dispatch_to('foo')
  -> handle;

package foo;

sub new {
  my $class = shift;
  my $self  = {count => 0,};
  bless $self, $class;
}

sub bar {
  my $self = shift;
  ++$self->{count};
}

sub proxy {
  my $self = shift;
  my $meth = shift;
  if ($self->can($meth)) {
    return $self->$meth;
  } else {
    return;
  }
}

__END__

# This code works if it's a regular class

package main;

my $f = new foo();

print $f->bar, "\n";
if ($f->can("bar")) { print $f->bar, "\n"; }
if ($f->can("proxy")) { print $f->proxy("bar"), "\n"; }

__END__

# This code does not work when it's SOAP

use SOAP::Lite +autodispatch =>
   uri => 'http://secure.identry.net/foo',
   proxy => 'http://secure.identry.net/~admin17/cgi-bin/soap-can.cgi';

my $f = new foo() or die "Cannot create a foo";

print $f->bar(), "\n";
if ($f->can("bar")) { print $f->bar, "\n"; }
if ($f->can("proxy")) { print $f->proxy("bar"), "\n"; }

__END__
