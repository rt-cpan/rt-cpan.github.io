{
	package MyRole;
	use Moose::Role;
	has monkeys => (is => 'rw');
	requires 'bananas';
}

use MooseX::ClassCompositor;
use Test::More tests => 3;

my $comp  = MooseX::ClassCompositor->new(
	class_basename => 'MyClass',
	);
my $class = $comp->class_for(
	{ bananas => sub { 'yellow ones' } },
	'MyRole',
	);
my $inst = $class->new(monkeys => 1);

ok($inst->DOES('MyRole'), "$class\->does('MyRole')");
can_ok($inst => 'bananas');
can_ok($inst => 'monkeys');
