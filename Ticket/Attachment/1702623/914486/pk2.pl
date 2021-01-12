use v5.14;

BEGIN {
   package MyExample;
   $INC{'MyExample.pm'} = __FILE__;
   use base 'Exporter';
   use Parse::Keyword { example => \&_parse_example };
   use PadWalker ();
   our @EXPORT = 'example';
   sub example {
      shift->();
   }
   sub _parse_example {
      lex_read_space;
      my $code = parse_block;
      lex_read_space;
      return sub {
         my $closedover = PadWalker::closed_over($code);
         return $code unless keys %$closedover;
         sub {
            my $callervars = PadWalker::peek_my(2);
            $closedover->{$_} = $callervars->{$_} for keys %$closedover;
            PadWalker::set_closed_over($code, $closedover);
            goto $code;
         };
      };
   }
}

use MyExample 'example';

say example { 1 };
say example { 2 };
say example { 3 };

for our $package (1..3)
{
   say example { $package };
}

for my $lexical (1..3)
{
   say example { $lexical };
}



