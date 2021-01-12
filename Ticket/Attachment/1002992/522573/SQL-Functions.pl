#!/usr/bin/perl

=head2 Numeric Functions

=head3 abs, ceiling, floor, round, truncate, exp, log, ln, log10, mod, power, rand, sign, sqrt

B<ABS>

 # purpose   : find the absolute value of a given numeric expression
 # arguments : numeric expression

=cut

sub SQL_FUNCTION_ABS { return abs($_[2]); }

=pod

B<CEILING> (aka B<CEIL>) & B<FLOOR>

 # purpose   : rounds up/down to the nearest integer
 # arguments : numeric expression

=cut

sub SQL_FUNCTION_CEILING { my $i = int($_[2]); return $i == $_[2] ? $i : $i + 1; }
sub SQL_FUNCTION_FLOOR   { return int($_[2]); }
*SQL_FUNCTION_CEIL = \&SQL_FUNCTION_CEILING;

=pod

B<ROUND>

 # purpose   : round X with Y number of digits
 # arguments : X, optional Y defaults to 0

=cut

sub SQL_FUNCTION_ROUND { return sprintf("%.*f", int($_[3]), $_[2]); }

=pod

B<TRUNCATE> aka B<TRUNC>

 # purpose   : similar to ROUND, but removes the decimal
 # arguments : X, optional Y defaults to 0

=cut

sub SQL_FUNCTION_TRUNCATE { my $d = 10 ** int($_[3]); return sprintf("%.*f", int($_[3]), int($_[2]*$d) / $d); }
*SQL_FUNCTION_TRUNC = \&SQL_FUNCTION_TRUNCATE;

=pod

B<EXP>

 # purpose   : raise e to the power of a number
 # arguments : numeric expression

=cut

sub SQL_FUNCTION_EXP { return (sinh(1)+cosh(1)) ** $_[2]; }  # e = sinh(X)+cosh(X)

=pod

B<LOG>

 # purpose   : base B logarithm of X
 # arguments : B, X or just one argument of X for base 10

=cut

sub SQL_FUNCTION_LOG { return $_[3] ? log($_[3]) / log($_[2]) : log($_[2]) / log(10); }

=pod

B<LN> & B<LOG10>

 # purpose   : natural logarithm (base e) or base 10 of X
 # arguments : numeric expression

=cut

sub SQL_FUNCTION_LN    { return log($_[2]); }
sub SQL_FUNCTION_LOG10 { return SQL_FUNCTION_LOG(@_[0..2]); }

=pod

B<MOD>

 # purpose   : modulus, or remainder, left over from dividing X / Y
 # arguments : X, Y

=cut

sub SQL_FUNCTION_MOD { return $_[2] % $_[3]; }

=pod

B<POWER> aka B<POW>

 # purpose   : X to the power of Y
 # arguments : X, Y

=cut

sub SQL_FUNCTION_POWER { return $_[2] ** $_[3]; }
*SQL_FUNCTION_POW = \&SQL_FUNCTION_POWER;

=pod

B<RAND>

 # purpose   : random fractional number greater than or equal to 0 and less than the value of X
 # arguments : X (with optional seed value of Y)

=cut

sub SQL_FUNCTION_RAND { $_[3] && srand($_[3]); return rand($_[2]); }

=pod

B<SIGN>

 # purpose   : returns -1, 0, 1, NULL for negative, 0, positive, NULL values, respectively
 # arguments : numeric expression

=cut

sub SQL_FUNCTION_SIGN { return defined($_[2]) ? ($_[2] <=> 0) : undef; }

=pod

B<SQRT>

 # purpose   : square root of X
 # arguments : X

=cut

sub SQL_FUNCTION_SQRT { return sqrt($_[2]); }

=pod

=head2 Trigonometric Functions

=head3 acos, acosec, acosech, acosh, acot, acotan, acotanh, acoth, acsc, acsch, asec, asech, asin, asinh, atan, atan2, atanh, cos, cosec, cosech, cosh, cot, cotan, cotanh, coth, csc, csch, deg2deg, deg2grad, deg2rad, degrees, grad2deg, grad2grad, grad2rad, pi, rad2deg, rad2grad, rad2rad, radians, sec, sech, sin, sinh, tan, tanh

All of these functions work exactly like their counterparts in L<Math::Trig>; go there for documentation.  B<RADIANS> and B<DEGREES> are included for SQL-92 compatibility, and map to B<DEG2RAD> and B<RAD2DEG>, respectively.

=cut

use Math::Trig;  # core module since Perl 5.004

sub SQL_FUNCTION_ACOS      { return acos      ($_[2]);        }
sub SQL_FUNCTION_ACOSEC    { return acosec    ($_[2]);        }
sub SQL_FUNCTION_ACOSECH   { return acosech   ($_[2]);        }
sub SQL_FUNCTION_ACOSH     { return acosh     ($_[2]);        }
sub SQL_FUNCTION_ACOT      { return acot      ($_[2]);        }sub SQL_FUNCTION_ACOTAN    { return acotan    ($_[2]);        }sub SQL_FUNCTION_ACOTANH   { return acotanh   ($_[2]);        }sub SQL_FUNCTION_ACOTH     { return acoth     ($_[2]);        }sub SQL_FUNCTION_ACSC      { return acsc      ($_[2]);        }sub SQL_FUNCTION_ACSCH     { return acsch     ($_[2]);        }sub SQL_FUNCTION_ASEC      { return asec      ($_[2]);        }sub SQL_FUNCTION_ASECH     { return asech     ($_[2]);        }sub SQL_FUNCTION_ASIN      { return asin      ($_[2]);        }sub SQL_FUNCTION_ASINH     { return asinh     ($_[2]);        }sub SQL_FUNCTION_ATAN      { return atan      ($_[2]);        }sub SQL_FUNCTION_ATAN2     { return atan2     ($_[2], $_[3]); }sub SQL_FUNCTION_ATANH     { return atanh     ($_[2]);        }sub SQL_FUNCTION_COS       { return cos       ($_[2]);        }
sub SQL_FUNCTION_COSEC     { return cosec     ($_[2]);        }
sub SQL_FUNCTION_COSECH    { return cosech    ($_[2]);        }sub SQL_FUNCTION_COSH      { return cosh      ($_[2]);        }sub SQL_FUNCTION_COT       { return cot       ($_[2]);        }sub SQL_FUNCTION_COTAN     { return cotan     ($_[2]);        }sub SQL_FUNCTION_COTANH    { return cotanh    ($_[2]);        }
sub SQL_FUNCTION_COTH      { return coth      ($_[2]);        }sub SQL_FUNCTION_CSC       { return csc       ($_[2]);        }sub SQL_FUNCTION_CSCH      { return csch      ($_[2]);        }sub SQL_FUNCTION_DEG2DEG   { return deg2deg   ($_[2]);        }
sub SQL_FUNCTION_RAD2RAD   { return rad2rad   ($_[2]);        }
sub SQL_FUNCTION_GRAD2GRAD { return grad2grad ($_[2]);        }
sub SQL_FUNCTION_DEG2GRAD  { return deg2grad  ($_[2], $_[3]); }sub SQL_FUNCTION_DEG2RAD   { return deg2rad   ($_[2], $_[3]); }sub SQL_FUNCTION_DEGREES   { return rad2deg   ($_[2], $_[3]); }sub SQL_FUNCTION_GRAD2DEG  { return grad2deg  ($_[2], $_[3]); }sub SQL_FUNCTION_GRAD2RAD  { return grad2rad  ($_[2], $_[3]); }sub SQL_FUNCTION_PI        { return pi;                       }sub SQL_FUNCTION_RAD2DEG   { return rad2deg   ($_[2], $_[3]); }sub SQL_FUNCTION_RAD2GRAD  { return rad2grad  ($_[2], $_[3]); }sub SQL_FUNCTION_RADIANS   { return deg2rad   ($_[2], $_[3]); }sub SQL_FUNCTION_SEC       { return sec       ($_[2]);        }sub SQL_FUNCTION_SECH      { return sech      ($_[2]);        }sub SQL_FUNCTION_SIN       { return sin       ($_[2]);        }sub SQL_FUNCTION_SINH      { return sinh      ($_[2]);        }sub SQL_FUNCTION_TAN       { return tan       ($_[2]);        }sub SQL_FUNCTION_TANH      { return tanh      ($_[2]);        }
=head2 String Functions

=head3 --- Attach to existing #String_Functions ---

B<BIT_LENGTH>

 # purpose   : length of the string in bits
 # arguments : string

=cut

*SQL_FUNCTION_IFNULL           = \&SQL_FUNCTION_COALESCE;
*SQL_FUNCTION_CHARACTER_LENGTH = \&SQL_FUNCTION_CHARACTER_LENGTH;
*SQL_FUNCTION_UCASE            = \&SQL_FUNCTION_UPPER;
*SQL_FUNCTION_LCASE            = \&SQL_FUNCTION_LOWER;

sub SQL_FUNCTION_BIT_LENGTH {
   my @v = @_[0..1]; my $str = $_[2];
   # Number of bits on first character = CEIL(LOG2(ord($str))) + rest of string = OCTET_LENGTH(substr($str, 1)) * 8
   return SQL_FUNCTION_CEILING(@v, SQL_FUNCTION_LOG(@v, ord($str), 2)) + SQL_FUNCTION_OCTET_LENGTH(@v, substr($str, 1)) * 8;
}

=pod

B<OCTET_LENGTH>

 # purpose   : length of the string in bytes (not characters)
 # arguments : string

=cut

use Encode;  # core module since Perl 5.7.1

sub SQL_FUNCTION_OCTET_LENGTH { return length(Encode::encode_utf8($_[2])); }  # per Perldoc

=pod

B<TRANSLATE>

 # purpose   : transliteration; replace a set of characters in a string with another set of characters (a la tr///)
 # arguments : string, string to replace, replacement string

=cut

sub SQL_FUNCTION_TRANSLATE {
   my ($self, $owner, $str, $oldlist, $newlist) = @_;
   $oldlist =~ s{(/\-)}{\\$1}g;
   $newlist =~ s{(/\-)}{\\$1}g;
   eval "$str =~ tr/$oldlist/$newlist/";
   return $str;
}

=pod

B<ASCII> & B<CHAR>

 # purpose   : same as ord and chr, respectively
 # arguments : string or character (or number for CHAR)

=cut

sub SQL_FUNCTION_ASCII { return ord($_[2]); }
sub SQL_FUNCTION_CHAR  { return chr($_[2]); }

=pod

B<INSERT>

 # purpose   : string where L characters have been deleted from STR1, beginning at S, and where STR2 has been inserted into STR1, beginning at S.
 # arguments : STR1, S, L, STR2

=cut

sub SQL_FUNCTION_INSERT {  # just like a 4-parameter substr in Perl
   my $str = $_[2];
   substr($str, @_[3..5]);
   return $str; 
}

=pod

B<LOCATE>

 # purpose   : starting position (one-based) of the first occurrence of STR1 within STR2
 # arguments : STR1, STR2, and an optional S (starting position to search)

=cut

sub SQL_FUNCTION_LOCATE {
   my ($self, $owner, $substr, $str, $s) = @_;
   $s = int($s);
   my $pos = index( substr($str, $s), $substr ) + 1;
   return $pos && $pos + $s;
}

=pod

B<LEFT> & B<RIGHT>

 # purpose   : leftmost or rightmost L characters in STR
 # arguments : STR1, L

=cut

sub SQL_FUNCTION_LEFT  { return substr($_[2], 0, $_[3]); }
sub SQL_FUNCTION_RIGHT { return substr($_[2], -$_[3]); }

=pod

B<LTRIM> & B<RTRIM>

 # purpose   : left/right counterparts for TRIM
 # arguments : string

=cut

sub SQL_FUNCTION_LTRIM {
   my $str = $_[2];
   $str =~ s/^\s+//;
   return $str; 
}
sub SQL_FUNCTION_RTRIM {
   my $str = $_[2];
   $str =~ s/\s+$//;
   return $str; 
}

=pod

B<REPEAT>

 # purpose   : string composed of STR1 repeated C times.
 # arguments : STR1, C

=cut

sub SQL_FUNCTION_REPEAT { return $_[2] x int($_[3]); }

=pod

B<SPACE>

 # purpose   : a string of spaces
 # arguments : number of spaces

=cut

sub SQL_FUNCTION_SPACE { return ' ' x int($_[2]); }

=head2 System Functions

=head3 

B<DBNAME> & B<USERNAME>

 # purpose   : name of the database / username
 # arguments : none

=cut

sub SQL_FUNCTION_DBNAME   { return $_[1]->{Database}{Name};         }
sub SQL_FUNCTION_USERNAME { return $_[1]->{Database}{CURRENT_USER}; }
