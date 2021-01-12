##############################################################################
#
# augment WorkBook class with formula evaluation methods
#
package Spreadsheet::ParseExcel::Workbook;

use strict;
use warnings;
use Scalar::Util qw(looks_like_number);
use List::Util qw(max);

sub debug { printf STDERR shift()."\n", @_ if $main::debug }
sub isnum ($) { looks_like_number($_[0]) }
sub popch { substr($_[0], -1, $_[1] || 1, '') }

# helper subs to convert from RC to A1 cell addresses and back
# RC addresses start at (0, 0)
sub RCtoA1 {
    my ($s, $r, $c) = @_;
    if ( @_ == 2 ) { $c = $r; $r = $s; }
    my $ac = '';
    $c++;
    do {
	$c--;
	$ac = chr(($c % 26) + 65) . $ac;
	$c = int( $c / 26);
    } while ( $c );
    $r++;
    return wantarray ? ($ac, $r) : $ac.$r;
}
sub A1toRC {
    my ($ar, $r) = @_;
    ($ar, $r) = ($ar =~ /([A-Z]+)(\d+)/) unless defined($r);
    my $c = 0;
    my $m = 1;
    while ( $ar ) {
	$c += (ord(popch($ar)) - 64)*$m;
	$m *= 26;
    }
    $c--;
    return ($r-1, $c);
}

# helper method to obtain cell data of current worksheet
sub Data {
    my ($self, $sheetno) = @_;
    $sheetno ||= $self->{_CurSheet} || 0;
    $self->{Worksheet}->[$sheetno]->{Cells};
}

# helper method to obtain an actual cell from a cell reference
sub cellof {
    my ($self, $s, $r, $c, $ro, $co) = @_;
    $ro = 0 unless defined($ro);
    $co = 0 unless defined($co);
    return $self->{Worksheet}->[$s]->{Cells}->[$r + $ro]->[$c + $co];
}

# get/set iteration limit
my $IterationLimit_default = 10;
sub get_iterationlimit {
    my ($self) = @_;
    $self->{IterationLimit} = $IterationLimit_default
      unless defined($self->{IterationLimit});
    return $self->{IterationLimit};
}
sub set_iterationlimit {
    my ($self, $itl) = @_;
    return $self->{IterationLimit} = $itl;
}

# get/set evaluation epsilon
my $Epsilon_default = 1e-6;
sub get_epsilon {
    my ($self) = @_;
    $self->{Epsilon} = $Epsilon_default
      unless defined($self->{Epsilon});
    return $self->{Epsilon};
}
sub set_epsilon {
    my ($self, $eps) = @_;
    return $self->{Epsilon} = $eps;
}

# evaluate all formulas within the workbook
sub evaluate {
    my ($self) = @_;
    use POSIX qw(DBL_MAX);
    my $current_error = 0;
    my $iter = 0;

    # set iteration limit and epsilon to defaults, if not already set
    $self->{IterationLimit} = $IterationLimit_default
      unless defined($self->{IterationLimit});
    $self->{Epsilon} = $Epsilon_default
      unless defined($self->{Epsilon});

    while ( ++$iter <= $self->{IterationLimit} ) {
	debug '*** ITERATION %d, current error %g', $iter, $current_error;
	$self->{CurrentIteration} = $iter;
	$current_error = 0;

	for my $cref ( @{$self->{Formulae}} ) {
	    my $cell = $self->cellof(@$cref);
	    $self->{_CurSheet} = $cref->[0];
	    my $oldval = $cell->{Val};

	    # evaluate cell
	    debug 'Evaluating cell %s formula (old value: %s)',
	      RCtoA1(@$cref).'', $cell->{Val};
	    $cell->evaluate($self);
	    debug 'Eval result: <%s>',
	      defined($cell->{Val}) ? $cell->{Val} : 'undef';

	    # determine evaluation error
	    my $cell_error;
	    if ( isnum($cell->{Val}) ) {
		$cell_error = abs($cell->{Val} - (isnum($oldval) ? $oldval : 0));
		$current_error = max($current_error, $cell_error);
	    }
	    else {
		# either a string formula, or a numeric formula resulting in
		# an error string - do a string compare, setting current_error
		# to 0 or 1.
		$cell_error = $cell->{Val} ne $oldval;
		$current_error = max($current_error, $cell_error);
	    }
	    debug 'Cell error %g, current error %g',
	      $cell_error, $current_error;
	}

	# continue iteration, if error still bigger than epsilon
	last if $current_error < $self->{Epsilon};
    }
    debug '*** ITERATION %d FINISHED, error now %g', $iter, $current_error;

    return $iter <= $self->{IterationLimit};
}


##############################################################################
#
# augment Cell object of Spreadsheet::ParseExcel for Formula parsing
#
package Spreadsheet::ParseExcel::Cell;

use strict;
use warnings;
use POSIX qw(floor ceil);
use Scalar::Util qw(looks_like_number);
use List::Util qw(min max sum reduce);

# utility subs
sub debug { printf STDERR shift()."\n", @_ if $main::debug }
sub isnum ($) { looks_like_number($_[0]) }
sub joinval { join ', ', map { defined($_) ? isnum($_) ? $_ : "'$_'" : 'undef' } @_ }
sub shiftch { substr($_[0], 0, $_[1] || 1, '') }
sub popn (@;$) { my ($a, $n) = @_; $n ||= 1; splice(@$a, $#$a + 1 - $n, $n) }
sub apply_to_listof_arrayrefs (&@) {
    my ($sub, $aref) = (shift(), []);
    my $maxlen = @{$_[0]};
    for ( my $i = 0; $i < $maxlen; $i++ ) {
	push @$aref, $sub->(map { $_->[$i] } @_); }
    return wantarray() ? @$aref : $aref;
}

my $sizeof = { C => 1, v => 2, d => 8 };
sub unpackstr {
    my ($fmt, $str, $bytepos) = @_;
    #printf STDERR "unpack %s <%s>\n", $fmt, $str;
    my @res = unpack($fmt, $str);
    my $siz = sum map { isnum($_) ? $_ : $sizeof->{$_} || 0 }
      ($fmt =~ /([A-Za-z]|\d+)/g);
    shiftch($_[1], $siz);	# $str of caller (formula string)
    $_[2] += $siz;		# $bytepos of caller
    return wantarray ? @res : $res[0];
}

##############################
#
# token handler sub references
# calling convention: $formula_string, callback-args...
# returns array of: ($token, $value, $value...)

# generic error function for worksheet errors and parse errors
my $errcode_of =
{
 0x00 => '#NULL!',
 0x07 =>'#DIV/0!',
 0x0F =>'#VALUE!',
 0x17 =>  '#REF!',
 0x1D => '#NAME?',
 0x24 =>  '#NUM!',
 0x2A =>   '#N/A!',
};
my $err = sub {
    my ($frml, $bytepos, $tok, $siz) = @_;
    my $msg = "not implemented";

    if ( defined($siz) ) {
	if ( isnum($siz) ) {
	    # number of bytes
	    shiftch($_[0], $siz);
	    $_[1] += $siz;
	}
	elsif ( $siz =~ /^[Cv]+$/ ) {
	    # unpack code
	    my $code = unpackstr($siz, $_[0], $_[1]);
	    $msg = $errcode_of->{$code} || '#UNKNOWN!';
	}
	else {
	    # error message
	    $msg = $siz;
	}
    }

    return ($tok, $msg);
};

# operator tokens without additional token values
my $noargs = sub {
    my ($frml, $bytepos, $tok, $pop) = @_;
    return ($tok, $pop);
};
my $unop = $noargs;
my $binop = $noargs;
my $paren = $noargs;

# tokens only ignoring unused attached value bytes
my $ignore = sub {
    my ($frml, $bytepos, $tok, $pop, $num, @args) = @_;
    shiftch($_[0], $num);	# update $frml (formula string)
    $_[1] += $num;		# update $bytepos
    return ($tok, $pop, @args);
};

# generic simple tokens with parseable token values attached (unpack format)
my $simple = sub {
    my ($frml, $bytepos, $tok, $fmt) = @_;
    return ($tok, unpackstr($fmt, $_[0], $_[1]));
};

# Function with fixed number of arguments
my $func = $simple;

# Function with variable arguments
my $funcv = sub {
    my ($frml, $bytepos, $tok, $fmt) = @_;

    my ($numargs, $funcidx) = unpackstr($fmt, $_[0], $_[1]);
    my $userprompt = $numargs & 0x80;
    $numargs &= 0x7f;
    my $ismacro = $funcidx & 0x8000;
    $funcidx &= 0x7fff;

    return ($tok, $funcidx, $numargs, $userprompt, $ismacro);
};

# 2D cell reference (A1)
my $ref = sub {
    my ($frml, $bytepos, $tok, $fmt) = @_;

    my ($row, $col, $flags) = unpackstr($fmt, $_[0], $_[1]);
    my ($relcol, $relrow) = ($flags & 0x40 ? 1 : 0, $flags & 0x80 ? 1 : 0);

    return ( $tok, $row, $col, $relrow, $relcol,
	     '('.Spreadsheet::ParseExcel::Workbook::RCtoA1($row, $col).')' );
};

# 2D area reference (A1:B2)
my $area = sub {
    my ($frml, $bytepos, $tok, $fmt) = @_;

    my ($firstrow, $lastrow, $firstcol, $firstflags, $lastcol, $lastflags) =
      unpackstr($fmt, $_[0], $_[1]);
    my ($frelcol, $frelrow) =
      ($firstflags & 0x40 ? 1 : 0, $firstflags & 0x80 ? 1 : 0);
    my ($lrelcol, $lrelrow) =
      ($lastflags & 0x40 ? 1 : 0, $lastflags & 0x80 ? 1 : 0);

    return ( $tok,
	     $firstrow, $firstcol, $frelrow, $frelcol,
	     $lastrow, $lastcol, $lrelrow, $lrelcol,
	     '('.Spreadsheet::ParseExcel::Workbook::RCtoA1($firstrow, $firstcol).':'.
	         Spreadsheet::ParseExcel::Workbook::RCtoA1($lastrow,  $lastcol).')' );
};

# special attributes
my $dispatch = sub {
    my ($frml, $bytepos, $tok, $fmt, $dispatch_hash) = @_;

    my ($flags) = unpackstr($fmt, $_[0], $_[1]);

    my ($dtok, @value) = ();
    # dispatch hash entry coderef
    if ( exists($dispatch_hash->{$flags}) ) {
	my $tok_ra = $dispatch_hash->{$flags};
	($dtok, @value) = $tok_ra->[0]->($_[0], $_[1], # $frml, $bytepos
					 @$tok_ra[1..$#{$tok_ra}]);
#					 @$tok_ra[1..$#{@$tok_ra}]);
    }
    else {
	# error - unknown token
	$dtok = 'ERROR';
	@value = ( sprintf("Unknown binary token: 0x%02x\n", $flags) );
    }
    $tok .= $dtok;

    return ($tok, @value);
};

# tAttr dispatch table
my $attr_dispatch =
{
 0x01 => [$simple, 'Volatile', 'v'],
 0x02 => [$simple, 'If', 'v'],	# number of bytes to skip
 0x04 => [$err, 'Choose', undef],
 0x08 => [$simple, 'Skip', 'v'],	# number of bytes to skip
 0x10 => [$ignore, 'Sum', 'sum', 2, 1],	# 1 argument SUM function
 0x20 => [$err, 'Assign', undef],
 0x40 => [$simple, 'Space', 'CC'],
 0x41 => [$simple, 'SpaceVolatile', 'v'],
};

# string constant (may contain unicode, richtext, and asian phonetic)
my $string = sub {
    my ($frml, $bytepos, $tok, $fmt) = @_;

    my ($size, $options) = unpackstr($fmt, $_[0], $_[1]);
    my $ccompr = $options & 0x01;
    my $phonetic = $options & 0x04;
    my $richtext = $options & 0x08;
    my $rt = unpackstr('v', $_[0], $_[1]) if $richtext;
    my $sz = unpackstr('Q', $_[0], $_[1]) if $phonetic;
    my $string = $size ? unpackstr('a['.($size*(1+$ccompr)).']', $_[0], $_[1])
      : '';
    my $rtlist = unpackstr('a['.($rt*4).']', $_[0], $_[1]) if $richtext;
    my $phonetic_block = unpackstr('a['.$sz.']', $_[0], $_[1]) if $phonetic;

    return($tok,
	   $string, $ccompr, $richtext, $rtlist, $phonetic, $phonetic_block);
};

##############################
#
# unimplemented tokens
my $aref = $err;
my $name = $err;
my $memarea = $err;
my $memerr = $err;
my $memnomem = $err;
my $memfunc = $err;
my $referr = $err;
my $areaerr = $err;
my $relref = $err;
my $relarea = $err;
my $relmemarea = $err;
my $relmemnomem = $err;
my $extname = $err;
my $ref3d = $err;
my $area3d = $err;
my $referr3d = $err;
my $areaerr3d = $err;

##############################
#
# formula token hash
#
my $formula_tokens =
{
 # Entries have the format:
 # Hex-Token => [Operator-Handler, Token-String,
 # Token-Size | Perl-Operator | unpack-Template,
 # Args...]

 # Unary operators
 0x12 => [$unop, 'tUplus', '+'],	# unary prefix plus '+'
 0x13 => [$unop, 'tUminus', '-'],	# unary prefix minus '-'
 0x14 => [$unop, 'tPercent', undef],	# percent sign '%' (postfix)

 # Binary operators
 0x03 => [$binop, 'tAdd', '+'],		# addition '+'
 0x04 => [$binop, 'tSub', '-'],		# subtraction '-'
 0x05 => [$binop, 'tMul', '*'],		# multiplication '*'
 0x06 => [$binop, 'tDiv', '/'],		# division '/'
 0x07 => [$binop, 'tPower', '**'],	# exponentiation '^'
 0x08 => [$binop, 'tConcat', '.'],	# string concatenation '&'
 0x09 => [$binop, 'tLT', '<'],		# less than '<'
 0x0a => [$binop, 'tLE', '<='],		# less than or equal '<='
 0x0b => [$binop, 'tEQ', '=='],		# equal '='
 0x0c => [$binop, 'tGE', '>='],		# greater than or equal '>='
 0x0d => [$binop, 'tGT', '>'],		# greater than '>'
 0x0e => [$binop, 'tNE', '!='],		# not equal '<>'
 0x0f => [$binop, 'tIsect', undef],	# cell range intersection ' '
 0x10 => [$binop, 'tList', undef],	# cell range list ',' (union?)
 0x11 => [$binop, 'tRange', undef],	# cell range ':'

 # Constant operand tokens
 0x16 => [$err, 'tMissArg', 'Missing argument'],	# Missing argument
 0x17 => [$string, 'tStr', 'CC'],	# String constant
 0x1c => [$err, 'tErr', 'C'],		# Error constant
 0x1d => [$simple, 'tBool', 'C'],	# Boolean constant
 0x1e => [$simple, 'tInt', 'v'],	# 16bit integer constant
 0x1f => [$simple, 'tNum', 'd'],	# Floating-point constant
 0x20 => [$aref, 'tArrayR', undef],	# Array reference constant
 0x40 => [$aref, 'tArrayV', undef],	# Array value constant
 0x60 => [$aref, 'tArrayA', undef],	# Array area constant

 # Function operator tokens
 0x21 => [$func, 'tFuncR', 'v'],	# function fixed args returning cell
                                        # reference
 0x41 => [$func, 'tFuncV', 'v'],	# function fixed args returning value
 0x61 => [$func, 'tFuncA', 'v'],	# function fixed args returning cell
                                        # area
 0x22 => [$funcv, 'tFuncVarR', 'Cv'],	# function var args returning cell
                                        # reference
 0x42 => [$funcv, 'tFuncVarV', 'Cv'],	# function var args returning value
 0x62 => [$funcv, 'tFuncVarA', 'Cv'],	# function var args returning cell area
 0x38 => [$func, 'tFuncCER', 'CC'],	# Macro command with var args (only
                                        # BIFF2/3)
 0x58 => [$func, 'tFuncCEV', 'CC'],
 0x68 => [$func, 'tFuncCEA', 'CC'],

 # Operand tokens
 0x23 => [$name, 'tNameR', undef],	# internal defined name
 0x43 => [$name, 'tNameV', undef],
 0x63 => [$name, 'tNameA', undef],
 0x24 => [$ref, 'tRefR', 'vCC'],	# 2D cell reference
 0x44 => [$ref, 'tRefV', 'vCC'],
 0x64 => [$ref, 'tRefA', 'vCC'],
 0x25 => [$area, 'tAreaR', 'vvCCCC'],	# 2D area reference
 0x45 => [$area, 'tAreaV', 'vvCCCC'],
 0x65 => [$area, 'tAreaA', 'vvCCCC'],
 0x26 => [$memarea, 'tMemAreaR', undef],# Constant reference subexpression
 0x46 => [$memarea, 'tMemAreaV', undef],
 0x66 => [$memarea, 'tMemAreaA', undef],
 0x27 => [$memerr, 'tMemErrR', undef],	# Deleted constant reference subexpression
 0x47 => [$memerr, 'tMemErrV', undef],
 0x67 => [$memerr, 'tMemErrA', undef],
 0x28 => [$memnomem, 'tMemNoMemR', undef],	# Incomplete constant reference subexpression
 0x48 => [$memnomem, 'tMemNoMemV', undef],
 0x68 => [$memnomem, 'tMemNoMemA', undef],
 0x28 => [$memfunc, 'tMemFuncR', undef],	# Variable reference subexpression
 0x48 => [$memfunc, 'tMemFuncV', undef],
 0x68 => [$memfunc, 'tMemFuncA', undef],
 0x2a => [$referr, 'tRefErrR', undef],		# Deleted 2D cell reference
 0x4a => [$referr, 'tRefErrV', undef],
 0x6a => [$referr, 'tRefErrA', undef],
 0x2b => [$areaerr, 'tAreaErrR', undef],	# Deleted 2D area reference
 0x4b => [$areaerr, 'tAreaErrV', undef],
 0x6b => [$areaerr, 'tAreaErrA', undef],
 0x2c => [$relref, 'tRefNR', undef],		# Relative 2D cell reference
 0x4c => [$relref, 'tRefNV', undef],
 0x6c => [$relref, 'tRefNA', undef],
 0x2d => [$relarea, 'tAreaNR', undef],		# Relative 2D area reference
 0x4d => [$relarea, 'tAreaNV', undef],
 0x6d => [$relarea, 'tAreaNA', undef],
 0x2e => [$relmemarea, 'tMemAreaNR', undef],	# Relative constant reference subexpression
 0x4e => [$relmemarea, 'tMemAreaNV', undef],
 0x6e => [$relmemarea, 'tMemAreaNA', undef],
 0x2f => [$relmemnomem, 'tMemNoMemNR', undef],	# Incomplete relative constant
                                                # reference subexpression
 0x4f => [$relmemnomem, 'tMemNoMemNV', undef],
 0x6f => [$relmemnomem, 'tMemNoMemNA', undef],
 0x39 => [$extname, 'tNameXR', undef],		# External name
 0x59 => [$extname, 'tNameXV', undef],
 0x79 => [$extname, 'tNameXA', undef],
 0x3a => [$ref3d, 'tRef3dR', undef],		# 3D cell reference
 0x5a => [$ref3d, 'tRef3dV', undef],
 0x7a => [$ref3d, 'tRef3dA', undef],
 0x3b => [$area3d, 'tArea3dR', undef],		# 3D area reference
 0x5b => [$area3d, 'tArea3dV', undef],
 0x7b => [$area3d, 'tArea3dA', undef],
 0x3c => [$referr3d, 'tRefErr3dR', undef],	# Deleted 3D cell reference
 0x5c => [$referr3d, 'tRefErr3dV', undef],
 0x7c => [$referr3d, 'tRefErr3dA', undef],
 0x3d => [$areaerr3d, 'tAreaErr3dR', undef],	# Deleted 3D area reference
 0x5d => [$areaerr3d, 'tAreaErr3dV', undef],
 0x7d => [$areaerr3d, 'tAreaErr3dA', undef],

 # Control and special tokens
 0x01 => [$err, 'tExp', undef],		# Matrix formula or shared formula
 0x02 => [$err, 'tTbl', undef],		# Multiple operation table
 0x15 => [$paren, 'tParen', undef],	# Parentheses
 0x18 => [$err, 'tNlr', undef],		# Natural language reference (BIFF8)
 0x19 => [$dispatch, 'tAttr', 'C', $attr_dispatch],	# Special attribute
 0x1A => [$err, 'tSheet', undef],	# Start of external sheet reference
                                        # (BIFF2-BIFF4)
 0x1B => [$err, 'tEndSheet', undef],	# End of external sheet reference
                                        # (BIFF2-BIFF4)
};

##############################
#
# token iteration
#
sub make_token_iterator {
    my ($formula_string) = @_;
    my $bytepos = 0;

    # iterator that returns (token, value) pairs
    return sub {
	return () if ! $formula_string;
	# parse Excel formula tokens
	my $startpos = $bytepos;
	my $binary_token = unpackstr('C', $formula_string, $bytepos);
	#debug 'Unpacked <0x%02x>', $binary_token;
	my ($token, @value);
	if ( exists($formula_tokens->{$binary_token}) ) {
	    my $tok_ra;
	    $tok_ra = $formula_tokens->{$binary_token};
	    # tok_ra is an array reference - parse token and possible values
	    # formula_string gets eaten byte by byte during parsing
	    ($token, @value) = $tok_ra->[0]->($formula_string, $bytepos,
					      @$tok_ra[1..$#{$tok_ra}]);
#					      @$tok_ra[1..$#{@$tok_ra}]);
	}
	else {
	    # error - unknown token
	    $token = 'ERROR';
	    @value = ( sprintf("Unknown binary token: 0x%02x\n",
			       $binary_token) );
	}

	return ($startpos, $token, @value);
    }
}

# parse the formula of one cell, and update the "Formula" field with the
# parsed RPN token sequence
sub parse_formula {
    my ($cell, $workbook, $sheet, $row, $col) = @_;
    my $ret = [];

    # extract formula hex string
    my $formula_hexstring = $cell->{Formula};

    my (@formula_biff) = unpack("C*", $formula_hexstring);
    my $fmt_string = join(':', ('%02x') x length($formula_hexstring));
    debug 'Formula code: '.$fmt_string, @formula_biff;
    $cell->{Formula_hex} = sprintf($fmt_string, @formula_biff);

    # generate token iterator for formula
    my $iter = make_token_iterator($formula_hexstring);

    # iterate
    my ($bytepos, $token, $value, @value);
    while ( ($bytepos, $token, @value) = $iter->() ) {
	$value = join(', ', map { defined($_) ? $_ : 'undef' } @value);
	debug 'POS %02d, Token %s, value <%s>', $bytepos, $token, $value;
	push @$ret,  [$token, $bytepos, @value];
    }

    $cell->{Formula} = $ret;
}

##############################
#
# Formula evaluation

# helper sub to expand arguments on the stack
sub expand_args {
    my ($numargs, $stack) = @_;
    my @args = ();

    while ( $numargs-- ) {
	my $a = pop @$stack;
	unshift @args, ref($a) ? @$a : $a;
    }
    return @args;
}

# Excel built-in functions emulated in Perl
sub notimp { '#Name!' }
sub count { scalar grep { isnum($_) } @_ }
sub _if { $_[0] ? $_[1] : $_[2] } # never gets evaluated! (done by tAttrIf!)
sub isna { $_[0] eq '#N/A!' }
sub iserror { $_[0] =~ /^\#.*?!$/ }
sub _sum { sum(@_) }
sub average { sum(@_)/scalar(@_) }
sub maxl { reduce { max($a, $b) } @_ }
sub minl { reduce { min($a, $b) } @_ }
sub variance {
    return '#DIV/0!' if scalar(@_) <= 1;
    my $avg = average(@_);
    debug "Average: $avg";
    my $sumsq = sum map { ($_ - $avg)**2 } @_;
    debug "Sumsq: $sumsq";
    return $sumsq/(scalar(@_)-1); # nicht 1/n sondern 1/(n.1) ->
                                  # Korrekturfaktor der "unverzerrten
                                  # empirischen Varianz"!
}
sub median {
    my $nargs = scalar(@_);
    my @sorted = sort @_;
    $nargs % 2 ? $sorted[($nargs+1)/2] :
                ($sorted[$nargs/2 - 1] + $sorted[$nargs/2])/2 ;
}
# excel to perl operators (only differences to perl)
my $excelnumops =
{
 # excel-operator => perl-operator
 '%' => '*0.01',
 '^' => '**',
 '<>' => '!=',
 '=' => '==',
};
my $excelstrops =
{
 # excel-operator => perl-operator
 '&' => '.',
 '=' => 'eq',
 '>' => 'gt',
 '<' => 'lt',
 '>=' => 'ge',
 '<=' => 'le',
 '<>' => 'ne',
};
sub sumif { # arguments are not expanded!
    my ($ar, $expr, $sumar) = @_;
    $ar = [ $ar ] if ! ref($ar);
    $sumar ||= $ar;
    $sumar = [ $sumar ] if ! ref($sumar);
    if ( $expr =~ s/^\s*([<>=]+)\s*(.*)// ) {
	# convert excel to perl operator
	my ($xlop, $oarg)  = ($1, $2);
	my $arg = $oarg;
	$arg =~ s/,/./; # german excel uses comma as decimal point
	if ( isnum($arg) ) {
	    $expr = ($excelnumops->{$xlop} || $xlop) . $arg;
	} else {
	    $expr = ($excelstrops->{$xlop} || $xlop) . $oarg;
	}
    } else {
	# prepend equality test
	$expr = isnum($expr) ? " == $expr" : " eq '$expr'";
    }
    debug "expr now '$expr'";
    return sum map { $_->[1] }
      grep { eval $_->[0].$expr }
	apply_to_listof_arrayrefs { [$_[0], $_[1]] } $ar, $sumar;
}
sub countif { # arguments are not expanded!
    my ($ar, $expr) = @_;
    $ar = [ $ar ] if ! ref($ar);
    if ( $expr =~ s/^\s*([<>=]+)\s*(.*)// ) {
	# convert excel to perl operator
	my ($xlop, $oarg)  = ($1, $2);
	my $arg = $oarg;
	$arg =~ s/,/./; # german excel uses comma as decimal point
	if ( isnum($arg) ) {
	    $expr = ($excelnumops->{$xlop} || $xlop) . $arg;
	} else {
	    $expr = ($excelstrops->{$xlop} || $xlop) . $oarg;
	}
    } else {
	# prepend equality test
	$expr = isnum($expr) ? " == $expr" : " eq '$expr'";
    }
    #debug "expr now '$expr'";
    return scalar grep { eval $_.$expr } @$ar;
}
sub sumproduct { # arguments are not expanded!
    my (@arlist) = @_;
    for my $ar ( @arlist ) {
	$ar = [ $ar ] if ! ref($ar);
    }
    return  sum apply_to_listof_arrayrefs { (reduce { ($a||0) * ($b||0) } @_) || 0 } @arlist;
}
sub _true { 1 }
sub _false { 0 }
sub _and { $_ || return 0 for @_; 1 }
sub _or { $_ && return 1 for @_; 0 }
sub _not { ! $_[0] }
sub mod { $_[0] % $_[1] }
sub na { '#N/A!' }
#sub row {}
#sub column {}
sub sin { CORE::sin($_[0]) }
sub cos { CORE::cos($_[0]) }
sub tan { CORE::sin($_[0]) / CORE::cos($_[0])  }
sub atan { CORE::atan2($_[0], 1) }
sub atan2 { CORE::atan2($_[1], $_[0]) }
sub pi { 3.141592653589793 }
sub sqrt { CORE::sqrt($_[0]) }
sub exp { CORE::exp($_[0]) }
sub log { $_[0] ? CORE::log($_[0]) : '#VALUE!' }
sub log10 { $_[0] ? CORE::log($_[0])/CORE::log($_[1]||10) : '#VALUE!' }
sub abs { CORE::abs($_[0]) }
sub int { CORE::int($_[0]) }
sub sign { $_[0] <=> 0 }
sub rept { $_[0] x $_[1] }
sub mid { substr($_[0], $_[1] - 1, $_[2]) }
sub length { CORE::length($_[0]) }
sub value { $_[0] =~ s/,/./g; $_[0] =~ /([\d.eE+-]+)/; $1+0 }
sub rand { CORE::rand() }
sub asin { $_[0] == 1 ? pi()/2 : atan($_[0]/CORE::sqrt(1 - $_[0]*$_[0])) }
sub acos { pi()/2 - asin($_[0]) }
sub char { 0 <= $_[0] && $_[0] <= 255 ? chr($_[0]) : '#VALUE!' }
sub lower { lc $_[0] }
sub upper { uc $_[0] }
sub proper { $_[0] =~ s/\b([a-z])/uc($1)/eg; $_[0] }
sub left { substr($_[0], 0, $_[1]||1) }
sub right { substr($_[0], -($_[1]||1)) }
sub exact { $_[0] eq $_[1] }
sub trim { $_[0] =~ s/(\s)+/$1/g; $_[0] =~ /^\s*(.*?)\s*$/; $1 }
sub replace { substr($_[0], $_[1]-1, $_[2], $_[3]); $_[0] }
sub substitute { $_[0] =~ s/$_[1]/$_[2]/; $_[0] }
sub code { ord($_[0]) }
sub find { index($_[1], $_[0], $_[2] ? $_[2]-1 : 0) + 1 }
# EUR-Symbol in ISO-9959-15: \244 (Oktal 244)
# EUR-Symbol in UTF: '%G-A€%@'-b
sub euro { my $x = sprintf("\244 %.*f", defined($_[1]) ? $_[1] : 2, $_[0]);
	   $x =~ s/\./,/; $x }
sub usdollar { my $x = sprintf("\$%.*f", defined($_[1]) ? $_[1] : 2, $_[0]);
	       $x =~ s/\./,/; $x }
sub fixed { my $x = sprintf('%.*f', defined($_[1]) ? $_[1] : 2, $_[0]);
	    $x =~ s/\./,/; $x }
sub trunc ($;$) { CORE::int($_[0]*10**($_[1] || 0)) / 10**($_[1] || 0) }
sub round ($;$) { CORE::int($_[0]*10**($_[1] || 0)+.5) / 10**($_[1] || 0) }
sub flooring { floor($_[0]/$_[1])*$_[1] }
sub rounddown { $_[0] >= 0 ? floor($_[0]*10**($_[1]||0))/10**($_[1]||0)
		  : ceil($_[0]*10**($_[1]||0))/10**($_[1]||0) }
sub ceiling { ceil($_[0]/$_[1])*$_[1] }
sub roundup { $_[0] >= 0 ? ceil($_[0]*10**($_[1]||0))/10**($_[1]||0)
		: floor($_[0]*10**($_[1]||0))/10**($_[1]||0) }
sub _even { floor($_[0]) % 2 ? floor($_[0]) + sign($_[0]) : floor($_[0]) }
sub _odd { floor($_[0]) % 2 ? floor($_[0]) : floor($_[0]) + (sign($_[0] || 1)) }
sub concat { join('', @_) }
sub power { $_[0]**$_[1] }
sub rad { $_[0]/180*pi() }
sub deg { $_[0]/pi()*180 }
sub iserr { $_[0] =~ /^\#.*?!$/ && $_[0] ne '#N/A!' }
sub istext { ! isnum($_[0]) }
sub isnumber { isnum($_[0]) ? 1 : 0 }
sub isblank { ! defined($_[0]) || $_[0] eq '' }
sub _t { isnum($_[0]) ? '' : $_[0] }
sub _n { isnum($_[0]) ? $_[0] : 0 }
sub clean { $_[0] =~ tr/[\x00-\x1f]//d; $_[0] }
sub e { 2.71828182845904523536**(defined($_[0]) ? $_[0] : 1) }
sub sinh { (e($_[0]) - e(-$_[0]))/2 }
sub cosh { (e($_[0]) + e(-$_[0]))/2 }
sub tanh { sinh($_[0])/cosh($_[0]) }
sub asinh { CORE::log($_[0] + CORE::sqrt($_[0]**2 + 1)) }
sub acosh { CORE::log($_[0] + CORE::sqrt($_[0]**2 - 1)) }
sub atanh { CORE::log((1 + $_[0])/(1 - $_[0]))/2 }

# Function Built-Ins token table
my ($fname, $perl, $minpar, $maxpar, $retcls, $parcls, $volatile, $noexpand) =
  (0..7);
my $builtins =
  [
   # Excel-Name, Perl-Name, MinPar, MaxPar, RetCls, ParCls, Volatile, NoExpand
   ['COUNT',    \&count,    0,      30,     'V',    'R',    0, 0], # 0
   ['IF',       \&_if,      2,       3,     'R',    'VRR',  0, 0], # 1
   ['ISNA',     \&isna,     1,       1,     'V',    'V',    0, 0], # 2
   ['ISERROR',  \&iserror,  1,       1,     'V',    'V',    0, 0], # 3
   ['SUM',      \&_sum,     0,      30,     'V',    'R',    0, 0], # 4
   ['AVERAGE',  \&average,  1,      30,     'V',    'R',    0, 0], # 5
   ['MIN',	\&minl,     1,      30,     'V',    'R',    0, 0], # 6
   ['MAX',	\&maxl,     1,      30,     'V',    'R',    0, 0], # 7
   ['ROW',	\&notimp,   0,       1,     'V',    'R',    0, 0], # 8
   ['COLUMN',	\&notimp,   0,       1,     'V',    'R',    0, 0], # 9
   ['NA',	\&na,       0,       0,     'V',    '-',    0, 0], # 10
   ['NPV',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 11
   ['STDEV',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 12
   ['DOLLAR',	\&euro,     1,       2,     'V',    'VV',   0, 0], # 13
   ['FIXED',	\&fixed,    2,       3,     'V',    'VVV',  0, 0], # 14
   ['SIN',	\&sin,      1,       1,     'V',    'V',    0, 0], # 15
   ['COS',	\&cos,      1,       1,     'V',    'V',    0, 0], # 16
   ['TAN',	\&tan,      1,       1,     'V',    'V',    0, 0], # 17
   ['ATAN',	\&atan,     1,       1,     'V',    'V',    0, 0], # 18
   ['PI',	\&pi,       0,       0,     'V',    '-',    0, 0], # 19
   ['SQRT',	\&sqrt,     1,       1,     'V',    'V',    0, 0], # 20
   ['EXP',	\&exp,      1,       1,     'V',    'V',    0, 0], # 21
   ['LN',	\&log,      1,       1,     'V',    'V',    0, 0], # 22
   ['LOG10',	\&log10,    1,       1,     'V',    'V',    0, 0], # 23
   ['ABS',	\&abs,      1,       1,     'V',    'V',    0, 0], # 24
   ['INT',	\&int,      1,       1,     'V',    'V',    0, 0], # 25
   ['SIGN',	\&sign,     1,       1,     'V',    'V',    0, 0], # 26
   ['ROUND',	\&round,    2,       2,     'V',    'VV',   0, 0], # 27
   ['LOOKUP',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 28
   ['INDEX',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 29
   ['REPT',	\&rept,     2,       2,     'V',    'VV',   0, 0], # 30
   ['MID',	\&mid,      3,       3,     'V',    'VVV',  0, 0], # 31
   ['LEN',	\&length,   1,       1,     'V',    'V',    0, 0], # 32
   ['VALUE',	\&value,    1,       1,     'V',    'V',    0, 0], # 33
   ['TRUE',	\&_true,    0,       0,     'V',    '-',    0, 0], # 34
   ['FALSE',	\&_false,   0,       0,     'V',    '-',    0, 0], # 35
   ['AND',	\&_and,     1,      30,     'V',    'R',    0, 0], # 36
   ['OR',	\&_or,      1,      30,     'V',    'R',    0, 0], # 37
   ['NOT',	\&_not,     1,       1,     'V',    'V',    0, 0], # 38
   ['MOD',	\&mod,      2,       2,     'V',    'VV',   0, 0], # 39
   ['DCOUNT',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 40
   ['DSUM',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 41
   ['DAVERAGE',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 42
   ['DMIN',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 43
   ['DMAX',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 44
   ['DSTDEVP',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 45
   ['VAR',	\&variance, 1,      30,     'V',    'R',    0, 0], # 46
   ['DVAR',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 47
   ['TEXT',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 48
   ['LINEST',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 49
   ['TREND',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 50
   ['LOGEST',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 51
   ['GROWTH',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 52
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 53
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 54
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 55
   ['PV',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 56
   ['FV',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 57
   ['NPER',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 58
   ['PMT',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 59
   ['RATE',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 60
   ['MIRR',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 61
   ['IRR',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 62
   ['RAND',	\&rand,     0,       0,     'V',    '-',    1, 0], # 63
   ['MATCH',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 64
   ['DATE',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 65
   ['TIME',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 66
   ['DAY',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 67
   ['MONTH',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 68
   ['YEAR',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 69
   ['WEEKDAY',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 70
   ['HOUR',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 71
   ['MINUTE',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 72
   ['SECOND',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 73
   ['NOW',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 74
   ['AREAS',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 75
   ['ROWS',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 76
   ['COLUMNS',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 77
   ['OFFSET',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 78
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 79
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 80
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 81
   ['SEARCHB',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 82
   ['TRANSPOSE',\&notimp,   1,      30,     'V',    'R',    0, 0], # 83
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 84
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 85
   ['TYPE',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 86
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 87
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 88
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 89
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 90
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 91
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 92
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 93
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 94
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 95
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 96
   ['ATAN2',	\&atan2,    2,       2,     'V',    'VV',   0, 0], # 97
   ['ASIN',	\&asin,     1,       1,     'V',    'V',    0, 0], # 98
   ['ACOS',	\&acos,     1,       1,     'V',    'V',    0, 0], # 99
   ['CHOOSE',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 100
   ['HLOOKUP',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 101
   ['VLOOKUP',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 102
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 103
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 104
   ['ISREF',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 105
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 106
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 107
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 108
   ['LOG',	\&log10,    1,       2,     'V',    'VV',   0, 0], # 109
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 110
   ['CHAR',	\&char,     1,       1,     'V',    'V',    0, 0], # 111
   ['LOWER',	\&lower,    1,       1,     'V',    'V',    0, 0], # 112
   ['UPPER',	\&upper,    1,       1,     'V',    'V',    0, 0], # 113
   ['PROPER',	\&proper,   1,       1,     'V',    'V',    0, 0], # 114
   ['LEFT',	\&left,     1,       2,     'V',    'VV',   0, 0], # 115
   ['RIGHT',	\&right,    1,       2,     'V',    'VV',   0, 0], # 116
   ['EXACT',	\&exact,    2,       2,     'V',    'VV',   0, 0], # 117
   ['TRIM',	\&trim,     1,       1,     'V',    'V',    0, 0], # 118
   ['REPLACE',	\&replace,  4,       4,     'V',    'VVVV', 0, 0], # 119
   ['SUBSTITUTE',\&substitute, 3,    4,     'V',    'VVVV', 0, 0], # 120
   ['CODE',	\&code,     1,       1,     'V',    'V',    0, 0], # 121
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 122
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 123
   ['FIND',	\&find,     2,       3,     'V',    'VVV',  0, 0], # 124
   ['CELL',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 125
   ['ISERR',	\&iserr,    1,       1,     'V',    'V',    0, 0], # 126
   ['ISTEXT',	\&istext,   1,       1,     'V',    'V',    0, 0], # 127
   ['ISNUMBER',	\&isnumber, 1,       1,     'V',    'V',    0, 0], # 128
   ['ISBLANK',	\&isblank,  1,       1,     'V',    'V',    0, 0], # 129
   ['T',	\&_t,       1,       1,     'V',    'V',    0, 0], # 130
   ['N',	\&_n,       1,       1,     'V',    'V',    0, 0], # 131
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 132
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 133
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 134
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 135
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 136
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 137
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 138
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 139
   ['DATEVALUE',\&notimp,   1,      30,     'V',    'R',    0, 0], # 140
   ['TIMEVALUE',\&notimp,   1,      30,     'V',    'R',    0, 0], # 141
   ['SLN',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 142
   ['SYD',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 143
   ['DDB',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 144
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 145
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 146
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 147
   ['INDIRECT',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 148
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 149
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 150
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 151
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 152
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 153
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 154
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 155
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 156
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 157
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 158
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 159
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 160
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 161
   ['CLEAN',	\&clean,    1,       1,     'V',    'V',    0, 0], # 162
   ['MDETERM',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 163
   ['MINVERSE',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 164
   ['MMULT',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 165
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 166
   ['IPMT',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 167
   ['PPMT',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 168
   ['COUNTA',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 169
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 170
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 171
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 172
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 173
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 174
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 175
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 176
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 177
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 178
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 179
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 180
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 181
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 182
   ['PRODUCT',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 183
   ['FACT',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 184
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 185
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 186
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 187
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 188
   ['DPRODUCT',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 189
   ['ISNONTEXT',\&notimp,   1,      30,     'V',    'R',    0, 0], # 190
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 191
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 192
   ['STDEVP',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 193
   ['VARP',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 194
   ['DSTDEVP',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 195
   ['DVARP',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 196
   ['TRUNC',	\&trunc,    1,       2,     'V',    'VV',   0, 0], # 197
   ['ISLOGICAL',\&notimp,   1,      30,     'V',    'R',    0, 0], # 198
   ['DCOUNTA',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 199
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 200
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 201
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 202
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 203
   ['USDOLLAR',	\&usdollar, 1,       2,     'V',    'VV',   0, 0], # 204
   ['FINDB',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 205
   ['SEARCHB',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 206
   ['REPLACEB',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 207
   ['LEFTB',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 208
   ['RIGHTB',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 209
   ['MIDB',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 210
   ['LENB',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 211
   ['ROUNDUP',	\&roundup,  2,       2,     'V',    'VV',   0, 0], # 212
   ['ROUNDDOWN',\&rounddown,2,       2,     'V',    'VV',   0, 0], # 213
   ['ASC',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 214
   ['DBCS',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 215
   ['RANK',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 216
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 217
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 218
   ['ADDRESS',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 219
   ['DAYS360',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 220
   ['TODAY',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 221
   ['VDB',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 222
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 223
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 224
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 225
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 226
   ['MEDIAN',	\&median,   1,      30,     'V',    'R',    0, 0], # 227
   ['SUMPRODUCT',\&sumproduct,1,    30,     'V',    'A',    0, 1], # 228
   ['SINH',	\&sinh,     1,       1,     'V',    'V',    0, 0], # 229
   ['COSH',	\&cosh,     1,       1,     'V',    'V',    0, 0], # 230
   ['TANH',	\&tanh,     1,       1,     'V',    'V',    0, 0], # 231
   ['ASINH',	\&asinh,    1,       1,     'V',    'V',    0, 0], # 232
   ['ACOSH',	\&acosh,    1,       1,     'V',    'V',    0, 0], # 233
   ['ATANH',	\&atanh,    1,       1,     'V',    'V',    0, 0], # 234
   ['DGET',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 235
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 236
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 237
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 238
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 239
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 240
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 241
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 242
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 243
   ['INFO',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 244
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 245
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 246
   ['DB',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 247
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 248
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 249
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 250
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 251
   ['FREQUENCY',\&notimp,   1,      30,     'V',    'R',    0, 0], # 252
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 253
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 254
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 255
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 256
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 257
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 258
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 259
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 260
   ['ERROR.TYPE',\&notimp,  1,      30,     'V',    'R',    0, 0], # 261
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 262
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 263
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 264
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 265
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 266
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 267
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 268
   ['AVEDEV',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 269
   ['BETADIST', \&notimp,   1,      30,     'V',    'R',    0, 0], # 270
   ['GAMMALN',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 271
   ['BETAINV',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 272
   ['BINOMDIST',\&notimp,   1,      30,     'V',    'R',    0, 0], # 273
   ['CHIDIST',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 274
   ['CHIINV',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 275
   ['COMBIN',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 276
   ['CONFIDENCE',\&notimp,  1,      30,     'V',    'R',    0, 0], # 277
   ['CRITBINOM',\&notimp,   1,      30,     'V',    'R',    0, 0], # 278
   ['EVEN',	\&_even,    1,       1,     'V',    'V',    0, 0], # 279
   ['EXPONDIST',\&notimp,   1,      30,     'V',    'R',    0, 0], # 280
   ['FDIST',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 281
   ['FINV',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 282
   ['FISHER',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 283
   ['FISHERINV',\&notimp,   1,      30,     'V',    'R',    0, 0], # 284
   ['FLOOR',	\&flooring, 2,       2,     'V',    'VV',   0, 0], # 285
   ['GAMMADIST',\&notimp,   1,      30,     'V',    'R',    0, 0], # 286
   ['GAMMAINV',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 287
   ['CEILING',	\&ceiling,  2,       2,     'V',    'VV',   0, 0], # 288
   ['HYPGEOMDIST',\&notimp, 1,      30,     'V',    'R',    0, 0], # 289
   ['LOGNORMDIST',\&notimp, 1,      30,     'V',    'R',    0, 0], # 290
   ['LOGINV',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 291
   ['NEGBINOMDIST',\&notimp,1,      30,     'V',    'R',    0, 0], # 292
   ['NORMDIST',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 293
   ['NORMSDIST',\&notimp,   1,      30,     'V',    'R',    0, 0], # 294
   ['NORMINV',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 295
   ['NORMSINV',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 296
   ['STANDARDIZE',\&notimp, 1,      30,     'V',    'R',    0, 0], # 297
   ['ODD',	\&_odd,     1,       1,     'V',    'V',    0, 0], # 298
   ['PERMUT',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 299
   ['POISSON',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 300
   ['TDIST',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 301
   ['WEIBULL',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 302
   ['SUMXMY2',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 303
   ['SUMX2MY2',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 304
   ['SUMX2PY2',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 305
   ['CHITEST',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 306
   ['CORREL',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 307
   ['COVAR',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 308
   ['FORECAST',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 309
   ['FTEST',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 310
   ['INTERCEPT',\&notimp,   1,      30,     'V',    'R',    0, 0], # 311
   ['PEARSON',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 312
   ['RSQ',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 313
   ['STEYX',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 314
   ['SLOPE',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 315
   ['TTEST',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 316
   ['PROB',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 317
   ['DEVSQ',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 318
   ['GEOMEAN',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 319
   ['HARMEAN',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 320
   ['SUMSQ',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 321
   ['KURT',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 322
   ['SKEW',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 323
   ['ZTEST',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 324
   ['LARGE',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 325
   ['SMALL',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 326
   ['QUARTILE',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 327
   ['PERCENTILE',\&notimp,  1,      30,     'V',    'R',    0, 0], # 328
   ['PERCENTRANK',\&notimp, 1,      30,     'V',    'R',    0, 0], # 329
   ['MODE',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 330
   ['TRIMMEAN',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 331
   ['TINV',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 332
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 333
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 334
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 335
   ['CONCATENATE',\&concat, 0,      30,     'V',    'V',    0, 0], # 336
   ['POWER',	\&power,    2,       2,     'V',    'VV',   0, 0], # 337
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 338
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 339
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 340
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 341
   ['RADIANS',	\&rad,      1,       1,     'V',    'V',    0, 0], # 342
   ['DEGREES',	\&deg,      1,       1,     'V',    'V',    0, 0], # 343
   ['SUBTOTAL',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 344
   ['SUMIF',	\&sumif,    2,       3,     'V',    'RVR',  0, 1], # 345
   ['COUNTIF',	\&countif,  2,       2,     'V',    'RV',   0, 1], # 346
   ['COUNTBLANK',\&notimp,  1,      30,     'V',    'R',    0, 0], # 347
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 348
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 349
   ['ISPMT',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 350
   ['DATEDIF',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 351
   ['DATESTRING',\&notimp,  1,      30,     'V',    'R',    0, 0], # 352
   ['NUMBERSTRING',\&notimp,1,      30,     'V',    'R',    0, 0], # 353
   ['ROMAN',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 354
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 355
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 356
   ['notexist!',\&notimp,   1,      30,     'V',    'R',    0, 0], # 357
   ['GETPIVOTDATA',\&notimp,1,      30,     'V',    'R',    0, 0], # 358
   ['HYPERLINK',\&notimp,   1,      30,     'V',    'R',    0, 0], # 359
   ['PHONETIC',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 360
   ['AVERAGEA',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 361
   ['MAXA',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 362
   ['MINA',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 363
   ['STDEVPA',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 364
   ['VARPA',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 365
   ['STDEVA',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 366
   ['VARA',	\&notimp,   1,      30,     'V',    'R',    0, 0], # 367
  ];

my $evaluation_code =
{
 # constant operand tokens - just push value on stack
 'tInt' => sub { push @{$_[2]}, $_[3]; 0; },
 'tNum' => sub { push @{$_[2]}, $_[3]; 0; },
 'tBool' => sub { push @{$_[2]}, $_[3]; 0; },
 'tStr' => sub { push @{$_[2]}, $_[3]; 0; },
 'tErr' => sub { push @{$_[2]}, $_[3]; 0; },
 # unary operators - operate on "top of stack" (tos)
 'tUplus' => sub { }, # NoOp
 'tUminus' => sub {
     my ($cell, $xls, $stack, $pop) = @_;
     $stack->[-1] = - $stack->[-1];
     0; },
 'tPercent' => sub {
     my ($cell, $xls, $stack, $pop) = @_;
     $stack->[-1] *= 0.01;
     0; },
 'tParen' => sub { 0; },
 # binary operators - pop off 2 args, push back result on stack
 'tAdd' => sub {
     my ($cell, $xls, $stack, $pop) = @_; my $tos = pop(@$stack);
     $stack->[-1] += $tos;
     0; },
 'tSub' => sub {
     my ($cell, $xls, $stack, $pop) = @_; my $tos = pop(@$stack);
     $stack->[-1] -= $tos;
     0; },
 'tMul' => sub {
     my ($cell, $xls, $stack, $pop) = @_; my $tos = pop(@$stack);
     $stack->[-1] *= $tos;
     0; },
 'tDiv' => sub {
     my ($cell, $xls, $stack, $pop) = @_; my $tos = pop(@$stack);
     if ( $tos == 0 ) {
#	 return '#DIV/0!';
	 $stack->[-1] = '#DIV/0!';
     } else {
	 $stack->[-1] /= $tos;
     }
     0; },
 'tPower' => sub {
     my ($cell, $xls, $stack, $pop) = @_; my $tos = pop(@$stack);
     push @$stack, pop(@$stack) ** $tos;
     0; },
 'tConcat' => sub {
     my ($cell, $xls, $stack, $pop) = @_; my $tos = pop(@$stack);
     push @$stack, pop(@$stack) . $tos;
     0; },
 'tLT' => sub {
     my ($cell, $xls, $stack, $pop) = @_; my $tos = pop(@$stack);
     push @$stack, isnum($tos) ? pop(@$stack) < $tos : pop(@$stack) lt $tos;
     0; },
 'tLE' => sub {
     my ($cell, $xls, $stack, $pop) = @_; my $tos = pop(@$stack);
     push @$stack, isnum($tos) ? pop(@$stack) <= $tos : pop(@$stack) le $tos;
     0; },
 'tEQ' => sub {
     my ($cell, $xls, $stack, $pop) = @_; my $tos = pop(@$stack);
     push @$stack, isnum($tos) ? pop(@$stack) == $tos : pop(@$stack) eq $tos;
     0; },
 'tGE' => sub {
     my ($cell, $xls, $stack, $pop) = @_; my $tos = pop(@$stack);
     push @$stack, isnum($tos) ? pop(@$stack) >= $tos : pop(@$stack) ge $tos;
     0; },
 'tGT' => sub {
     my ($cell, $xls, $stack, $pop) = @_; my $tos = pop(@$stack);
     push @$stack, isnum($tos) ? pop(@$stack) > $tos : pop(@$stack) gt $tos;
     0; },
 'tNE' => sub {
     my ($cell, $xls, $stack, $pop) = @_; my $tos = pop(@$stack);
     push @$stack, isnum($tos) ? pop(@$stack) != $tos : pop(@$stack) ne $tos;
     0; },
 'tRefV' => sub {
     my ($cell, $xls, $stack, $row, $col, $relrow, $relcol, $a1) = @_;
     my $v = $xls->Data->[$row]->[$col]->{Val};
     push @$stack, defined($v) ? $v : '';
     0; },
 'tRefR' => sub {
     my ($cell, $xls, $stack, $row, $col, $relrow, $relcol, $a1) = @_;
     my $v = $xls->Data->[$row]->[$col]->{Val};
     push @$stack, defined($v) ? $v : '';
     0; },
 'tRefA' => sub {
     my ($cell, $xls, $stack, $row, $col, $relrow, $relcol, $a1) = @_;
     my $v = $xls->Data->[$row]->[$col]->{Val};
     push @$stack, defined($v) ? $v : '';
     0; },
 'tAreaR' => sub {
     my ($cell, $xls, $stack,
	 $r1, $c1, $rr1, $rc1,
	 $r2, $c2, $rr2, $rc2, $a1) = @_;
     my $ret = [];
     for ( my $r = $r1; $r <= $r2; $r++ ) {
	 for ( my $c = $c1; $c <= $c2; $c++ ) {
	     push @$ret, defined($xls->Data->[$r]->[$c]->{Val}) ? $xls->Data->[$r]->[$c]->{Val} : '';
	 }
     }
     push @$stack, $ret;
     0; },
 'tAreaA' => sub {
     my ($cell, $xls, $stack,
	 $r1, $c1, $rr1, $rc1,
	 $r2, $c2, $rr2, $rc2, $a1) = @_;
     my $ret = [];
     for ( my $r = $r1; $r <= $r2; $r++ ) {
	 for ( my $c = $c1; $c <= $c2; $c++ ) {
	     push @$ret, defined($xls->Data->[$r]->[$c]->{Val}) ? $xls->Data->[$r]->[$c]->{Val} : '';
	 }
     }
     push @$stack, $ret;
     0; },
 'tAttrSum' => sub {
     my ($cell, $xls, $stack, $pop, $numargs) = @_;
     my @args = expand_args($numargs, $stack);
     push @$stack, sum @args;
     0; },
 'tAttrSpace' => sub { 0; },
 'tAttrVolatile' => sub { 0; },
 'tAttrSpaceVolatile' => sub { 0; },
 'tAttrIf' => sub {
     my ($cell, $xls, $stack, $numbytes) = @_;
     # Condition is on the stack. If the condition is true, we execute the
     # first branch, if it is false, we skip to the token positioned at
     # $numbytes + 1.  Need to assign to a lexical here, otherwise
     # $stack->[-1] only tests for existence of the array element!
     my $tos = pop @$stack;
     # the size of the tAttrIf token itself needs to be taken into account!
     $tos ? 0 : $numbytes + 4; },
 'tAttrSkip' => sub {
     my ($cell, $xls, $stack, $numbytes) = @_;
     # skip to byte position $numbytes + 1 + tAttrSkip token size
     $numbytes + 1 + 4; },
 'tFuncV' => sub {
     my ($cell, $xls, $stack, $funcidx) = @_;
     return '#Name!' unless $builtins->[$funcidx];
     my $func = $builtins->[$funcidx];
     my $numargs = $func->[$minpar];
     my @args = $func->[$noexpand] ? popn($stack, $numargs) :
                                     expand_args($numargs, $stack);
     debug 'tFunc (%d args): %s(%s)', $numargs,
       $func->[$fname], joinval(@args);
     # volatile functions (e.g. RAND()) are only evaluated on first iteration
     my $res = $cell->{Val};
     if ( $xls->{CurrentIteration} == 1 || ! $func->[$volatile] ) {
	 $res = (ref($func->[$perl]) ?
		 $func->[$perl]->(@args) : &{$func->[$perl]}(@args));
     }
     push @$stack, defined($res) ? $res : '#VALUE!';
     0; },
 'tFuncVarV' => sub {
     my ($cell, $xls, $stack, $funcidx, $numargs, $userprompt, $ismacro) = @_;
     return '#Name!' unless $builtins->[$funcidx];
     my $func = $builtins->[$funcidx];
     return '#ArgCount:'.$func->[$fname] if
       $numargs < $func->[$minpar] || $func->[$maxpar] < $numargs;
     my @args = $func->[$noexpand] ? popn($stack, $numargs) :
                                     expand_args($numargs, $stack);
     debug 'tFuncVarV (%d args): %s(%s)', $numargs,
       $func->[$fname], joinval(@args);
     # volatile functions (e.g. RAND()) are only evaluated on first iteration
     my $res = $cell->{Val};
     if ( $xls->{CurrentIteration} == 1 || ! $func->[$volatile] ) {
	 $res = (ref($func->[$perl]) ?
		 $func->[$perl]->(@args) : &{$func->[$perl]}(@args));
     }
     push @$stack, defined($res) ? $res : '#VALUE!';
     0; },
};

# helper subs for tSkip token
my ($toknam, $bytepos, $args) = (0..2);
my @skipstack = ();
sub reset_skipto {
    @skipstack = ();
}
sub set_skipto {
    my ($bytes) = @_;
    debug 'skipto %d set', $bytes;
    push @skipstack, $bytes;
}
sub skipto {
    my ($tok) = @_;
    my $bytes = $tok->[$bytepos];
    my $res = scalar(@skipstack);
    if ( $res && $skipstack[-1] == $bytes ) {
	pop @skipstack;
	$res = 0;
    }
    debug 'skipping %s %d', $tok->[$toknam], $bytes if $res;
    return $res;
}

# evaluate the formula of one cell, and update the "Val" field
sub evaluate {
    my ($cell, $workbook) = @_;
    my $ret = $cell->{Val};
    my @stack = ();

    # reset skip stack
    reset_skipto;

    # loop over already parsed formula tokens
    for my $tok ( @{$cell->{Formula}} ) {

	# skip token, if set_skipto() was called (done by tAttrIf and
	# tAttrSkip)
	next if skipto($tok);

	# evaluate formula token
	debug 'Evaluating <%s>', joinval(@$tok);
	if ( exists($evaluation_code->{$tok->[$toknam]}) ) {
	    my $res =
	      $evaluation_code->{$tok->[$toknam]}->($cell,
						    $workbook,
						    \@stack,
						    @$tok[$args..$#{$tok}]);
	    debug 'Returns <%s>, stack now <%s>',
	      defined($res) ? $res : 'undef', joinval(@stack);

	    # check evaluation result
	    if ( $res && isnum($res) ) {
		# numeric means skip this number of bytes (tSkip token)
		set_skipto($tok->[$bytepos] + $res);
		next;
	    }
	    elsif ( $res ) {
		# string: an error occured - $res holds error string - return
		# immediately
		$stack[0] = $res;
		last;
	    }

	    # this token evaluated successfully
	}
	else {
	    #error '%s not implemented', $tok->[$toknam];
	    $stack[0] = '#NotImp:'.$tok->[$toknam];
	    last;
	}
    }

    return $cell->{Val} = $stack[0];
}

# this is here to trick POD parsers into our pseudo-module
package Spreadsheet::ParseExcel::Formula;
1;
__END__

=head1 NAME

Spreadsheet::ParseExcel::Formula - extension of Spreadsheet::ParseExcel to
handle parsing and evaluation of Excel formulas


=head1 SYNOPSIS

NOTE: Please read the section L</LIMITATIONS> before using this module to make
sure it suits your purpose!

    # use with or without SaveParser extension
    use Spreadsheet::ParseExcel;
    use Spreadsheet::ParseExcel::SaveParser::Workbook;
    use Spreadsheet::ParseExcel::Formula;

    # load and parse Excel file including formulas
    my $xls = Spreadsheet::ParseExcel::SaveParser::Workbook->Parse('test.xls');

    # set formula evaluation iteration limit and/or epsilon
    # (optional; only needed for self-referential formula structures)
    $xls->set_iteration_limit(10);	# default: 10
    $xls->set_epsilon(1e-6);	        # default: 1e-6

    # set and change cell values as you like (optional)
    # this sets cell A1 of the first worksheet to the numerical value 17
    $xls->{Worksheet}->[0]->{Cells}->[0]->[0]->{Val} = 17;

    # evaluate the formulas in the Excel workbook
    $xls->evaluate();

    # retrieve and print formula cell results by accessing the "Val" member of
    # a Cell object (it is assumed that cell A2 contains a formula referencing
    # cell A1)
    print 'Cell A2 value: ',
          $xls->{Worksheet}->[0]->{Cells}->[0]->[1]->{Val}, "\n";

    # save the workbook to a new excel file using SaveParser's SaveAs method
    # Note: currently formulas are not saved.
    $xls->SaveAs('test1.xls');


=head1 DESCRIPTION

You have already read the section L</LIMITATIONS>, haven't you?

C<Spreadsheet::ParseExcel::Formula> can be used to enable formula parsing and
evaluation in Excel 2003/97/XP files. The internal binary representation of
Excel formulas (see L</INTERNALS>) is parsed on parsing the excel file with the
C<Parse> methods of either C<Spreadsheet::ParseExcel::Workbook> or
C<Spreadsheet::ParseExcel::SaveParser::Workbook>.

This is achieved by extending the C<Spreadsheet::ParseExcel::Workbook> and
C<Spreadsheet::ParseExcel::Cell> classes only, therefore this piece of code
may be considered a I<pseudo-module>, as it neither implements a classs, nor
implements or uses the namespace of C<Spreadsheet::ParseExcel::Formula>.

There are currently strict limitations on the number and use of Excel
functions and formula syntax implemented (see L</LIMITATIONS>), but you are
encouraged to extend and improve the functions and syntax recognized.

=head2 Additional C<Spreadsheet::ParseExcel::Workbook> methods

(In the following, C<$xls> denotes a valid
C<Spreadsheet::ParseExcel::Workbook> object).

=over

=item C<< $xls->evaluate() >>

Evaluates all formulas within the workbook object until either the current
iteration limit is exceeded, or the global error of all formula cells is less
then the current epsilon limit.

Returns false (C<undef>) if the iteration limit has been exceeded, or true
(C<1>) if the workbook evaluated successfully.

NOTE: A true return value does B<not> necessarily indicate, that your
workbook/worksheet is free of cell errors. As already explained, cell errors
are handled as strings and compared as such, meaning that if this string error
values compare equal on successive iterations, the cell is considered stable
and evaluation has been successful. OTOH, if false is returned, this does
B<not> necessarily mean that your workbook/worksheet evaluated erroneously,
since this depends on the functions and self-referential formula structures
used within the workbook/worksheet.

In general, C<evaluate()> is the only workbook method you need for formula
evaluation. You do not need any of the methods described below, unless you
have self-referential formula structures within your Excel file, and want
fine-grained control over formula evaluation.

=item C<< $xls->get_iteration_limit() >>

Retrieves the current iteration limit (default: 10) for formula evaluation.
Returns the current iteration limit (scalar, number).

=item C<< $xls->set_iteration_limit($num) >>

Sets the current iteration limit for formula evaluation to C<$num>.
Returns the new iteration limit (scalar, number).

=item C<< $xls->get_epsilon() >>

Retrieves the current epsilon limit (default: 1e-6) for formula evaluation.
Returns the current epsilon limit (scalar, number).

=item C<< $xls->set_epsilon($num) >>

Sets the current epsilon limit for formula evaluation to C<$num>.
Returns the new epsilon limit (scalar, number).

=back

=head2 Additional C<Spreadsheet::ParseExcel::Cell> methods

(In the following, C<$cell> denotes a valid
C<Spreadsheet::ParseExcel::Cell> object).

=over

=item C<< $cell->evaluate() >>

Evaluates a single cell containing a formula, sets the cell value to and
returns the evaluation result.

Note that this method should not be directly invoked, as this is done by the
C<evaluate()> method of the C<Spreadsheet::ParseExcel::Workbook> class.  The
only meaningful purpose is when evaluation of a whole workbook is too
time-consuming, and evaluation of a single formula cell is sufficient for a
particular type of application.

=back


=head1 INTERNALS

This is in addition to the section L</LIMITATIONS>, which you should have
definitely read by now!

This module hooks itself into the parsing process of
C<Spreadsheet::ParseExcel>, and parses the binary formula string of Excel into
a RPN (Reverse Polish Notation, see
L<http://en.wikipedia.org/wiki/Reverse_Polish_Notation>) parse sequence
(basically a Perl array of formula tokens).

During evaluation, this RPN parse sequence of the formula is interpreted for
each formula cell facilitated by a I<stack machine> (see
L<http://en.wikipedia.org/wiki/Stack_machine>), where each token or formula
function consumes a number of arguments from the stack, and pushes its result
back onto the stack. The final result of a cell is then the top of stack,
which should then contain only this one last entry.

Since in Excel self-referential (see
L<http://en.wikipedia.org/wiki/Self-referential>) formulas are allowed, a
worksheet/workbook needs to be iteratively
(see L<http://en.wikipedia.org/wiki/Iteration>) evaluated, until all values
(hopefully) stabilize onto a final formula result.

The question as what "stabilize" means is answered by an epsilon range (see
L<http://en.wikipedia.org/wiki/Limit_(mathematics)>), against which the
difference of the current and previous values of a cell are compared. If the
absolute value of this difference is smaller than this epsilon, the cell is
considered "stable", otherwise the evaluation process needs another iteration.

Since there are cases,
where a self-referential formula complex may not stabilize onto a final value
(e.g. when a RAND() function is involved), a limit needs to be placed on the
maximum number of iterations.

Both epsilon and the iteration limit may be queried and set using
corresponding accessors (see L</DESCRIPTION>).


=head1 LIMITATIONS

=over

=item *

Only Excel 2003/97/XP formulas are parsed correctly (this is the so-called
BIFF8 format). Trying to parse files produced with other versions may in the
best case produce erroneous and unpredictable results.

=item *

Only a small but useful subset of possible formula syntax is
implemented. Currently B<unimplemented> formula features and constructs
include:

=over

=item *

Array constants such as C<{1, 2}>.

=item *

Cell range intersections (the C<space> operator).

=item *

Cell range lists/unions (the C<comma> operator).

=item *

Defined names (variables), i.e. named cells or cell ranges.

=item *

Cell ranges using defined names (the C<colon> operator with defined names),
e.g. C<namedcell:B2>. NOTE: Not to be confused with regular cell ranges like
C<A1:B2>; these are implemented and should work as expected.

=item *

All types of reference subexpressions (constant, reference, deleted,
incomplete, etc.) used for encapsulation of the cell range and list operators.

=item *

3D cell references and 3D cell range references, i.e. cross-worksheet
references of the form C<"OtherWorksheet"!A1>. This means the formulas may
only reference cells within the same worksheet.

=item *

All types of deleted cell references (2D, 3D, relative, etc.), as these
indicate an erroneous formula. It is assumed, that the worksheet to be
evaluated is debugged and works correctly within Excel itself.

=item *

Matrix formulas.

=item *

Multiple operation tables.

=item *

Natural language references.

=item *

The C<CHOOSE> function control.

=item *

Assignment in macro sheets.

=back

=item *

Only a small but useful subset (about one third) of possible functions useable
in formulas is implemented. Currently B<implemented> functions are:

C<< COUNT, IF, ISNA, ISERROR, SUM, AVERAGE, MIN, MAX, NA, DOLLAR, FIXED, SIN,
COS, TAN, ATAN, PI, SQRT, EXP, LN, LOG10, ABS, INT, SIGN, ROUND, REPT, MID,
LEN, VALUE, TRUE, FALSE, AND, OR, NOT, MOD, VAR, RAND, ATAN2, ASIN, ACOS, LOG,
CHAR, LOWER, UPPER, PROPER, LEFT, RIGHT, EXACT, TRIM, REPLACE, SUBSTITUTE,
CODE, FIND, ISERR, ISTEXT, ISNUMBER, ISBLANK, T, N, CLEAN, TRUNC, USDOLLAR,
ROUNDUP, ROUNDDOWN, MEDIAN, SUMPRODUCT, SINH, COSH, TANH, ASINH, ACOSH, ATANH,
EVEN, FLOOR, CEILING, ODD, CONCATENATE, POWER, RADIANS, DEGREES, SUMIF,
COUNTIF >>

=item *

Boolean values are encoded as integers 0 and 1 as in Perl.

=item *

There is no such thing as an error type or object. Errors are implemented as
simple strings beginning with C<#> and ending with C<!>, like e.g. C<'#N/A!'>.

=item *

All this means that even those formulas are implemented, you might get
different, if not completely erroneous results out of evaluating your
particular Excel files, especially if calculations on edge cases of a
particular function are involved, or the evaluation of a particular nested
function results in an error. YMMV, you have been warned!

=back

=head1 TODO

=over

=item *

B<A lot>! You are encouraged to help improving and extending formula evaluation
within C<Spreadsheet::ParseExcel>!

=item *

Syntactical improvements: Parsing and evaluating currently unrecognized tokens
such as constant arrays or 3D cell references.

=item *

Functional improvements: Extend the number of implemented functions,
especially with Date&Time, and statistical functions.

=item *

Extensive testing: Write comprehensive test cases for testing all edge cases
and boundary conditions of the implmemented functions, and improve error
handling on formula evaluation errors.

=item *

Wishlist 1: Enable formula B<modification> within Perl. This involves parsing
the ASCII representation of Excel formulas, possibly in all languages
supported by Excel, and storing it back in the internal RPN parse sequence.

=item *

Wishlist 2: Enable C<Spreadsheet::WriteExcel> to write back the internally
stored RPN parse sequence of formulas into the resulting Excel file. This
involves reverting the process of binary token parsing, i.e. converting the
RPN parse sequence into its corresponing binary representation.

=back

=head1 AUTHOR

Franz Fasching (franz dot fasching at gmail dot com).

=head1 COPYRIGHT

Copyright (c) 2008 Franz Fasching.

All Rights Reserved. This module is free software. It may be used,
redistributed and/or modified under the same terms as Perl itself as specified
in the Perl README file, i.e. the "Artistic License" or the "GNU General
Public License (GPL)".

=head1 SEE ALSO

The C<Spreadsheet::ParseExcel>, C<Spreadsheet::ParseExcel::SaveParser>, and
C<Spreadsheet::WriteExcel> modules.

C<OpenOffice.org> has made the specification of the Excel file format publicly
available (see L<http://sc.openoffice.org/excelfileformat.pdf>), which
has recently been made available also by Microsoft.

=head1 ACKNOWLEDGEMENTS

=over

=item *

Kawai Takanori, and Gabor Szabo for their impressive
C<Spreadsheet::ParseExcel> module.

=item *

John McNamara for his excellent C<Spreadsheet::WriteExcel> module.

=item *

Dr. Claus Fischer (TXware GmbH), who enabled me to write this module as part of
a client project, and make it publicly available under the PERL Artistic
License and the GPL.

=back
