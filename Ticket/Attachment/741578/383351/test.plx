#!/usr/bin/perl

use autovivification;

{
    my $foo = 42;

    sub closure {
        return $foo;
    }
}

my @options = qw/Indent Terse Useqq Sortkeys Deparse/;
sub as_perl {
    require Data::Dumper;

    my $self    = shift;
    my $dumper = Data::Dumper->new([$self]);

    for my $option (@options) {
        my ($opt, @opt_args) = ref $option ? @$option : ($option, 1);
                
        $dumper->$opt(@opt_args) if $dumper->can($opt);
    }

    return $dumper->Dump;
}


my $closure = \&closure;
print eval( as_perl($closure) );


