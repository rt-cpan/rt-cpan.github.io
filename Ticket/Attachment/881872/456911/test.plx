use Devel::Hide qw(Readonly::XS);
use Readonly;

Readonly         my $this  => 23;
Readonly::Scalar my $that => 42;

print "Blessing this\n";
bless \$this, "Some::Class";

print "Blessing that\n";
bless \$that, "Some::Class";
