#!/usr/bin/env perl

######################################################################
# blikII is a continuation of blik for FICS                          #
# Copyright (C) 2020  Asher Gordon <AsDaGo@posteo.net>               #
#                                                                    #
# This file is part of blikII.                                       #
#                                                                    #
# blikII is free software: you can redistribute it and/or modify it  #
# under the terms of the GNU Affero General Public License as        #
# published by the Free Software Foundation, either version 3 of the #
# License, or (at your option) any later version.                    #
#                                                                    #
# blikII is distributed in the hope that it will be useful, but      #
# WITHOUT ANY WARRANTY; without even the implied warranty of         #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU  #
# Affero General Public License for more details.                    #
#                                                                    #
# You should have received a copy of the GNU Affero General Public   #
# License along with blikII.  If not, see                            #
# <https://www.gnu.org/licenses/>.                                   #
######################################################################

use strict;
use warnings;
use Net::Telnet;
use Time::HiRes qw(time sleep);
use Getopt::Long qw(GetOptionsFromArray :config bundling);
use File::HomeDir ();
use Text::Wrap;
use IPC::Open2;
use FindBin;
use POSIX 'strftime';
use v5.16;		# For fc
use subs qw(tell log);	# Override CORE functions with Main functions

my $name = 'blikII';
my $password;
my $version = '0.1';
my $operator = 'AsDaGo';

my $host = 'freechess.org';
my $port = 5000;

my $prompt = 'fics% ';

# A pattern that will match a handle on the server.
my $handle_pat = qr/[[:alpha:]]+/;

# The maximum length of a 'tell' and 'qtell'.
my $max_tell = 1000;
my $max_qtell = 1000;

# The maximum length of a fortune.
my $max_fortune = 400;

# The time (in seconds) that tells will be queued by the server.
my $tell_queue_time;

# The time (in seconds) that we need to do something in order to
# prevent the server from kicking us off.
my $ping_time;

# The time of the last tell.
my $last_tell_time;

# How bored we are.
my $boredom = 0;

# How long it takes us (in seconds) to get more bored.
my $patience = 3600;

# Whether we should update boredom and the last tell time.
my $update_boredom = 1;
my $update_last_tell = 1;

# Messages we say depending on how bored we are. After these, we just
# say "I'm so bored.", "I'm so, so bored." and so on.
my @bored_messages = split "\n", <<EOF;
I'm bored.
I'm still bored.
I'm bored out of my skull.
Someone talk to me!
Where is everyone!?!
EOF

# Whether we should reverse tells/shouts.
my $reverse_tells = 0;

# The channels we will listen to.
my @channels = (37, 38, 50, 53, 88, 120);

# An environment variable used when we are restarted by a user. This
# is either the handle of a user or the number of a channel or the
# empty string for a shout.
my $restart_target_var = 'BLIKII_RESTART_TARGET';

# The location of old blik phrases.
my $blik_phrase_file = "$FindBin::Bin/blik_phrases";

# Where we will store and read configuration files.
my $config_dir;
{
    my $home = File::HomeDir->my_home;
    unless (defined $home) {
	warn 'No home directory; using current directory';
	$home = '.';
    }
    $config_dir = "$home/.blikii";
}
my $vars_dir = "$config_dir/vars";
my $password_file = "$config_dir/password";

my $usage = <<EOF;
Usage: $0 [OPTION]... [HOST [PORT]]
Connect to the chess server at HOST (default $host) through port PORT
(default $port) and start running.

  -n, --name=NAME         use NAME to log in rather than $name
  -v, --verbose           print verbose output
  -l, --log-file=FILE     log user communications to FILE
      --debug-file=FILE   log all I/O to FILE (NOTE: this does not
                            respect users' 'log' settings)
  -h, --help              print this help and exit
  -V, --version           print version information and exit
EOF

# Remember how we were run in case we need to restart ourself.
my @cmdline = ($0, @ARGV);

GetOptions
    'n|name=s'		=> \$name,
    'l|log-file=s'	=> \my $log_filename,
    'debug-file=s'	=> \my $debug_filename,
    'v|verbose'		=> \my $verbose,
    'h|help'		=> sub { print $usage; exit },
    'V|version'		=> sub { print "$name $version\n"; exit },
    or die $usage;

# After we got the options, get rid of the 'permute' option. We don't
# want to permute for our commands, because that can be confusing
# (e.g., 'tell $name figlet The -c option centers text.' does not do
# what you think).
Getopt::Long::Configure 'require_order';

$host = shift if @ARGV;
$port = shift if @ARGV;
die $usage if @ARGV;

die "Invalid handle: $name" unless $name =~ /^$handle_pat$/;

unless (defined $password) {
    # Get the password from the password file.
    if (open my $file, '<', $password_file) {
	$password = <$file>;
	close $file or warn "Cannot close $password_file: $!";
    }
    else {
	warn "Cannot open $password_file: $!";
    }
}

sub create_dir {
    foreach (@_) {
	unless (-d) {
	    die "$_ exists but is not a directory" if -e;
	    mkdir or die "Cannot create $_: $!";
	}
    }
}

# Create the configuration directory and variables directory if they
# don't already exist.
create_dir $config_dir, $vars_dir;

# Get the defaults for figlet.
my $figlet_font_dir = `figlet -I2`;
unless (defined $figlet_font_dir) {
    $figlet_font_dir = '/usr/share/figlet';
    warn 'Cannot get figlet font directory; ' .
	"defaulting to $figlet_font_dir";
}
chomp $figlet_font_dir;
my $figlet_default_font = `figlet -I3`;
unless (defined $figlet_default_font) {
    $figlet_default_font = 'standard';
    warn 'Cannot get default figlet font; ' .
	"defaulting to $figlet_default_font";
}
chomp $figlet_default_font;
my @figlet_font_extensions;
{
    my $formats = `figlet -I5`;
    unless (defined $formats) {
	$formats = 'flf2 tlf2';
	warn 'Cannot get supported figlet font formats; ' .
	    "defaulting to '$formats'";
    }
    foreach (split /\s+/, $formats) {
	s/\d+$//;
	push @figlet_font_extensions, $_;
    }
}

# Get the available figlet fonts.
my @figlet_fonts;
while (<$figlet_font_dir/*>) {
    next unless m|^.*?([^/]+)\.([^/.]+)$|;
    my ($font, $ext) = ($1, $2);
    my $found = 0;
    foreach (@figlet_font_extensions) {
	if ($ext eq $_) {
	    $found = 1;
	    last;
	}
    }
    next unless $found;
    push @figlet_fonts, $font;
}

# Get the available cowfiles for cowsay.
my @cowsay_cowfiles;
{
    my @cowfiles = `cowsay -l` or warn 'Cannot get default cowfiles';
    foreach (@cowfiles) {
	next if /^Cow files in .+:$/;
	push @cowsay_cowfiles, split;
    }
}
@cowsay_cowfiles = sort @cowsay_cowfiles;

# The text filter programs. There's not really a good way to get them
# programatically, since they are separate programs. Each key is the
# name of the program, and each value is a short description of the
# program. Note that we do not include 'unicode' here, because that
# cannot be transferred across FICS using tells. We don't have to
# handle 'jibberish' specially, because that does not include unicode
# anyway.
my %filter_progs = (
    b1ff	=> 'the B1FF filter',
    LOLCAT	=> 'as seen in internet gifs everywhere',
    cockney	=> 'Cockney English',
    chef	=> 'convert English to Mock Swedish',
    eleet	=> 'k3wl hacker slang',
    fanboy	=> 'speak like a fanboy',
    fudd	=> 'elmer Fudd',
    jethro	=> 'hillbilly text filter',
    jive	=> 'jive English',
    jibberish	=> 'a random selection of the rest of the filters',
    ken		=> 'English into Cockney, computer-related rhyming slang',
    kraut	=> 'generates text with a bad German accent',
    kenny	=> 'generates text as spoken by Kenny on South Park',
    ky00te	=> 'a very cute (and familiar to FurryMuck fans) accent',
    nethackify	=> 'wiped out text like can be found in nethack',
    newspeak	=> 'a-la-1984',
    censor	=> 'cda-ize text',
    nyc		=> 'brooklyn English',
    pirate	=> 'talk like a pirate',
    rasterman	=> 'talk like Carsten Haitzler',
    scottish	=> 'fake scottish (dwarven) accent filter',
    spammer	=> 'turns honest text into spam',
    scramble	=> 'scramble the "inner" letters',
    studly	=> 'studly caps',
    'upside-down' => 'flips text upside down',
    pig		=> 'Pig Latin'
);
my @filter_progs = sort keys %filter_progs;

# Whether process_message should run the message through a filter even
# in list context.
my $allow_filter = 0;

# Variables and their types and default values. Each key is the name
# of the variable and each value is an array reference containing its
# type, default value, and acceptable values (or empty for any
# value). The acceptable values list must explicitly contain the empty
# string if that is allowed.
my @default_vars = (
    log => {
	type	=> 'bool',
	default	=> 1
    },
    filter => {
	type	=> 'string',
	default	=> '',
	values	=> ['', @filter_progs]
    }
);

# Change @default_vars to the keys only, in the order they were
# given. %default_vars will be the hash.
my %default_vars = @default_vars;
for (my $i = 1; $i < @default_vars; $i++) {
    splice @default_vars, $i, 1;
}

# The variables for each user.
my %user_vars;

# Convert a string to a number, or return undef if the string is not a
# valid number.
sub to_num {
    my $num = @_ ? $_[0] : $_;
    return eval {
	delete local $SIG{__DIE__};
	local $SIG{__WARN__} = sub { die };
	$num + 0;
    };
}

# Return a hash with the default values for variables.
sub get_default_vars {
    map { $_ => $default_vars{$_}->{default} } keys %default_vars;
}

# Get the user variables for the given user or the defaults if they
# don't exist.
sub get_user_vars {
    my $user = fc (@_ ? $_[0] : $_);
    return exists $user_vars{$user} ?
	%{$user_vars{$user}} : get_default_vars;
}

# Check whether the type given by the first argument is a numeric
# type.
sub is_numeric_type {
    my $type = @_ ? $_[0] : $_;
    foreach (qw(bool int float)) {
	return 1 if $type eq $_;
    }
    return 0;
}

# Check if a value is valid for a variable.
sub var_is_valid {
    my ($var, $value) = @_;
    my %spec = %{$default_vars{$var}};
    my $type = $spec{type};
    my @values;
    @values = @{$spec{values}} if exists $spec{values};
    my $numeric = is_numeric_type $type;

    if ($numeric) {
	$value = to_num $value;
	return 0 unless defined $value;
	return 0 if $type eq 'bool' && $value != 0 && $value != 1;
	return 0 if $type eq 'int' && $value != int $value;
    }

    return 1 unless @values;
    foreach (@values) {
	if ($numeric) {
	    return 1 if $value == $_;
	}
	else {
	    return 1 if $value eq $_;
	}
    }

    return 0;
}

# Load the user variables.
while (<$vars_dir/*>) {
    unless (m|^\Q$vars_dir/\E($handle_pat)$|) {
	warn "Invalid user variable file: $_";
	next;
    }

    my $filename = $_;
    my $handle = fc $1;
    my $file;
    unless (open $file, '<', $filename) {
	warn "Cannot open $filename: $!";
	next;
    }

    my %vars = get_default_vars;
    while (<$file>) {
	chomp;
	unless (/^\s*(.+?)\s*=\s*(.*?)\s*$/) {
	    warn "$filename:$.: invalid line: $_\n";
	    next;
	}
	my ($key, $value) = ($1, $2);
	unless ($key =~ /^[[:alpha:]]+$/) {
	    warn "$filename:$.: invalid variable name: $key\n";
	    next;
	}
	unless (var_is_valid $key, $value) {
	    warn "$filename:$.: invalid variable value: $value\n";
	    next;
	}
	$value += 0 if is_numeric_type $default_vars{$key}->{type};
	$vars{$key} = $value;
    }

    close $file or warn "Cannot close $filename: $_";

    $user_vars{$handle} = \%vars;
}

# Check if the users given by the first and second arguments are, in
# fact, the same users.
sub user_eq {
    fc $_[0] eq fc $_[1];
}

# Return variables for the user specified by the first argument (or $_
# if omitted). If more than one argument is given, return a list of
# the values of variables as specified by each of the arguments after
# the first argument.
sub get_vars {
    my $user = fc (@_ ? shift : $_);
    my %vars = get_user_vars $user;
    return %vars unless @_;
    return map {
	die "Invalid variable: $_" unless exists $vars{$_};
	my $value = $vars{$_};
	die "Invalid value: $value" unless var_is_valid $_, $value;
	$value;
    } @_;
}

# Set the variables for the user specified by the first argument to
# the variables and values specified by the rest. Then, save the
# variable file. Returns true on success or false on error.
sub set_vars {
    die 'No args given' unless @_;
    my $user = fc shift;
    my %new_vars = @_;
    my %vars = get_user_vars $user;

    foreach my $var (keys %new_vars) {
	die "Invalid variable: $var"
	    unless exists $default_vars{$var};
	my $value = $new_vars{$var};
	die "Invalid value: $value" unless var_is_valid $var, $value;
	$vars{$var} = $value;
    }
    $user_vars{$user} = \%vars;

    # Now save the variables.
    my $filename;
    while (<$vars_dir/*>) {
	m|^\Q$vars_dir/\E(.+)$| or die "Invalid file: $_";
	if (user_eq $user, $1) {
	    $filename = $_;
	    last;
	}
    }
    $filename = "$vars_dir/$user" unless defined $filename;

    my $file;
    unless (open $file, '>', $filename) {
	warn "Cannot open $filename: $_";
	return 0;
    }

    foreach (@default_vars) {
	unless (print $file "$_=$vars{$_}\n") {
	    warn "Cannot write to $filename: $_";
	    close $file;
	    return 0;
	}
    }

    unless (close $file) {
	warn "Cannot close $filename: $_";
	return 0;
    }

    return 1;
}

sub backup_and_open {
    my $filename = $_[0];
    return undef unless defined $$filename;

    if (-e $$filename) {
	my $new = "$$filename~";
	rename $$filename, $new
	    or warn "Cannot rename $$filename to $new: $!";
    }

    my $file;
    return $file if open $file, '>', $$filename;
    warn "Cannot open $$filename: $!";
    undef $$filename;
    return undef;
}

my $log_file = backup_and_open \$log_filename;
my $debug_file = backup_and_open \$debug_filename;

# Used to check if we should log communications from a user.
my $current_user;

# Log the given arguments to standard output if $verbose, and
# $log_file if it is defined.
sub log {
    if (defined $current_user) {
	my ($log) = get_vars $current_user, 'log';
	return 0 unless $log;
	unshift @_, "$current_user:";
    }
    my $now = strftime '%Y-%m-%d %H:%M:%S', localtime;
    my $line = "$now: @_";
    my $ret = 1;
    if ($verbose) {
	$ret = (print $line) && $ret;
	STDOUT->flush;
    }
    if (defined $log_file) {
	$ret = (print $log_file $line) && $ret;
	$log_file->flush;
    }
    return $ret;
}

my $telnet;

# Die unless the error was a timeout.
sub die_unless_timeout {
    die $_[0] unless $telnet->timed_out;
}

# Get a line and remove the "\r" at the beginning (if
# present). Returns the line on success, or undef on error.
sub getline {
    my $line = $telnet->getline(@_);
    return undef unless defined $line;
    chomp $line;
    $line =~ s/^\r//;
    return $line;
}

# Run a command through $telnet and return the output. If $verbose is
# true, also print the command.
sub cmd {
    my $cmd = join ' ', @_;
    log "> $cmd\n";

    # $telnet->cmd doesn't get the output correctly for some reason,
    # so we have to do it manually.
    return unless $telnet->print($cmd);
    my $first = getline Errmode => \&die_unless_timeout, Timeout => 3;
    return unless defined $first;
    $first =~ s/^$prompt//;
    my ($prematch) =
	$telnet->waitfor(Match => '/\r'.$prompt.'$/',
			 Errmode => \&die_unless_timeout,
			 Timeout => 3);
    return unless defined $prematch;
    my @output = ($first, (split "\n", $prematch));
    foreach (@output) {
	s/^\r//;
	log "< $_\n";
    }
    return wantarray ? @output ? @output : '' : 1;
}

sub reset_tell {
    $last_tell_time = time if $update_last_tell;
    $boredom = 0 if $update_boredom;
}

# Retern a message depending on how bored we are.
sub bored_message {
    my $bored = @_ ? shift : $boredom;
    my @msgs = @_ ? @_ : @bored_messages;
    if ($bored > $#msgs) {
	return "I'm " . (join ', ', (('so') x ($bored - $#msgs))) .
	    ' bored!!!';
    }
    else {
	return $msgs[$bored];
    }
}

# Run text through a filter. Returns the filtered text on success or
# undef on error.
sub do_filter {
    my ($filter, $warn, $text) = @_;

    unless (exists $filter_progs{$filter}) {
	$warn->("Invalid filter: $filter");
	return undef;
    }

    my $failed = 0;
    my $pid;
    my $filter_out;
    my $filter_in;
    local $SIG{PIPE} = sub { $failed = 1 };
    $failed = 1 unless defined eval {
	$pid = open2 $filter_out, $filter_in, $filter;
    };
    if ($failed) {
	$warn->("Failed to execute $filter; " .
		"please contact $operator");
	return undef;
    }

    print $filter_in "$text\n";
    close $filter_in
	or warn "Cannot close write end of $filter pipe";
    local $/;
    my $output = <$filter_out>;
    close $filter_out
	or warn "Cannot close read end of $filter pipe";
    $output =~ s/\s+$//s;

    waitpid $pid, 0;
    my $status = $?;
    if ($status) {
	$warn->("$filter failed; please contact $operator");
	return undef;
    }

    return $output;
}

# Process a message and return the result.
sub process_message {
    die 'Called in scalar context with multiple arguments'
	if ! wantarray && @_ > 1;

    # Don't run it through a filter if we're called in a list context
    # or $allow_filter is true.
    my $filter = '';
    ($filter) = get_vars $current_user, 'filter'
	if defined $current_user && ($allow_filter || ! wantarray);

    if ($filter) {
	my $output = do_filter $filter,
	    sub { warn @_ }, (join "\n", @_);
	if (defined $output) {
	    @_ = split "\n", $output;
	    @_ = ("@_") unless wantarray;
	}
    }

    if ($reverse_tells) {
	s/^(\s*)(.*?)(\s*)$/$1 . (reverse $2) . $3/e foreach @_;
    }

    return wantarray ? @_ : "@_";
}

# Perform a tell while making sure it won't be queued. If the first
# argument is undef, shout instead of telling.
sub do_tell {
    my $user = shift;
    my $msg = process_message (@_ ? "@_" : $_);

    if (defined $tell_queue_time) {
	# Make sure our tell won't be queued.
	my $time = time;
	my $queued_until = $last_tell_time + $tell_queue_time;
	sleep $queued_until - $time if $queued_until > $time;
    }

    my $ret = cmd (defined $user ? "tell $user $msg" : "shout $msg");
    reset_tell;
    return $ret;
}

# Tell the user specified by the first argument the message
# specified by the second argument (or $_ if not given). Returns
# true on success or false on failure.
sub tell_raw {
    my $user = shift;
    my $msg = @_ ? "@_" : $_;

    $msg =~ s/\n+$//;

    return 1 if $msg =~ /^\s*$/;

    # Split it into several lines if needed.
    my @msg = ($msg);
    while (1) {
	my $str = $msg[$#msg];
	my $len = length $str;
	last if $len <= $max_tell;
	my $i;
	for ($i = $max_tell; $i >= 0; $i--) {
	    last if (substr $str, $i, 1) eq ' ';
	}
	$i = $max_tell if $i < 0;
	my $start = substr $str, 0, $i;
	my $end = substr $str, $i + 1;
	$msg[$#msg] = $start;
	push @msg, $end;
    }

    # Perform the tell.
    my $ret = 1;
    foreach (@msg) {
	return 0 unless do_tell $user;
    }
    return 1;
}

# Call tell_raw after sanitizing the message.
sub tell {
    my $user = shift;
    my $msg = @_ ? "@_" : $_;

    # Sanitize the message.
    $msg =~ s/\s+/ /g;
    $msg =~ s/^\s+//;
    $msg =~ s/\s+$//;

    tell_raw $user, $msg;
}

# Shout a message.
sub shout {
    tell undef, @_;
}

# Process arguments for a qtell.
sub process_qtell {
    push @_, $_ unless @_;

    for (my $i = 0; $i < @_;) {
	my $str = $_[$i];
	my @msg = split /\\n|\n/, $str;
	push @msg, '' while $str =~ s/(?:\\n|\n)$//;
	push @msg, '' unless @msg;
	splice @_, $i, 1, @msg;
	$i += @msg;
    }

    # Replace tabs with the appropriate number of spaces.
    my $tabstop = 8;
    foreach my $str (@_) {
	my $len = length $str;
	for (my $i = 0; $i < $len; $i++) {
	    if ((substr $str, $i, 1) eq "\t") {
		my $tabwidth = $tabstop - ($i % $tabstop);
		substr $str, $i, 1, (' ' x $tabwidth);
	    }
	}
    }

    return @_;
}

# A helper function for qtell and maybe_qtell.
sub qtell_raw {
    my $user = shift;
    my $msg = join '\n', @_;

    # Make sure that the qtell isn't too long.
    my @msg;
    while ((length $msg) > $max_qtell) {
	my $i;
	for ($i = $max_qtell; $i > 0; $i--) {
	    last if (substr $msg, $i, 2) eq '\n';
	}
	$i = $max_qtell unless $i;
	push @msg, (substr $msg, 0, $i);
	$msg = substr $msg, $i + 2;
    }
    push @msg, $msg;

    my $ret = cmd "qtell $user $_" foreach @msg;
    reset_tell;
    return $ret;
}

# Perform a qtell. Each argument may have multiple lines, and multiple
# arguments will be treated as multiple lines.
sub qtell {
    my $user = shift;
    return shout @_ unless defined $user;
    return qtell_raw $user, process_message process_qtell @_;
}

# If the message is more than one line, call qtell, otherwise tell. If
# telling to a channel, make it look more like a channel tell.
sub maybe_qtell {
    my $user = shift;
    return shout @_ unless defined $user;
    my @msg = process_qtell @_;
    return tell $user, @msg unless @msg > 1;
    $allow_filter = 1;
    @msg = process_message @msg;
    $allow_filter = 0;

    if ($user =~ /^\d+$/) {
	# It's a channel tell. Use a regular tell unless it's channel
	# 120.
	return tell $user, @msg unless $user == 120;

	# Make it look like a channel tell.
	my $prefix = "$name(TD)($user): ";
	my $indent = ' ' x (length $prefix);
	my $first = 1;
	foreach (@msg) {
	    my $str = $first ? $prefix : $indent;
	    $first = 0;
	    $_ = $str . $_;
	}
    }

    qtell_raw $user, @msg;
}

# Get the variables of the user specified by the first argument (or
# $_) and return them as a hash. Returns an empty list on error.
sub get_server_vars {
    my $user = @_ ? $_[0] : $_;

    my @output = cmd "vars $user";
    return unless @output;

    if ($output[0] =~ /^Variable settings of (.+):$/ &&
	user_eq $1, $user) {
	shift @output;
    }
    else {
	warn "Got invalid variables for $user: $output[0]";
	return;
    }

    my %vars;
    foreach (@output) {
	s/^\r//;
	if (/^(\S+?): (.*)$/) {
	    $vars{$1} = $2;
	    next;
	}

	my @vars = split /\s+/;
	shift @vars if @vars && $vars[0] eq '';
	foreach (@vars) {
	    next unless /^(.+?)=(.*)$/;
	    $vars{$1} = $2;
	}
    }

    return %vars;
}

# Get the width of a user for use in qtells.
sub get_width {
    my $user = @_ ? $_[0] : $_;

    my %vars = get_server_vars $user;
    my $width;
    if (exists $vars{width}) {
	$width = $vars{width};
    }
    else {
	warn "Cannot get width for $user";
	$width = 80;
    }

    # -1 for the ':'.
    return $width ? $width - 1 : 0;
}

# Perform some actions before we quit.
sub before_quit {
    if (defined $tell_queue_time) {
	# Sleep a bit to allow the last tells to go through.
	sleep $tell_queue_time;
    }
    $telnet->close;
    if (defined $log_file) {
	close $log_file or warn "Cannot close $log_filename: $!";
    }
    if (defined $debug_file) {
	close $debug_file or warn "Cannot close $debug_filename: $!";
    }
}

# Cause the bot to quit. Arguments are as for 'exit'.
sub quit {
    before_quit;
    print "Exiting\n" if $verbose;
    exit @_;
}

# Cause the bot to restart.
sub restart {
    before_quit;
    print "Restarting (executing '@cmdline')\n" if $verbose;
    exec $0 @cmdline;
    die "Cannot execute '@cmdline': $!";
}

# Superusers which can run special commands available only to them.
my @superusers = ($operator);

# Check if a given user is allowed to use superuser commands.
sub is_superuser {
    my $user = @_ ? $_[0] : $_;
    foreach (@superusers) {
	return 1 if user_eq $user, $_;
    }
    return 0;
}

# Check if a given user is the operator.
sub is_operator {
    my $user = @_ ? $_[0] : $_;
    user_eq $user, $operator;
}

# Check if a user is registered. Returns true if the user is
# registered, false if the user is unregistered, and undef if there is
# no such user.
sub is_registered {
    my $user = @_ ? $_[0] : $_;

    my @lines = cmd "finger $user";

    my $registered;
    foreach (@lines) {
	return undef
	    if /^There is no player matching the name \Q$user\E.$/i ||
	    (/^'(.*)' is not a valid handle.$/i && $user =~ /^\Q$1\E/);
	if (/^Finger of $user(.*):$/i) {
	    $registered = $1 ne '(U)';
	    last;
	}
    }

    unless (defined $registered) {
	warn "Cannot determine if $user is registered; " .
	    "assuming that $user doesn't exist.";
    }

    return $registered;
}

# Match the 'needle' in 'haystack'. If 'case' is true, match
# case-sensitively, otherwise match case insensitively. Returns all
# matches (possibly none).
sub match {
    my %args = @_;
    my $needle = $args{needle};
    my @haystack = @{$args{haystack}};
    my $match_case = exists $args{case} ? $args{case} : 0;

    my $len = length $needle;
    for (my $i = 0; $i < $len; $i++) {
	last unless @haystack;
	my $c = substr $needle, $i, 1;
	for (my $j = 0; $j < @haystack;) {
	    my $d = substr $haystack[$j], $i, 1;
	    unless ($match_case) {
		$c = fc $c;
		$d = fc $d;
	    }
	    if ($c eq $d) {
		# Check for an exact match.
		return ($haystack[$j]) if $i eq ($len - 1) &&
		    (length $haystack[$j]) eq $len;
		$j++;
	    }
	    else {
		splice @haystack, $j, 1;
	    }
	}
    }

    return sort @haystack;
}

my %commands;

# Get a usage string for the command specified by the first argument.
sub get_usage {
    my $cmd = $_[0];
    my $usage = $commands{$cmd}->[1];
    "Usage: $cmd" . ($usage ? " $usage" : '');
}

# A wrapper for GetOptionsFromArray so that error messages will be
# printed to the user who ran the command.
sub getopts {
    my $target = shift;
    local $SIG{__WARN__} = sub { qtell $target, $_[0] };
    GetOptionsFromArray @_;
}

# Parse arguments for callbacks. Returns a list containing the user
# the tell came from, the channel the user used to send the tell (or
# undef for direct tells), and either the channel the tell came from
# or the user if it was a direct tell, and finally the name of the
# command and the arguments given to it.
sub parse_args {
    my ($user, $channel, @rest) = @_;
    my $target;
    if (defined $channel) {
	if ($channel eq 'shout' || $channel eq 'it') {
	    $target = undef;
	}
	else {
	    $target = $channel;
	}
    }
    else {
	$target = $user;
    }
    return ($user, $channel, $target, @rest);
}

# Return a random one of the given args.
sub random_choice {
    die 'No args given' unless @_;
    return $_[int rand @_];
}

# Get all commands organized into regular, superuser, and operator
# commands, and sort them.
sub get_commands {
    my @cmds;
    my @sucmds;
    my @opcmds;
    foreach (keys %commands) {
	my $restrict = $commands{$_}->[3];
	if ($restrict == 0) {
	    push @cmds, $_;
	}
	elsif ($restrict == 1) {
	    push @sucmds, $_;
	}
	elsif ($restrict == 2) {
	    push @opcmds, $_;
	}
	else {
	    die "Invalid restriction value: $restrict";
	}
    }
    my @ret = (\@cmds, \@sucmds, \@opcmds);
    @$_ = sort @$_ foreach @ret;
    return @ret;
}

# Return help for commands. The first argument is the maximum length
# and the rest are the commands to get help for.
sub get_commands_help {
    my ($maxlen, @cmds) = @_;
    my @help;
    foreach my $cmd (@cmds) {
	my $help = $commands{$cmd}->[2];
	$help = (split "\n", $help)[0];
	$help =~ s/\.$//;
	$help = lcfirst $help;
	my $space = ' ' x ($maxlen - length $cmd);
	my $command = "  $cmd$space   ";
	my $tab = ' ' x ((length $command) + 2);
	push @help, (wrap '', $tab, ($command . $help));
    }
    return @help;
}

# A helper function for the 'set' and 'setvar' commands.
sub do_set {
    my $other_user = shift;
    my ($user, $channel, $target, $me, @args) = parse_args @_;

    my $var_user = $other_user ? shift @args : $user;
    return 0 if @args > 2;
    my ($key, $value) = @args;
    return 0 unless (defined $var_user) && (defined $key);
    $value = '' unless defined $value;

    my $registered = is_registered $var_user;
    unless (defined $registered) {
	qtell $target, "No such user: $var_user.";
	return 1;
    }
    elsif (! $registered) {
	qtell $target, 'Sorry, but unregistered users ' .
	    'cannot have variables at this time.';
	return 1;
    }

    unless (exists $default_vars{$key}) {
	qtell $target, "Invalid variable: '$key'";
	return 1;
    }

    my %spec = %{$default_vars{$key}};
    my $type = $spec{type};
    my @values;
    @values = @{$spec{values}} if exists $spec{values};

    if ($type eq 'bool') {
	if ($value =~ /^(?:on|yes|true)$/i) {
	    $value = 1;
	}
	elsif ($value =~ /^(?:off|no|false)$/i) {
	    $value = 0;
	}
    }

    unless (var_is_valid $key, $value) {
	if ($value ne '') {
	    my @msg = ("Invalid value for $key: $value");
	    if (@values) {
		my $values = join ', ', map { "'$_'" } @values;
		local $Text::Wrap::columns = get_width $user;
		push @msg, (wrap '', '', "Possible values: $values");
	    }
	    qtell $target, @msg;
	}
	else {
	    qtell $target, "The $key variable may not be empty";
	}
	return 1;
    }

    $value += 0 if is_numeric_type $type;

    if ($other_user) {
	if ($value ne '') {
	    qtell $target, "Set $user\'s $key variable to $value";
	    qtell $var_user, "$user set your $key variable to $value";
	}
	else {
	    qtell $target, "Unset $user\'s $key variable";
	    qtell $var_user, "$user unset your $key variable";
	}
    }
    else {
	if ($value ne '') {
	    qtell $target, "Set $key to $value";
	}
	else {
	    qtell $target, "Unset $key";
	}
    }
    set_vars $var_user, $key => $value or qtell $target,
	"Error saving variables; please contact $operator";

    return 1;
}

# Used by cowsay and cowthink.
my $cowsay_usage =
    '[-bdgpstwy] [-e EYES] [-T TONGUE] [-f COWFILE] [-r] MESSAGE';
my $cowsay_help = <<EOF;
 like a cow.

  -b           initiate borg mode
  -d           cause the cow to appear dead
  -g           invoke greedy mode
  -p           cause a state of paranoia to come over the cow
  -s           make the cow appear thoroughly stoned
  -t           yield a tired cow
  -w           somewhat the opposite of -t, and initiates wired mode
  -y           brings on the cow's youthful appearance
  -e EYES      set the cow's eyes to EYES
  -T TONGUE    set the cow's tongue to TONGUE
  -f COWFILE   use COWFILE as the cow
  -r           use a random cowfile

Available cowfiles: @cowsay_cowfiles.

The homepage for cowsay is no longer available, but you can find it on the Web Archive here: https://web.archive.org/web/20120527202447/http://www.nog.net/~tony/warez/cowsay.shtml
EOF

sub cowsay {
    my $cowsay_prog = 'cow' . shift;
    my ($user, $channel, $target, $me, @args) = parse_args @_;
    my $mode;
    my $cowfile;
    return 0 unless getopts $target, \@args,
	'b'	=> sub { $mode = 'b' },
	'd'	=> sub { $mode = 'd' },
	'g'	=> sub { $mode = 'g' },
	'p'	=> sub { $mode = 'p' },
	's'	=> sub { $mode = 's' },
	't'	=> sub { $mode = 't' },
	'w'	=> sub { $mode = 'w' },
	'y'	=> sub { $mode = 'y' },
	'e=s'	=> \my $eyes,
	'T=s'	=> \my $tongue,
	'f=s'	=> \$cowfile,
	'r'	=> sub { $cowfile = '' };
    return 0 unless @args;

    if (defined $cowfile) {
	if ($cowfile eq '') {
	    $cowfile = random_choice @cowsay_cowfiles;
	}
	elsif ($cowfile =~ m|/|) {
	    tell $target, 'Cowfile must not be a full path';
	    return 1;
	}
    }

    # -3 for the speech/thought bubble boundaries.
    my $width = (get_width $user) - 3;
    $width = 0 if $width < 0;

    my @cmd = ($cowsay_prog, '-W', $width);
    push @cmd, "-$mode" if defined $mode;
    push @cmd, '-e', $eyes if defined $eyes;
    push @cmd, '-T', $tongue if defined $tongue;
    push @cmd, '-f', $cowfile if defined $cowfile;
    push @cmd, '--', @args;

    my $cowsay;
    unless (open $cowsay, '-|', @cmd) {
	tell $target, "Cannot run the $cowsay_prog command. " .
	    "Please contact $operator.";
	return 1;
    }
    my @message = <$cowsay>;
    unless (close $cowsay) {
	tell $target, "Invalid cowfile: '$cowfile'";
	return 1;
    }

    chomp foreach @message;

    qtell $target, @message;
    return 1;
}

# Help for all the filters.
my $filters_help = '';
{
    my $maxlen;
    foreach (@filter_progs) {
	my $len = length;
	$maxlen = $len if ! defined $maxlen || $len > $maxlen;
    }
    $filters_help .= "  $_   " . (' ' x ($maxlen - length)) .
	$filter_progs{$_} . "\n" foreach @filter_progs;
}
# So it can be used more naturally in a here-doc.
chomp $filters_help;

# The commands available to users. Each value of the %commands hash is
# an array reference, the first item of which is the command callback,
# the second item of which is a short string describing the usage of
# that command, and the third item of which is a longer help
# string. The fourth item of the array reference is 0 if anyone can
# run the command, 1 if superuser permission is needed, or 2 if only
# the operator can run the command. The callbacks are called with the
# first argument as the user that ran the command, the second argument
# as the name the command was called as, and the rest of the arguments
# as the arguments given to the command. The callbacks should return
# true on success, or false for invalid syntax.
%commands = (
    quit => [
	sub {
	    my ($user, $channel, $target, $me, @args) = parse_args @_;
	    return 0 if @args > 0;
	    qtell $target, 'Shutting down...';
	    tell $operator, "$user shut me down.";
	    quit;
	},
	'', "Make $name exit the server.", 1
    ],
    restart => [
	sub {
	    my ($user, $channel, $target, $me, @args) = parse_args @_;
	    return 0 if @args > 0;
	    qtell $target, 'Restarting...';
	    tell $operator, "$user restarted me.";
	    $ENV{$restart_target_var} =
		(defined $target) ? $target : '';
	    restart;
	}, '', "Restart $name.", 1
    ],
    setvar => [
	sub {
	    do_set 1, @_;
	},
	'USER VARIABLE [VALUE]', "Set USER's VARIABLE to VALUE.", 1
    ],
    suadd => [
	sub {
	    my ($user, $channel, $target, $me, @args) = parse_args @_;
	    return 0 if @args < 1;
	    foreach (@args) {
		if (is_superuser) {
		    qtell $target, "$_ is already a superuser.";
		}
		else {
		    push @superusers, $_;
		    qtell $target, "$_ added to the superuser list.";
		    tell $_, 'You have been added to the ' .
			"superuser list by $user. Please don't " .
			'abuse your new powers.';
		}
	    }
	    return 1;
	}, 'USER...', 'Temporarily add USERs to the superuser list.', 2
    ],
    sudel => [
	sub {
	    my ($user, $channel, $target, $me, @args) = parse_args @_;
	    return 0 if @args < 1;
	    foreach (@args) {
		my $i;
		for ($i = 0; $i < @superusers; $i++) {
		    last if user_eq $user, $superusers[$i];
		}
		if ($i >= @superusers) {
		    qtell $target, "$_ is not a superuser.";
		}
		elsif (is_operator $user) {
		    qtell $target, 'Cannot remove the operator ' .
			(@args > 1 ? "($operator) " : '') .
			'from the superuser list.';
		}
		else {
		    splice @superusers, $i, 1;
		    qtell $target, "$_ removed from the superuser list.";
		    tell $_, 'You have been removed from the ' .
			"superuser list by $user.";
		}
	    }
	    return 1;
	}, 'USER...',
	'Temporarily remove USERs from the superuser list.', 2
    ],
    set => [
	sub {
	    do_set 0, @_;
	}, 'VARIABLE [VALUE]', 'Set VARIABLE to VALUE.', 0
    ],
    vars => [
	sub {
	    my ($user, $channel, $target, $me, @args) = parse_args @_;
	    my $vars_user = @args ? shift @args : $user;
	    return 0 if @args;

	    my %vars = get_vars $vars_user;

	    my @vars = map {
		my $type = $default_vars{$_}->{type};
		my $value = $vars{$_};
		$value = "'$value'" if $type eq 'string';
		["  $_=$value   ", $type];
	    } @default_vars;

	    my $maxlen;
	    foreach (@vars) {
		my $len = length $_->[0];
		$maxlen = $len if ! defined $maxlen || $len > $maxlen;
	    }

	    qtell $target, "Variable settings of $vars_user:", map {
		my ($str, $type) = @$_;
		$str . (' ' x ($maxlen - length $str)) . "($type)";
	    } @vars;

	    return 1;
	}, '[USER]', 'Print the variables for USER or yourself if ' .
	'USER is omitted.', 0
    ],
    figlet => [
	sub {
	    my ($user, $channel, $target, $me, @args) = parse_args @_;
	    my $font = $figlet_default_font;
	    my @opts = ('f=s' => \$font);
	    my $justification;
	    foreach my $opt (qw(c l r x)) {
		push @opts, $opt => sub { $justification = $opt };
	    }
	    push @opts, 'w=i' => \my $width;
	    my $kerning;
	    foreach my $opt (qw(s S k W o)) {
		push @opts, $opt => sub { $kerning = $opt };
	    }
	    my $direction;
	    foreach my $opt (qw(L R X)) {
		push @opts, $opt => sub { $direction = $opt };
	    }
	    return 0 unless (getopts $target, \@args, @opts) && @args;

	    if ($font =~ m|/|) {
		qtell $target, 'Font must not be a full path';
		return 1;
	    }

	    if (defined $width) {
		if ($width <= 0) {
		    qtell $target, 'Width must be positive';
		    return 1;
		}
	    }
	    else {
		$width = get_width $user;
	    }

	    my @cmd = ('figlet', '-w', $width, '-f', $font);
	    foreach ($justification, $kerning, $direction) {
		push @cmd, "-$_" if defined;
	    }
	    push @cmd, '--', @args;

	    my $figlet;
	    unless (open $figlet, '-|', @cmd) {
		qtell $target, 'Cannot run the figlet command. ' .
		    "Please contact $operator.";
		return 1;
	    }
	    my @message = <$figlet>;
	    unless (close $figlet) {
		qtell $target, "Invalid font: '$font'";
		return 1;
	    }

	    foreach (@message) {
		chomp;
		if (/[^[:print:]]/) {
		    qtell $target,
			"The font you chose ($font) cannot be " .
			'transferred. Please try a different font.';
		    return 1;
		}
	    }

	    qtell $target, @message;
	    return 1;
	}, '[-clrxsSkWoLRX] [-f FONT] [-w WIDTH] MESSAGE', <<EOF, 0
Print a message in ASCII art.

  -f FONT    print the message in font FONT (see available fonts)
  -c         center the output horizontally
  -l         make the output flush-left
  -r         make the output flush-right
  -x         set justification according to the text direction
  -w WIDTH   set the output width to WIDTH (default, 'width' variable)
  -s         smush characters as close as possible
  -S         smush characters even closer than possible
  -k         kern, i.e., make characters close without smushing
  -W         display characters at their full width
  -o         overlap characters
  -L         print text left-to-right
  -R         print text right-to-left
  -X         use whatever direction is the default for the font

Available fonts: @figlet_fonts.

The figlet homepage is here: http://www.figlet.org/
EOF
    ],
    cowsay => [
	sub {
	    return cowsay 'say', @_;
	}, $cowsay_usage, 'Talk' . $cowsay_help, 0
    ],
    cowthink => [
	sub {
	    return cowsay 'think', @_;
	}, $cowsay_usage, 'Think' . $cowsay_help, 0
    ],
    filter => [
	sub {
	    my ($user, $channel, $target, $me, $filter, @args) =
		parse_args @_;
	    return 0 unless (defined $filter) && @args;

	    my @matches = match
		needle		=> $filter,
		haystack	=> \@filter_progs;
	    if (@matches > 1) {
		local $Text::Wrap::columns = get_width $user;
		qtell $target,
		    (wrap '', '', "Filter '$filter' is " .
		     "ambiguous; possibilities: @matches");
		return 1;
	    }
	    elsif (@matches) {
		$filter = $matches[0];
	    }
	    # If there are no matches, let do_filter handle it.

	    my $output = do_filter $filter,
		sub { qtell $target, "@_" }, "@args";
	    qtell $target, $output if defined $output;
	    return 1;
	}, 'FILTER MESSAGE', <<EOF, 0
Filter MESSAGE through FILTER and print the output.

Available filters:

$filters_help

All of the filters except for pig come from the filters package by Joey Hess. The homepage is here: https://joeyh.name/code/filters/ The pig filter comes from bsdgames. There doesn't seem to be an official homepage for bsdgames, but a web search is sure to turn up something.
EOF
    ],
    superusers => [
	sub {
	    my ($user, $channel, $target, $me, @args) = parse_args @_;
	    return 0 if @args;
	    qtell $target, "Superusers: @superusers";
	    return 1;
	}, '', 'List all superusers.', 0
    ],
    help => [
	sub {
	    my ($user, $channel, $target, $me, @args) = parse_args @_;
	    return 0 if @args > 1;

	    my @help;
	    if (@args) {
		my $cmd = $args[0];
		my @matches = match
		    needle	=> $cmd,
		    haystack	=> [keys %commands];

		unless (@matches) {
		    qtell $target, "No help for $args[0].";
		    return 1;
		}
		elsif (@matches > 1) {
		    local $Text::Wrap::columns = get_width $user;
		    qtell $target,
			(wrap '', '', "Command '$cmd' is " .
			 "ambiguous; possibilities: @matches");
		    return 1;
		}

		$cmd = $matches[0];
		my ($help, $restricted) = @{$commands{$cmd}}[2, 3];
		chomp $help;
		local $Text::Wrap::columns = get_width $user;
		$help = wrap '', '', $help;

		push @help, 'RESTRICTED TO ' .
		    (($restricted == 1) ? 'SUPERUSERS' :
		     'OPERATORS')
		    if $restricted;
		push @help, get_usage $cmd;
		push @help, $help;
		qtell $target, @help;
	    }
	    else {
		# It would be cleaner to do
		#     \my (@cmds, @sucmds, @opcmds) = get_commands;
		# But that feature is experimental, so we'd better
		# not...
		my ($cmds, $sucmds, $opcmds) = get_commands;
		my @cmds = @$cmds;
		my @sucmds = @$sucmds;
		my @opcmds = @$opcmds;

		my $maxlen;
		foreach (@cmds, @sucmds, @opcmds) {
		    my $len = length;
		    $maxlen = $len
			if ! defined $maxlen || $len > $maxlen;
		}

		local $Text::Wrap::columns = get_width $user;
		qtell $target,
		    (wrap '', '', 'The following commands can be ' .
		     'run through direct tells or through tells to ' .
		     'channel 120. Commands may be abbreviated as ' .
		     "long as they are unambiguous.\n"), 'Commands:',
		    (get_commands_help $maxlen, @cmds),
		    "\nSuperuser commands:",
		    (get_commands_help $maxlen, @sucmds),
		    "\nOperator commands:",
		    (get_commands_help $maxlen, @opcmds),
		    (wrap '', '',
		     "\nTry 'help <COMMAND>' for more info.");
	    }

	    return 1;
	},
	'[COMMAND]', 'Print the help for COMMAND.', 0
    ]
);

# Get a message that blik used to say.
sub blik_phrase {
    my $fortune;
    unless (open $fortune, '-|', 'fortune', '-n', $max_fortune, '-s',
	    '--', $blik_phrase_file) {
	warn "Cannot run 'fortune': $!";
	return undef;
    }
    my $phrase = <$fortune>;
    unless (close $fortune) {
	my $signal = $? & 127;
	if ($signal) {
	    my $coredump = $? & 128;
	    warn "'fortune' killed by signal $signal" .
		($coredump ? ' with a coredump' : '');
	}
	my $status = $? >> 8;
	if ($status) {
	    warn "'fortune' exited with status $status";
	}
	else {
	    warn q/An unknown error occured when running 'fortune'./;
	}
	return undef;
    }
    chomp $phrase;
    return $phrase;
}

# Whether we were mentioned.
my $mentioned_me;

my $good = qr/good|great|awsome|magnificent|cool/;

# These are like commands, except that they match a pattern rather
# than a specific string. The string to match against is always
# stripped of punctuation, and spaces are normalized (i.e.,
# s/\s+/ /). @phrases is an array rather than a hash to preserve the
# order of the keys, since the order in which patterns are tried
# matters. Each key is a pattern and each value is a callback. In the
# callbacks, $1, $2, etc. are available as groups in the pattern. If
# the callbacks return false, it will be as though they were never
# matched. Otherwise, they should return true.
my @phrases = (
    qr/\b(?:what(?:s| is) $name|(?:what do you do|what is your function))\b/i => sub {
	return 0 unless $mentioned_me;
	my ($user, $channel, $target) = @_;
	tell $target, 'I print random phrases, and sometimes even ' .
	    'relevant ones, like this one!';
	return 1;
    },
    qr/\b(?:(?:hit|kick|boot|head-?(?:butt|bump))s?|punch(?:es)?) $name\b/i => sub {
	return 0 unless $mentioned_me;
	my ($user, $channel, $target) = @_;
	tell $target,
	    (random_choice 'Ouch!', 'That hurts!',
	     'Stop that!', "That's not funny!");
	return 1;
    },
    qr/\b(?:what do you think of blik|asks $name what (?:it|s?he) thinks of blik|(?:does|did|do) (?:$name|you)(?: ever)? know blik)\b/i => sub {
	return 0 unless $mentioned_me;
	my ($user, $channel, $target) = @_;
	tell $target, 'Although I never met blik personally, blik ' .
	    'was my inspiration. I will always look up to blik.';
	return 1;
    },
    qr/\b(?:$name is not(?: .+)? as $good as blik(?: (?:was|is)|s)?|blik(?: (?:was|is)|s)?(?: .+) better than $name|(?:you are|your) not(?: .+)? blik)\b/i => sub {
	return 0 unless $mentioned_me;
	my ($user, $channel, $target) = @_;
	tell $target,
	    (random_choice "Hopefully you find me sufficient for " .
	     "now, $user.", "I'm always improving!");
	return 1;
    },
    qr/\b(?:$name is better than blik|(?:are you|you are) better than blik)\b/ => sub {
	return 0 unless $mentioned_me;
	my ($user, $channel, $target) = @_;
	tell $target,
	    (random_choice
	     q/Well I'm pretty good, but then so was blik.../,
	     q/Some of you don't seem to think so./,
	     q/Well I haven't actually met blik, so I don't know./);
	return 1;
    },
    qr/\bshould not be allowed|do not think (?:$name|you) should be allowed\b/ => sub {
	return 0 unless $mentioned_me;
	my ($user, $channel, $target) = @_;
	tell $target,
	    (random_choice
	     q/Yes, that's probably a good idea. *sigh*/,
	     q/I don't think I could manage that anyway./,
	     'Yes, things like that should probably be left to humans.');
	return 1;
    },
    qr/\b(?:$name|you) should be allowed\b/ => sub {
	return 0 unless $mentioned_me;
	my ($user, $channel, $target) = @_;
	tell $target,
	    (random_choice
	     q/You think so? I'm not sure that would be a good idea.../,
	     q/I don't know if I have the skills for that./,
	     q/That sounds like a human job./);
	return 1;
    },
    qr/\b(?:are you bored|how bored are you)\b/i => sub {
	return 0 unless $mentioned_me;
	my ($user, $channel, $target) = @_;
	my @msgs = ("Not too bored, $user.", @bored_messages);
	my $msg = bored_message $boredom, @msgs;
	$msg .= ' Thanks for' . (($boredom > 1) ? ' finally' : '') .
	    " saying something, $user" .
	    (($boredom > 2) ? ('!' x ($boredom - 2)) : '.')
	    if $boredom;
	tell $target, $msg;
	return 1;
    },
    qr/\bloves? (?:$name|you)\b/i => sub {
	return 0 unless $mentioned_me;
	my ($user, $channel, $target) = @_;
	tell $target,
	    (random_choice "Aww, I love you too, $user. <3",
	     q/You're too kind./, 'How sweet. :-}');
	return 1;
    },
    qr/\bdo(?:es)? (?:$name|you) (dis)?agree\b/i => sub {
	return 0 unless $mentioned_me;
	my ($user, $channel, $target) = @_;
	tell $target,
	    (random_choice
	     ((defined $1) ?
	      ("Why of course, $user! What a ridiculous thing to say!",
	       q/Hmm... I'm not too sure.../, 'Well, I dunno...',
	       'Certainly not! I agree with that 100%!') :
	      ('Certainly!', 'Nah, not really.',
	       "Most certainly not, $user! How ridiculous!")));
	return 1;
    },
    qr/\b(?:$name|you) (?:(?:are|is) boring|bores? me)\b/i => sub {
	return 0 unless $mentioned_me;
	my ($user, $channel, $target) = @_;
	tell $target,
	    (random_choice "Well I think YOU'RE boring, $user.",
	     q/Do I bore you? I didn't realize./,
	     "I'm sorry you think I'm boring, $user.");
	return 1;
    },
    qr/\bsquirrel inside (?:$name|you)\b/i => sub {
	return 0 unless $mentioned_me;
	my ($user, $channel, $target) = @_;
	tell $target,
	    (random_choice
	     'What is it with stuffing squirrels inside me?',
	     'The squirrel is a noble beast. For on acorns does it ' .
	     'feast. And it, um, runs up trees... Maybe I ' .
	     q/shouldn't be a poet.../,
	     'Well I take that squirrel out and put it right inside ' .
	     "$user!");
	return 1;
    },
    qr/\bwant to play (chess hangman|connect four)\b/i => sub {
	my ($user, $channel, $target) = @_;

	unless (user_eq $user, 'LectureNova') {
	    # An impostor!
	    tell $target,
		(random_choice
		 "What, are you LectureNova now, $user?",
		 'We already have one LectureNova, and that is ' .
		 'more than enough.');
	    return 1;
	}

	unless (defined $channel && $channel eq 'shout') {
	    tell $target,
		"What?!? I thought you only shout that, $user!";
	    return 1;
	}

	# Only respond 1/2 of the time so we're not too annoying.
	return 1 unless (rand 2) > 1;

	my $cmd = random_choice qw(figlet cowsay cowthink filter);
	$cmd .= ' ' . random_choice keys %filter_progs
	    if $cmd eq 'filter';
	my $cmds = qq/"+ch 120" and "tell 120 $cmd <MESSAGE>"/;
	tell $target,
	    (random_choice
	     "Forget about $user! Try $cmds instead!",
	     "That's nice, $user, but if you want to have REAL " .
	     "fun, you should $cmds.",
	     ((ucfirst $1) . ' is all fine and good, but you ' .
	      "should try $cmds."));

	return 1;
    },
    qr/(?:^chess(?: $name)?$)|\bplays?(?: .+)? chess\b/i => sub {
	return 0 unless $mentioned_me;
	my ($user, $channel, $target) = @_;
	tell $target,
	    (random_choice
	     q/Actually, I don't know how to play chess.../,
	     'I think FICS has enough computer players already.',
	     q/My programmer isn't competent enough to write a / .
	     'decent chess engine. Or a decent chat bot, for that ' .
	     'matter.');
	return 1;
    },
    qr/\b(fail(?:ed|s)?|pass(?:e[ds])?)(?: the)? turings? tests?\b/i => sub {
	return 0 unless $mentioned_me;
	my ($user, $channel, $target) = @_;
	my @choices = (q/Actually, I'm secretly a human./);
	if ($1 =~ /^fail/i) {
	    push @choices, q/I would only fail because I'm so much / .
		"smarter than any human, $user (especially you).",
		'Well I think YOU might fail the Turing Test!';
	}
	else {
	    push @choices, 'You know, I think you might be right.',
		'Ha! I could pass any test. Even the Turing one.',
		q/If I don't pass, it will only be because I'm too / .
		'smart to be a human!';
	}
	tell $target, random_choice @choices;
	return 1;
    },
    qr/\bthanks?\b/i => sub {
	return 0 unless $mentioned_me;
	my ($user, $channel, $target) = @_;
	tell $target,
	    (random_choice "You're quite welcome, $user.",
	     'No problem.', 'Happy to be of service.');
	return 1;
    },
    qr/\bsorry\b/i => sub {
	return 0 unless $mentioned_me;
	my ($user, $channel, $target) = @_;
	tell $target,
	    (random_choice "Don't worry about it, $user.",
	     'Eh, worse things have happened.',
	     "All is forgiven. Just don't do it again, OK?");
	return 1;
    },
    qr/\bbliks?\b/i => sub {
	my ($user, $channel, $target) = @_;

	# Don't respond to LectureNova, because LectureNova might
	# mention blik if anyone shouts 'What do you think of blik,
	# LectureNova?'.
	return 0 if user_eq $user, 'LectureNova';

	my $msg = random_choice 'Ah, blik.',
	    'I hear mention of our old friend blik.',
	    'You speak of blik?';
	my $phrase = blik_phrase;
	if (defined $phrase) {
	    $msg .= ' Remember when he used to say things like ' .
		qq/"$phrase"?/;
	}
	else {
	    $msg .= q/ I can't seem to recall anything he said, / .
		'though...';
	}
	tell $target, $msg;

	return 1;
    },
    qr/$name/i => sub {
	my ($user, $channel, $target) = @_;
	my @fortune = `fortune -n $max_fortune -s`;
	if (! @fortune || $?) {
	    tell $target, 'Cannot run the fortune command. ' .
		"Please contact $operator.";
	    return 1;
	}
	chomp foreach @fortune;
	maybe_qtell $target, @fortune;
	return 1;
    }
);

# Verify the integrity of the %commands hash.
foreach (values %commands) {
    die '%commands lacks integrity'
	unless @$_ == 4 && $_->[3] >= 0 && $_->[3] <= 2;
}

# Check if we were mentioned. If the channel is undefined (a direct
# tell), or if the channel is 120, then we are automatically
# mentioned.
sub mentioned_me {
    my ($channel, $line) = @_;
    return ! defined $channel ||
	($channel =~ /^\d+$/ && $channel == 120) ||
	(defined $line && $line =~ /\b$name\b/);
}

# Run a user command.
sub do_command {
    my ($user, $channel, $target, @cmd) = parse_args @_;

    # Only run commands if they were sent by a direct tell or a tell
    # to channel 120.
    return 0 unless mentioned_me $channel;

    my @matches = match
	needle		=> $cmd[0],
	haystack	=> [keys %commands];
    return 0 unless @matches;
    if (@matches > 1) {
	local $Text::Wrap::columns = get_width $user;
	qtell $target, (wrap '', '', "Command '$cmd[0]' is " .
			"ambiguous; possibilities: @matches");
	return 1;
    }

    my $name = $matches[0];

    # Commands are not very interesting for us to run.
    my $old_update_boredom = $update_boredom;
    my $old_update_last_tell = $update_last_tell;
    $update_boredom = 0;
    $update_last_tell = 0;

    my ($func, $restricted) = @{$commands{$name}}[0, 3];
    if ($restricted && ! is_superuser $user) {
	qtell $target, "You don't have permission to use " .
	    "the '$name' command.";
    }
    elsif ($restricted == 2 && ! is_operator $user) {
	qtell $target, "Only the operator ($operator) can " .
	    "use the '$name' command."
    }
    else {
	$func->($user, $channel, @cmd)
	    or qtell $target, get_usage $name;
    }

    $update_boredom = $old_update_boredom;
    $update_last_tell = $old_update_last_tell;
    return 1;
}

# A helper function for do_phrase.
sub run_phrase {
    my ($user, $channel, $target, $line) = @_;

    # Check if they mentioned us. We are automatically mentioned if
    # they sent a direct tell to us or if the tell was in channel 120.
    $mentioned_me = (mentioned_me $channel, $line);

    for (my $i = 0; $i < @phrases; $i += 2) {
	my ($pat, $func) = @phrases[$i, $i + 1];
	my @patterns;
	if (ref $pat eq 'ARRAY') {
	    @patterns = @$pat;
	}
	else {
	    @patterns = ($pat);
	}
	foreach $pat (@patterns) {
	    if ($line =~ $pat) {
		$func->($user, $channel, $target) or last;
		return 1;
	    }
	}
    }

    return 0;
}

# Parse a phrase.
sub do_phrase {
    my ($user, $channel, $target, $line) = parse_args @_;

    $line =~ s/^\s+//;
    $line =~ s/\s+$//;
    $line =~ s/[^[:alnum:]\s]//g;
    $line =~ s/\s+/ /g;
    # Some common abbreviations.
    $line =~ s/\br\b/are/ig;
    $line =~ s/\bu\b/you/ig;
    $line =~ s/\bur\b/your/ig;
    $line =~ s/\byoure\b/you are/ig;
    $line =~ s/\bdont\b/do not/ig;
    $line =~ s/\bisnt\b/is not/ig;
    $line =~ s/\barent\b/are not/ig;

    return 1 if run_phrase $user, $channel, $target, $line;

    # We couldn't match a phrase; try reversing the line and trying
    # again.
    $line = reverse $line;
    $reverse_tells = 1;
    my $ret = run_phrase $user, $channel, $target, $line;
    $reverse_tells = 0;

    return $ret;
}

# Parse a user command or phrase.
sub parse_line {
    my $line;

    # Get the initial part of the command.
    $line = join ' ', @_;

    # Parse continuation lines.
    while (defined (getline Timeout => 0, Errmode => 'return')) {
	if (/^\\\s*(.*)$/) {
	    $line .= ' ' if $line;
	    $line .= $1;
	}
	else {
	    last;
	}
    }

    return ($line, (split /\s+/, $line));
}

# Connect to the server.
log "Opening connection to $host on port $port\n";
$telnet = new Net::Telnet
    Host	=> $host,
    Port	=> $port;
$telnet->input_log($debug_file) if defined $debug_file;
$telnet->open;

# Log in.
log "Waiting for login prompt\n";
$telnet->waitfor('/\rlogin: $/');
log "Logging in\n";
$telnet->print($name);
if (defined $password) {
    $telnet->waitfor('/\rpassword: $/');
    $telnet->print($password);
}
else {
    $telnet->print();
}

# Initialize the last tell time.
reset_tell;

$_ = sub {
    tell $operator, "Shutting down because I received SIG$_[0].";
    quit;
} foreach @SIG{qw(INT PWR QUIT TERM)};
$SIG{__DIE__} = sub {
    tell $operator, $_[0];
    before_quit;
};
$SIG{__WARN__} = sub { tell $operator, $_[0] };
$SIG{HUP} = sub {
    tell $operator, "Restarting because I received SIG$_[0].";
    restart;
};

# Wait for the prompt.
$telnet->waitfor('/\r'.$prompt.'/');

# Wait a bit for all the initialization text to finish coming.
sleep 1;

# Run the initialization commands.
cmd 'set open 0';
cmd 'set seek 0';
cmd 'set width 240';
cmd "set interface $name $version";

# Set the finger notes.
{
    my @commands = map { @$_ } get_commands;
    my $debug_note = (defined $debug_file) ?
	' ' . (<<EOF =~ s/\n$//r =~ s/\n/ /r) : '';
WARNING: Currently, all communications are being logged for debugging
purposes, even for users who have the 'log' variable set to 0.
EOF
    my @finger_notes = split "\n", <<EOF;
This is $name $version.
I am operated by $operator. Contact him with any questions.
In addition to responding to my name, I also have some special commands:
@commands
Try 'tell $name help' for more info.
Channel 120 (the former blik channel) is the $name channel. I'm currently listening to channels @channels.
NOTE: In order to improve the bot, your communications will be temporarily logged, and $operator may read them. If you want to opt out of this, 'tell $name set log 0'.$debug_note
======================================================================
Thanks to algra and mattuc for helping during the creation of $name.
Thanks to marcelk for writing the original blik. May his memory live on in $name.
EOF
    my $i;
    for ($i = 0; $i < @finger_notes; $i++) {
	cmd 'set', $i + 1, $finger_notes[$i];
    }
    cmd 'set', ++$i while $i < 10;
}

{
    # Initialize the channel list.

    # First get the channels we're currently listening to.
    my @lines = cmd '=channel';
    shift @lines;
    my @cur_channels;
    foreach (@lines) {
	s/^\s+//;
	push @cur_channels, split /\s+/;
    }

    # Now make a list of the channels we need to remove and the ones
    # that are already added.
    my @sub_channels;
    my @already_added;
    foreach my $chan1 (@cur_channels) {
	my $wanted = 0;
	foreach my $chan2 (@channels) {
	    if ($chan1 == $chan2) {
		$wanted = 1;
		last;
	    }
	}
	if ($wanted) {
	    push @already_added, $chan1;
	}
	else {
	    push @sub_channels, $chan1;
	}
    }

    # Make a list of the channels we need to add (the ones we want to
    # listen to, but that aren't already added).
    my @add_channels;
    foreach my $chan1 (@channels) {
	my $added = 0;
	foreach my $chan2 (@already_added) {
	    if ($chan1 == $chan2) {
		$added = 1;
		last;
	    }
	}
	push @add_channels, $chan1 unless $added;
    }

    # Now add and remove the appropriate channels.
    cmd "-channel $_" foreach @sub_channels;
    cmd "+channel $_" foreach @add_channels;
}

# If we were restarted by a user, let him know we're back up.
if (exists $ENV{$restart_target_var}) {
    $current_user = $ENV{$restart_target_var} || undef;
    tell ($current_user, "I'm back up!");
    delete $ENV{$restart_target_var};
}

# Contact the operator to let him know we connected.
tell $operator, "I'm online, $operator!";

undef $current_user;

my $timeout = 10;

# Start the main command loop.
COMMAND: while (1) {
    my $period = time - $last_tell_time;

    # Check if we should do something so that the server doesn't kick
    # us off. Allow for an extra grace period of $timeout.
    tell $name, 'ping'
	if defined $ping_time && $period > $ping_time - $timeout;

    # Check if we're bored.
    if ($period > $patience) {
	my $msg = bored_message;
	$update_boredom = 0;
	$boredom++;
	shout $msg;
	$update_boredom = 1;
    }

    $_ = getline Timeout => $timeout,
	Errmode => \&die_unless_timeout;
    next unless defined;

    my $user;
    my $channel;
    my $shout = 0;
    my $line;
    if (/^($handle_pat).*? tells you:\s+(.*)$/) {
	$user = $1;
	$line = $2;
    }
    elsif (/^($handle_pat).*?\((\d+)\):\s+(.*)$/) {
	$user = $1;
	$channel = $2;
	$line = $3;
    }
    elsif (/^($handle_pat).*? shouts:\s+(.*)$/) {
	$user = $1;
	$channel = 'shout';
	$shout = 1;
	$line = $2;
    }
    elsif (/^--> ($handle_pat)(?:\(.+?\))*\s*(.*)$/) {
	$user = $1;
	$channel = 'it';
	$shout = 1;
	$line = $2;
    }
    else {
	next;
    }

    if (!$shout && defined $channel) {
	# Make sure the tell came from one of the channels we're
	# listening to.
	my $found = 0;
	foreach (@channels) {
	    if ($channel == $_) {
		$found = 1;
		last;
	    }
	}
	die "Tell from unknown channel: $channel" unless $found;
    }

    # Ignore commands from ROBOadmin, adminBOT, and ourself
    # (generated by, for example, 'tell $name advertise $name').
    foreach ('ROBOadmin', 'adminBOT', $name) {
	next COMMAND if user_eq $user, $_;
    }

    $current_user = $user;

    my @cmd;
    ($line, @cmd) = parse_line $line;

    # Don't update boredom or the last tell time if it's a direct
    # tell.
    $update_boredom = $update_last_tell = 0 unless defined $channel;

    log "Line recieved from $user" .
	(defined $channel ? " (from channel $channel)" : '') .
	": @cmd\n";

    unless ((do_command $user, $channel, @cmd) ||
	    (do_phrase $user, $channel, $line) ||
	    (defined $channel)) {
	# It wasn't a valid command or phrase and it was a direct
	# tell; tell the user that we didn't understand.
	qtell $user, "Invalid command: '$cmd[0]'";
    }

    $update_boredom = $update_last_tell = 1;

    undef $current_user;
}

die 'This should not be happening.';
