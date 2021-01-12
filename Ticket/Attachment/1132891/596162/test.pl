#!/usr/bin/env perl

use v5.14;
use Data::Dumper;
use Regexp::Debugger;

my $grammar = qr/
    \A (?&query) \z

    (?(DEFINE)
        (?<query>
            (?&return)
            (?&delimiter)
            (?&expression)
        )

        (?<return>
            (?&column_index)
            (?:
                (?&separator)
                (?&return)
            )*
        )

        (?<expression>
            (?&column_index)
            (?&op)
            (?&literal)
            (?:
                (?&separator)
                (?&expression)
            )*
        )

        (?<delimiter> [#] )

        (?<separator> , )

        (?<column_index> [0-9] (?![0-9]) )

        (?<literal> [0-9]+ )

        (?<conjuction> [&|] )

        (?<op> [<>!=] )
    )
/x;

my $in = '0,1,2#2<250&3>103000&4=105090&5!30000';
$in =~ /($grammar)/;
print Dumper(\%-, \%+);
