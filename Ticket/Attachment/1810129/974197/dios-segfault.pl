use Dios;


sub direct_assignment {
    my $int_attr = 10;
    Dios::Types::_set_var_type(
        q{Int},
        \$int_attr,
        'Value (%s) for $int_attr attribute',
        sub { $_ > 0 }
    );
}

direct_assignment();
