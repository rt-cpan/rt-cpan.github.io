#!/usr/bin/perl -wl

# Put WithMS first, it works.
{
    package WithMS;
    use Method::Signatures;

    my $counter = 99;
    method foo($class:) { $counter++ }
}

# Uncomment either of these, it passes
#print "here";
#print WithMXMS->can("foo") ? "yes" : "no";

sub test { print @_ }

# Never printed
print WithMS->can("foo") ? "yes" : "no";

# Never printed
print WithMS->foo;

# Printed
BEGIN { print "before"; }

# This seems to be called at compile time
test(WithMS->foo);
print WithMS->foo;

# Never printed
BEGIN { print "after"; }
