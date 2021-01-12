use MooseX::Declare;
use MooseX::ClassAttribute;
class MXDeclare with MooseX::Getopt {
    class_has ID => (
        isa     => 'Int',
        is      => 'ro',
        default => sub { int rand 1000 },
    );
    has name => (
        isa      => 'Str',
        is       => 'ro',
        required => 1,
    );
}
