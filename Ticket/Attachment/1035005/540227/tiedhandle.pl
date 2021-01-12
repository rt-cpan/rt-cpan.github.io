use strict;
use warnings;

use Data::Dumper qw(Dumper);
use Spawn::Safe;

# tie STDIN to a buggy Tie::Handle implementation like FCGI does
tie *STDIN, 'My::Handle';

my $result = spawn_safe('date');
warn Dumper($result);
exit;

# buggy Tie::Handle implementation, play wrong as FCGI does
{
    package My::Handle;
    use Carp qw(croak);

    require Tie::Handle;
    @My::Handle::ISA = qw(Tie::Handle);

    sub TIEHANDLE { bless {}, shift }
    sub OPEN  { croak "Buggy OPEN in package 'My::Handle', died"; }
    sub PRINT { croak "Buggy PRINT in package 'My::Handle', died"; }
}
