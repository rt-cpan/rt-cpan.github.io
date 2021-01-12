package App2;
use Moose;

with 'MooseX::Getopt::Usage';

has 'dry-run' => (
    is => 'ro',
    isa => 'Bool',
    default => 0,
    documentation => qq{Just say what we would do; not actually do it.},
);

1
