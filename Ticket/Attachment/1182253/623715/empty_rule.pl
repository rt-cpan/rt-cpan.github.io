use Marpa::R2;
my $grammar = Marpa::R2::Scanless::G->new({   
	source          => \(<<'END_OF_SOURCE'),
    empty_rule ::=
    :start ::= Number
    Number ~ [\d]+
END_OF_SOURCE
    }
);
