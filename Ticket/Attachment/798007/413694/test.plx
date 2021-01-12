use MooseX::Declare;

class Baz {
    has foo =>
      isa       => "Str",
      is        => "rw",
      default   => method { print "default!" };

    has bar =>
      isa       => "Str",
      is        => "rw",
      trigger   => method { print "trigger!" };
}
