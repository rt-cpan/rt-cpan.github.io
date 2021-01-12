#!perl -w

BEGIN {
  eval { require bytes; };
}

use Test::Most;

BEGIN { $Date::Calc::XS_DISABLE = $Date::Calc::XS_DISABLE = 1; }

use Date::Calc qw( Decode_Date_EU Decode_Date_US );

use strict;

# ======================================================================
#   ($year,$mm,$dd) = Decode_Date_EU($buffer);
#   ($year,$mm,$dd) = Decode_Date_US($buffer);
# ======================================================================

plan tests => 25;

# format: [[parameters], [expected output]]
my $eu_tests = [
  [ ["3.1.64"],   [ 1964, 1, 3 ] ],
  [ ["3 1 64"],   [ 1964, 1, 3 ] ],
  [ ["03.01.64"], [ 1964, 1, 3 ] ],
  [ ["03/01/64"], [ 1964, 1, 3 ] ],
  [ [ "3. Ene 1964", 4 ], [ 1964, 1, 3 ] ],
  [ [ "Geburtstag: 3. Januar '64 in Backnang/Württemberg", 3 ], [ 1964, 1, 3 ] ],
  [ ["03-Jan-64"], [ 1964, 1, 3 ] ],
  [ [ "3.Jan1964", 6 ], [ 1964, 1, 3 ] ],
  [ [ "3Jan64",    0 ], [ 1964, 1, 3 ] ],
  [ ["030164"],    [ 1964, 1, 3 ] ],
  [ [ "3ja64", ],  [ 1964, 1, 3 ] ],
  [ [ "3164", ],   [ 1964, 1, 3 ] ],
  [ ["28.2.1995"], [ 1995, 2, 28 ] ],
  [ ["29.2.1995"], [] ],
];

foreach my $testcase (@$eu_tests) {
  my @arr = Decode_Date_EU( @{ $testcase->[0] } );
  is_deeply( \@arr, $testcase->[1], "parse " . join( ',', @{ $testcase->[0] } ) . " ok" );
}

my $us_tests = [
  [ ["1 3 64"],                           [ 1964, 1, 3 ] ],
  [ ["01/03/64"],                         [ 1964, 1, 3 ] ],
  [ ["Jan 3 '64"],                        [ 1964, 1, 3 ] ],
  [ ["Jan 3 1964"],                       [ 1964, 1, 3 ] ],
  [ ["===> January 3rd 1964 (birthday)"], [ 1964, 1, 3 ] ],
  [ ["Jan31964"],                         [ 1964, 1, 3 ] ],
  [ ["Jan364"],                           [ 1964, 1, 3 ] ],
  [ ["ja364"],                            [ 1964, 1, 3 ] ],
  [ ["1364"],                             [ 1964, 1, 3 ] ],
  [ ["2.28.1995"],                        [ 1996, 2, 28 ] ],
  [ ["2.29.1995"],                        [] ]
];

foreach my $testcase (@$us_tests) {
  my @arr = Decode_Date_US( @{ $testcase->[0] } );
  is_deeply( \@arr, $testcase->[1], "parse " . join( ',', @{ $testcase->[0] } ) . " ok" );
}

__END__

