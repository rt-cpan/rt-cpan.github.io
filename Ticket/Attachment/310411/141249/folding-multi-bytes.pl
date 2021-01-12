#!/usr/bin/perl

use strict;

use Data::ICal;

my($desc, $name);

my $cal = Data::ICal->new();

# two bytes characters test
#
# this string consists of "X-WR-CALNAME:" + 59 digits + 5 greek letters + 
# 65 digits + 5 greek letters.
# Five greek letters are (alpha: ce  b1) (beta: ce  b2  ce  b3  ce  b4  ce  b5
# These are all composed of two octets.
#
# If this string is folded between 75th and 76th octets, first "beta" is
# divided between 1st and 2nd octets.
# If the string is folded between 149th and 150th octets, the second line is
# folded between "alpha" and "beta" correctly.
#
# This string should be folded after 74th (after "alpha") and 148th
# (after "5") octets.

$desc =
  '12345678901234567890123456789012345678901234567890123456789' .
  'αβγδε' . 
  '12345678901234567890123456789012345678901234567890123456789012345' .
  'αβγδε';

# three bytes characters test
#
# this string consists of "X-WR-CALDESC:" + 58 digits +
# 5 Japanese hiragana letters + 58 digits + 5 hiragana letters + 61 digits +
# 5 hiragana letters
# Five Japanese hiragana letters are (A: e3  81  82) (I: e3  81  84)
# (U: e3  81  86) (E: e3  81  88) (O: e3  81  8a)
# These are all composed of three octets
# 
# If this string is folded between 75th and 76th octets, the first "I" is
# divided between 1st and 2nd octets.
# If this string is folded between 149th and 150th octets, the second "I" is
# divided between 2nd and 3rd octets.
# If the string is folded between 223rd and 224th octets, the third line is
# folded between "A" and "I" correctly.
#
# This string should be folded after 74th (after "A"), 148th
# (after "A"), and 222th (after "1") octets.

$name =
  '1234567890123456789012345678901234567890123456789012345678' .
  'あいうえお' .
  '1234567890123456789012345678901234567890123456789012345678' .
  'あいうえお' .
  '1234567890123456789012345678901234567890123456789012345678901' .
  'あいうえお';

$cal->add_properties(
  "x-wr-calname" => $name,
  "x-wr-caldesc" => $desc,
  );

print "123456789012345678901234567890123456789012345678901234567890123456789012345\n";
print $cal->as_string;
