use 5.010;
use warnings;

use Test::More 'no_plan'; 

my %hash = (
    do   => 'a deer',
    re   => 'a drop of golden sun',
    dore => 'a portal',
    me   => 'a name I call myself',
    fa   => 'a long long way to run',
);

my $other1 = 1;  # Needed to counteract bug in scoping (?)
my $other2 = 2;  #   "     "      "      "   "    "     "
my $other3 = 3;  #   "     "      "      "   "    "     "
my $other4 = 4;  #   "     "      "      "   "    "     "

my $listified = do {
    use Regexp::Grammars;
    qr{ <[WORD=%hash]>+ }xms;
};

my $first_only = do {
    use Regexp::Grammars;
    qr{ <WORD=%hash> }xms;
};
#warn defined $first_only;

my $no_cap = do {
    use Regexp::Grammars;
    qr{ <%hash>+ }xms;
};
#warn defined $first_only;

while (my $line = <DATA>) {
#warn defined $first_only;
    my ($input, $expected) = split /\s+/, $line;

#warn defined $first_only;
    if ($input =~ $listified) {
        is_deeply $/{WORD}, eval($expected), "list:   $input";
    }
    else { is 'FAIL', $expected, "list:   $input"; }

#warn defined $first_only;
    if ($input =~ $first_only) {
        is $/{WORD}, eval($expected)->[0], "scalar: $input";
    }
    else { is 'FAIL', $expected, "scalar: $input"; }

    if ($input =~ $no_cap) { isnt 'FAIL', $expected, "no-cap:  $input"; }
    else                   {   is 'FAIL', $expected, "no-cap:  $input"; }

}

__DATA__
dorefameredo    ['dore','fa','me','re','do']
dorefamell      ['dore','fa','me']
zzzzz           FAIL
zzzdoremezzz    ['dore','me']
