use Modern::Perl;

use Regexp::Grammars;
use YAML::Any qw(Dump);

my $grammar =
  qr{
     #<debug:run>

     <nocontext:>

     \A <statements>
     (?: \Z
       | <error: (?{ "Trailing text index $INDEX: '$CONTEXT'" })>
     )

     <token: ws>
       (?: \s+ | \#[^\n]* )*+

     <rule: statements>
       <[statement]>+ % [,]

     <rule: statement>
       <spec> : <fieldname>
       | \[ <count> \] \{ <statements> \}
       | <error:>

     <rule: count>
       <pptemplate>
       | \* <fieldname>
       | <funcname> \( <count> \)

     <rule: spec>
       <pptemplate>
       | <funcname> \( <spec> \)

     <token: fieldname>
       \w++

     <token: funcname>
       \w++

     <token: pptemplate>
       \w++
    }s;

my $input = <<EOD;
N : count,
[a(b(*count))] { square(N) : foo, # yes, foo!
  C3 : bar }  # and bar, too
EOD

if ($input =~ $grammar) {
  print "Match:\n", Dump(\%/);
} else {
  print "No match:\n ", join("\n ", @!);
}
