#!/grid/common/bin/perl -w

use strict;

use v5.10;
use warnings;

my $calculator = do{
    use Regexp::Grammars;
    qr{
 <debug: run>
	<Answer>

        <rule: Answer>
		\d+
    }xms
};

print("data>>> ");
while (my $input = <>) {

    if ($input =~ $calculator->with_actions('Calculator_Actions') ) {
        say '--> ', $/{Answer};
    }
    print("data>>> ");
}

package Calculator_Actions;

use List::Util qw< reduce >;

sub Answer {
    my ($self, $MATCH) = @_;

    say "ANSWER called";

    my $value = "processed";

    return $value;
}
