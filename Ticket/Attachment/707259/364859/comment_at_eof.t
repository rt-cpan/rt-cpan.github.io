
use strict;
use warnings;

use Test::More tests => 8;

use JSON -support_by_pp;

use Data::Dumper qw( Dumper );

sub decoder {
   my ($str) = @_;

   my $json = JSON->new()
      ->allow_barekey
      ->relaxed;

   $json->incr_parse($_[0]);

   my $rv;
   if (!eval { $rv = $json->incr_parse(); 1 }) {
       $rv = "died with $@";
   }

   local $Data::Dumper::Useqq = 1;
   local $Data::Dumper::Terse = 1;
   local $Data::Dumper::Indent = 0;

   return Dumper($rv);
}


is( decoder( "[]"        ), '[]', 'array baseline' );
is( decoder( " []"       ), '[]', 'space ignored before array' );
is( decoder( "\n[]"      ), '[]', 'newline ignored before array' );
is( decoder( "# foo\n[]" ), '[]', 'comment ignored before array' );

is( decoder( ""        ), 'undef', 'eof baseline' );
is( decoder( " "       ), 'undef', 'space ignored before eof' );
is( decoder( "\n"      ), 'undef', 'newline ignored before eof' );
is( decoder( "# foo\n" ), 'undef', 'comment ignored before eof' );
