{
    package Foo;
    use Mousse;
    has foo => is => "rw", isa => "Int";
    has bar => is => "rw", isa => "Int";

    override BUILDARGS => sub {
        my $args = super;
        $args->{foo} = 42;
        return $args
    };
}

my $o = Foo->new(bar => 23);

use Test::More tests => 2;
is $o->foo, 42;
is $o->bar, 23;
