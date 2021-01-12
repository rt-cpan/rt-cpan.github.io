#!/usr/bin/env perl 

use strict;
use warnings;
# FILENAME: benchmark.pl
# CREATED: 09/09/11 19:18:45 by Kent Fredric (kentnl) <kentfredric@gmail.com>
# ABSTRACT: benchmark file::spec functions

use File::Spec;

sub _do_catdir {
  File::Spec->catdir('x', 'y');
}
sub _do_canonpath {
  File::Spec->canonpath('x/y');
}
sub _handrolled_catdir {
  shift;
  join q{/}, @_ ; 
}
sub _handrolled_canonpath {
  return $_[1];
}
sub _do_handrolled_catdir {
  __PACKAGE__->_handrolled_catdir('x', 'y' );
}
sub _do_handrolled_canonpath {
  __PACKAGE__->_handrolled_canonpath('x/y');
}
sub _do_nop {

}

use Benchmark qw( :all :hireswallclock );

cmpthese( -2 , {
    nop => sub { _do_nop },
    catdir => sub { _do_catdir },
    canonpath => sub { _do_canonpath },
    hand_catdir => sub { _do_handrolled_catdir },
    hand_canonpath => sub { _do_handrolled_canonpath },
});
