# -*- perl -*-
#	readline.t - Test script for Term::ReadLine:GNU
#
#	$Id: readline.t 475 2014-12-13 03:20:00Z hayashi $
#
#	Copyright (c) 1996 Hiroo Hayashi.  All rights reserved.
#
#	This program is free software; you can redistribute it and/or
#	modify it under the same terms as Perl itself.

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl t/readline.t'

BEGIN {
    print "1..140\n"; $n = 1;
    $ENV{PERL_RL} = 'Gnu';	# force to use Term::ReadLine::Gnu
    $ENV{LANG} = 'C';
}
END {print "not ok 1\tfail to loading\n" unless $loaded;}

# 'define @ARGV' is deprecated
my $verbose = scalar @ARGV && ($ARGV[0] eq 'verbose');

use strict;
use warnings;
use vars qw($loaded $n);
eval "use ExtUtils::testlib;" or eval "use lib './blib';";
use Term::ReadLine;
use Term::ReadLine::Gnu qw(ISKMAP ISMACR ISFUNC RL_STATE_INITIALIZED);

print "# Testing Term::ReadLine::Gnu version $Term::ReadLine::Gnu::VERSION\n";

$loaded = 1;
print "ok 1\tloading\n"; $n++;


# Perl-5.005 and later has Test.pm, but I define this here to support
# older version.
# MEMO: Since version TRL-1.10 Perl 5.7.0 has been required. So Test.pm
#       can be used now.
my $res;
my $ok = 1;
sub ok {
    my $what = shift || '';

    if ($res) {
	print "ok $n\t$what\n";
    } else {
	print "not ok $n\t$what";
	print @_ ? "\t@_\n" : "\n";
	$ok = 0;
    }
    $n++;
}

########################################################################
# test new method

# stop reading ~/.inputrc not to change the default key-bindings.
$ENV{'INPUTRC'} = '/dev/null';
# These tty setting affects GNU Readline key-bindings.
# Set the standard bindings before rl_initialize() being called.
# comment out since check_default_keybind_and_fix() takes care.
# system('stty erase  ^?') == 0 or warn "stty erase failed: $?";
# system('stty kill   ^u') == 0 or warn "stty kill failed: $?";
# system('stty lnext  ^v') == 0 or warn "stty lnext failed: $?";
# system('stty werase ^w') == 0 or warn "stty werase failed: $?";

my $t = new Term::ReadLine 'ReadLineTest';
$res =  defined $t; ok('new');

my $OUT;
if ($verbose) {
    $OUT = $t->OUT;
} else {
    open(NULL, '>/dev/null') or die "cannot open \`/dev/null\': $!\n";
    $OUT = \*NULL;
    $t->Attribs->{outstream} = \*NULL;
}

########################################################################
# test ReadLine method

$res = $t->ReadLine eq 'Term::ReadLine::Gnu';
ok('ReadLine method',
   "\tPackage name should be \`Term::ReadLine::Gnu\', but it is \`",
   $t->ReadLine, "\'\n");

########################################################################
# test Features method

my %features = %{ $t->Features };
$res = %features;
ok('Features method',"\tNo additional features present.\n");

########################################################################
# test Attribs method

my $a = $t->Attribs;
$res = defined $a; ok('Attrib method');

########################################################################
# convert control charactors to printable charactors (ex. "\cx" -> '\C-x')
sub toprint {
    join('',
	 map{$_ eq "\e" ? '\M-': ord($_)<32 ? '\C-'.lc(chr(ord($_)+64)) : $_}
	 (split('', $_[0])));
}

my ($INSTR, $line);
# simulate key input by using a variable 'rl_getc_function'
$a->{getc_function} = sub {
    unless (length $INSTR) {
	print $OUT "Error: getc_function: insufficient string, \`\$INSTR\'.";
	undef $a->{getc_function};
	return 0;
    }
    my $c  = substr $INSTR, 0, 1; # the first char of $INSTR
    $INSTR = substr $INSTR, 1;	# rest of $INSTR
    return ord $c;
};

# This is required after GNU Readline Library 6.3.
$a->{input_available_hook} = sub {
    return 1;
};

# check some key binding used by following test
sub is_boundp {
    my ($seq, $fname) = @_;
    my ($fn, $type) = $t->function_of_keyseq($seq);
    if ($fn) {
	return ($t->get_function_name($fn) eq $fname
		&& $type == ISFUNC);
    } else {
	warn ("No function is bound for sequence \`", toprint($seq),
	      "\'.  \`$fname\' is expected,");
	return 0;
    }
}

sub check_default_keybind_and_fix {
    my ($seq, $fname) = @_;
    if (is_boundp($seq, $fname)) {
	print "ok $n\t$fname is bound to " . toprint($seq) . "\n";
    } else {
	# Try to fix the binding.  But tty setting seems have precedence.
	$t->set_key($seq, $fname);
	if (is_boundp($seq, $fname)) {
	    print "ok $n\tThe default keybinding for $fname was changed. Fixed.\n";
	    print "$fname is bound to " . toprint($seq) . "\n";
	} else {
	    print "not ok $n\t$fname cannot be bound to " . toprint($seq) . "\n";
	    $ok = 0;
	}
    }
    $n++;
}
check_default_keybind_and_fix("\cM", 'accept-line');
check_default_keybind_and_fix("\cF", 'forward-char');
check_default_keybind_and_fix("\cB", 'backward-char');
check_default_keybind_and_fix("\ef", 'forward-word');
check_default_keybind_and_fix("\eb", 'backward-word');
check_default_keybind_and_fix("\cE", 'end-of-line');
check_default_keybind_and_fix("\cA", 'beginning-of-line');
check_default_keybind_and_fix("\cH", 'backward-delete-char');
check_default_keybind_and_fix("\cD", 'delete-char');
check_default_keybind_and_fix("\cI", 'complete');

$INSTR = "abcdefgh\cM";
$line = $t->readline("self insert> ");
$res = $line eq 'abcdefgh'; ok('self insert', $line);

$INSTR = "\cAe\cFf\cBg\cEh\cH ij kl\eb\ebm\cDn\cM";
$line = $t->readline("cursor move> ", 'abcd'); # default string
$res = $line eq 'eagfbcd mnj kl'; ok('cursor move', $line);

$INSTR = "\cM";
print $t->readline("cursor move> ", 'abcd'), "\n";
$INSTR = "\cAe\cM";
print $t->readline("cursor move> ", 'abcd'), "\n";
$INSTR = "\cAe\cFf\cM";
print $t->readline("cursor move> ", 'abcd'), "\n";
$INSTR = "\cAe\cFf\cBg\cM";
print $t->readline("cursor move> ", 'abcd'), "\n";
$INSTR = "\cAe\cFf\cBg\cEh\cM";
print $t->readline("cursor move> ", 'abcd'), "\n";
$INSTR = "\cAe\cFf\cBg\cEh\cH\cM";
print $t->readline("cursor move> ", 'abcd'), "\n";
$INSTR = "\cAe\cFf\cBg\cEh\cH ij kl\cM";
print $t->readline("cursor move> ", 'abcd'), "\n";
$INSTR = "\cAe\cFf\cBg\cEh\cH ij kl\eb\ebm\cM";
print $t->readline("cursor move> ", 'abcd'), "\n";
$INSTR = "\cAe\cFf\cBg\cEh\cH ij kl\eb\ebm\cD\cM";
print $t->readline("cursor move> ", 'abcd'), "\n";
$INSTR = "\cAe\cFf\cBg\cEh\cH ij kl\eb\ebm\cDn\cM";
print $t->readline("cursor move> ", 'abcd'), "\n";
