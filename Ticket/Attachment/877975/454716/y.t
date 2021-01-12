#!perl

package X;

sub import {
    my $module = 'Carp';
    if ($module->isa('Exporter')) {
        print "require $module\n";
        eval  "require $module; print qq[wut\\n] if \$^H{wut}"
    } else {
        print "use $module\n";
        eval  "use $module;"
    }
}

package Y;

sub import {
    shift;
    X->import for 1 .. $_[0];
}

package main;

BEGIN {
    $^H |= 0x20000;
    $^H{wut} = 1;
}

BEGIN {
    Y->import($ARGV[0]);
}
