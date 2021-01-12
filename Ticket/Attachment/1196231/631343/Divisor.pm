package Divisor;

use Mouse;

has 'numerator' => (is => 'rw', isa => 'Num', required => 1);
has 'denominator' => (is => 'rw', isa => 'Num', required => 1);
has 'quotient' => (is => 'ro', isa => 'Num', lazy => 1,
                builder => '_calc_quotient');

sub _calc_quotient {
    my ($self) = @_;

    return $self->numerator / $self->denominator;
}

1;
