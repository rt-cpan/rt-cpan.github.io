package Getopt::Euclid;



use version; $VERSION = qv('0.2.0');

use warnings;
use strict;
use Carp;
use File::Spec::Functions qw(splitpath);
use List::Util qw( first );



# Utility sub to factor out hash key aliasing...
sub _make_equivalent {
    my ($hash_ref, %pairs) = @_;

    for my $name (keys %pairs) {
        for my $alias ( @{$pairs{$name}} ) {
            $hash_ref->{$alias} = $hash_ref->{$name};
        }
    }

    return;
}

# Report problems in specification...

sub _fail {
    my (@msg) = @_;
    die "Getopt::Euclid: @msg\n";
}

my $has_run;
my @std_POD;

END { $has_run = 1 }

sub Getopt::Euclid::Importer::DESTROY {
    return if $has_run || $^C;  # No errors when only compiling
    croak '.pm file cannot define an explicit import() when using Getopt::Euclid';
}


sub import {
    # When running in Perls syntax check mode (-c CLI switch) do NOT parse parameters!
    # Checking parameters may fail, which is not what we want.
    return if $^C;

    # Enter single step mode when running under the debugger
    # $DB::single = 1;

    shift @_;
    my $minimal_keys;
    my $vars_prefix;
    @_ = grep { ! (/:minimal_keys/      and $minimal_keys = 1            ) } @_;
    @_ = grep { ! (/:vars(?:<(\w+)>)?/  and $vars_prefix = $1 || "ARGV_" ) } @_;
    croak "Unknown mode ('$_')" for @_;

    if ($has_run) {
        carp "Getopt::Euclid loaded a second time";
        warn "Second attempt to parse command-line was ignored\n";
        return;
    }

    # Handle calls from .pm files...
    my @caller = caller;
    if ($caller[1] =~ m/[.]pm \z/xms) {
        # Save module's POD...
        # use Data::Dumper;
        my $file = $caller[1];
        if (not -f $file) {
            if ( $INC{$file} && -f $INC{$file} ) {
               $file = $INC{$file};
            } else {
                $file =~ s{^/loader/0x[^/]+/}{};
                if (not -f $file) {
                    if ( $INC{$file} && -f $INC{$file} ) {
                        $file = $INC{$file};
                    }
                }
            }
        }

        my $fh;
#        open $fh, '<', $caller[1] or open $fh, '<', $INC{$caller[1]}
#            or croak "Getopt::Euclid was unable to access POD\n(Error: $!)\nFile: '$caller[1]' or '$INC{$caller[1]}'. Problem was";

        open $fh, '<', $file
            or croak "Getopt::Euclid was unable to access POD\n(Error: $!)\nFile: '$file'. Problem was";
        push @std_POD, do{ local $/; <$fh>};

        # Install this import() sub as module's import sub...tc
        no strict 'refs';
        croak '.pm file cannot define an explicit import() when using Getopt::Euclid'
            if *{"$caller[0]::import"}{CODE};

        my $lambda;  # Needed so the anon sub is generated at run-time
        *{"$caller[0]::import"}
            = bless sub { $lambda = 1; goto &Getopt::Euclid::import },
                    'Getopt::Euclid::Importer';

        return;
    }

    $has_run = 1;

    # Acquire POD source...
    # When running under PAR
    open my $fh, '<', $ENV{PAR_PROGNAME} || $0
        or croak "Getopt::Euclid was unable to access POD / Script '$0' \n(Error: $!)\nProblem was";
    my $source = do{ local $/; <$fh>};


    #
    # Clean up line delimeters:
    #   Windows      : \x0D\x0A
    #   Unix         : \x0A
    #   MacOS Classic: \x0D
    #
    #   => Replace them by native line ending on this platform: \n
    #

    my $LINE_DELIMETERS = qr{ \x0D? \x0A | \x0D }xms;
    $source =~ s{ $LINE_DELIMETERS }{\n}gxms;
    map      { s{ $LINE_DELIMETERS }{\n}gxms; } @std_POD;


    # Clean up significant entities...
    $source =~ s{ E<lt> }{<}gxms;
    $source =~ s{ E<gt> }{>}gxms;

    # Set up parsing rules...
    my $HWS      = qr{ [^\S\n]*      }xms;
    my $EOHEAD   = qr{ (?= ^=head1 | \z)  }xms;
    my $POD_CMD  = qr{ \n\n = [^\W\d]\w+ [^\n]* \n\n}xms;
    my $POD_CUT  = qr{ \n\n = cut $HWS \n\n}xms;

    my $NAME     = qr{ $HWS NAME    $HWS \n }xms;
    my $VERS     = qr{ $HWS VERSION $HWS \n }xms;
    my $USAGE    = qr{ $HWS USAGE   $HWS \n }xms;

    my $STD      = qr{ STANDARD | STD  }xms;
    my $ARG      = qr{ $HWS ARG(?:UMENT)?S? }xms;

    my $OPTIONS  = qr{ $HWS $STD? $HWS OPTION(?:AL|S)? $ARG? $HWS \n }xms;
    my $REQUIRED = qr{ $HWS $STD? $HWS REQUIRED        $ARG? $HWS \n }xms;

    my $EUCLID_ARG = qr{ ^=item \s* ([^\n]*?) \s* \n\s*\n
                        (
                        .*?
                        (?:
                            ^=for \s* (?i: Euclid) .*? \n\s*\n
                            | (?= ^=[^\W\d]\w* | \z)
                        )
                        )
                    }xms;


    # Extract POD alone...
    my @chunks = $source =~ m{ $POD_CMD .*? (?: $POD_CUT | \z ) }gxms;
    my $pod = join q{}, @chunks;

    # Extract essential interface components...
    my ($prog_name)     = (splitpath($0))[-1];

    my ($version)
        = $pod =~ m/^=head1 $VERS .*? (\d+(?:[._]\d+)+) .*? $EOHEAD /xms;
    if ( !defined $version ) {
        $version = $main::VERSION;
    }


    my ($opt_name, $options)
        = $pod =~ m/^=head1 ($OPTIONS)  (.*?) $EOHEAD /xms;

    ### gepatched
    $opt_name = "OPTIONS";

    my ($req_name, $required)
        = $pod =~ m/^=head1 ($REQUIRED) (.*?) $EOHEAD /xms;

    ### gepatched
    $req_name = "REQUIRED ARGUMENTS";

    my ($licence)
        = $pod =~ m/^=head1 [^\n]+ (?i: licen[sc]e | copyright ) .*? \n \s* (.*?) \s* $EOHEAD /xms;

    # Extra info from higher-level pod...
    for my $std_POD (reverse @std_POD) {
        my (undef, $more_options)
            = $std_POD =~ m/^=head1 ($OPTIONS)  (.*?) $EOHEAD /xms;
        $options = ($more_options||q{}) . ($options||q{});

        my (undef, $more_required)
            = $std_POD =~ m/^=head1 ($REQUIRED) (.*?) $EOHEAD /xms;
        $required = ($more_required||q{}) . ($required||q{});

        my ($more_licence)
            = $std_POD =~ m/^=head1 [^\n]+ (?i: licen[sc]e | copyright ) .*? \n \s* (.*?) \s* $EOHEAD /xms;
        $licence = ($more_licence||q{}) . ($licence||q{});
    }

    # Clean up interface titles...
    NAME:
    for my $name ($opt_name, $req_name) {
        next NAME if ! defined $name;
        $name =~ s{\A \s+ | \s+ \z}{}gxms;
    }

    # Extract the actual interface...
    my @requireds = ($required||q{}) =~ m{ $EUCLID_ARG }gxms;
    my @options   = ($options||q{})  =~ m{ $EUCLID_ARG }gxms;

    # Convert each arg entry to a hash...
    my (%requireds, %options);
    my %long_names;
    my $seq_num = 0;
    my %seen;
    while (@requireds) {
        my ($name, $spec) = splice @requireds, 0, 2;
        my @variants = _get_variants($name);
        $requireds{$name} = {
            seq      => $seq_num++,
            src      => $spec,
            name     => $name,
            variants => \@variants,
        };
        if ($minimal_keys) {
            my $minimal = _minimize_name($name);
            croak "Internal error: minimalist mode caused arguments",
                  "'$name' and '$seen{$minimal}' to clash"
                    if $seen{$minimal};
            $seen{$minimal} = $name;
        }
        $long_names{ _longestname(@variants) } = $name;
    }
    while (@options) {
        my ($name, $spec) = splice @options, 0, 2;
        my @variants = _get_variants($name);
        $options{$name} = {
            seq      => $seq_num++,
            src      => $spec,
            name     => $name,
            variants => \@variants,
        };
        if ($minimal_keys) {
            my $minimal = _minimize_name($name);
            croak "Internal error: minimalist mode caused arguments",
                  "'$name' and '$seen{$minimal}' to clash"
                    if $seen{$minimal};
            $seen{$minimal} = $name;
        }
        $long_names{ _longestname(@variants) } = $name;
    }
    _minimize_entries_of( \%long_names );

    my %STD_CONSTRAINT_FOR;
    #BEGIN {
        %STD_CONSTRAINT_FOR = (
            'string'    => sub { 1 }, # Always okay (matcher ensures this)
            'integer'   => sub { 1 }, # Always okay (matcher ensures this)
            '+integer'  => sub { $_[0] > 0 },
            '0+integer' => sub { $_[0] >= 0 },
              'number'  => sub { 1 }, # Always okay (matcher ensures this)
             '+number'  => sub { $_[0] > 0 },
            '0+number'  => sub { $_[0] >= 0 },
              'input'   => sub { $_[0] eq '-' || -r $_[0] },
              'output'  => sub { my (undef, $dir) = splitpath($_[0]);
                               $dir ||= '.';
                               $_[0] eq '-' ? 1 : -e $_[0] ? -w $_[0] : -w $dir
                           },
        );

        _make_equivalent(\%STD_CONSTRAINT_FOR,
              'integer' => [qw(   int   i )],
             '+integer' => [qw(  +int  +i )],
            '0+integer' => [qw( 0+int 0+i )],
               'number' => [qw(   num   n )],
              '+number' => [qw(  +num  +n )],
             '0+number' => [qw( 0+num 0+n )],
               'string' => [qw( str s )],
                'input' => [qw( in readable )],
               'output' => [qw( out writable writeable )],
        );
    #}

    # Extract Euclid information...
    ARG:
    for my $arg (values(%requireds), values(%options) ) {
        $arg->{src} =~ s{^ =for \s+ Euclid\b [^\n]* \s* (.*) \z}{}ixms
            or next ARG;
        my $info = $1;

        $arg->{is_repeatable} = $info =~ s{^ \s* repeatable \s*? $}{}xms;

        my @false_vals;
        while ($info =~ s{^ \s* false \s*[:=] \s* ([^\n]*)}{}xms) {
            my $regex = $1;
            1 while $regex =~ s/ \[ ([^]]*) \] /(?:$1)?/gxms;
            $regex =~ s/ (\s+) /$1.'[\\s\\0\\1]*'/egxms;
            push @false_vals, $regex;
        }
        if (@false_vals) {
            $arg->{false_vals} = '(?:' . join('|', @false_vals) .')';
        }

        while ($info =~ m{\G \s* (([^.]+)\.([^:=\s]+) \s*[:=]\s* ([^\n]*)) }gcxms) {
            my ($spec, $var, $field, $val) = ($1, $2, $3, $4);

            # Check for misplaced fields...
            if ($arg->{name} !~ m{\Q<$var>}xms) {
                _fail("Invalid constraint: $spec\n(No <$var> placeholder in argument: $arg->{name})");
            }

            # Decode...
            if ($field eq 'type.error') {
                $arg->{var}{$var}{type_error} = $val;
            }
            elsif ($field eq 'type') {
                my ($matchtype, $comma, $constraint)
                    = $val =~ m{(/(?:\.|.)+/ | [^,\s]+)\s*(?:(,))?\s*(.*)}xms;
                $arg->{var}{$var}{type} = $matchtype;

                if ($comma && length $constraint) {
                    ($arg->{var}{$var}{constraint_desc} = $constraint)
                        =~ s/\s*\b\Q$var\E\b\s*//g;
                    $constraint =~ s/\b\Q$var\E\b/\$_[0]/g;
                    $arg->{var}{$var}{constraint} = eval "sub{ $constraint }"
                        or _fail("Invalid .type constraint: $spec\n($@)");
                }
                elsif (length $constraint) {
                    $arg->{var}{$var}{constraint_desc} = $constraint;
                    $arg->{var}{$var}{constraint} = eval "sub{ \$_[0] $constraint }"
                        or _fail("Invalid .type constraint: $spec\n($@)");
                }
                else {
                    $arg->{var}{$var}{constraint_desc} = $matchtype;
                    $arg->{var}{$var}{constraint} =
                        $matchtype =~ m{\A\s*/.*/\s*\z}xms
                            ? sub {1}
                            : $STD_CONSTRAINT_FOR{$matchtype}
                        or _fail("Unknown .type constraint: $spec");
                }
            }
            elsif ($field eq 'default') {
                eval "\$val = $val; 1"
                    or _fail("Invalid .default value: $spec\n($@)");
                $arg->{var}{$var}{default} = $val;
                $arg->{has_defaults} = 1;
            }
            else {
                _fail("Unknown specification: $spec");
            }
        }
        if ($info =~ m{\G \s* ([^\s\0\1] [^\n]*) }gcxms) {
                _fail("Unknown specification: $1");
        }
    }

    # Build one-line representation of interface...
    my $arg_summary = join ' ',
                        sort { $requireds{$a}{seq} <=> $requireds{$b}{seq} }
                             keys %requireds;
    1 while $arg_summary =~ s/\[ [^][]* \]//gxms;
    $arg_summary .= lc " [$opt_name]" if $opt_name;
    $arg_summary =~ s/\s+/ /gxms;

    $pod =~ s{ ^(=head1 $NAME \s*) .*? (- .*) $EOHEAD }
            {$1 $prog_name $2}xms;

    $pod =~ s{ ^(=head1 $USAGE \s*) .*? (\s*) $EOHEAD }
            {$1 $prog_name $arg_summary $2}xms;

    $pod =~ s{ ^(=head1 $VERS    \s*) .*? (\s*) $EOHEAD }
            {$1 This document refers to $prog_name version $version $2}xms;


    # Handle standard args...
    if (grep { / --man /xms } @ARGV) {
        _print_and_exit($pod, 'paged');
    }
    elsif (first { $_ eq '--usage' } @ARGV) {
        print "Usage: $prog_name $arg_summary\n",
            "       $prog_name --help\n";
        exit;
    }
    elsif (first { $_ eq '--help' } @ARGV) {
        my $pod = "=head1 Usage:\n\n$prog_name $arg_summary\n\n";
        $pod .= "=head1 \L\u$req_name:\E\E\n\n$required\n\n"
            if ($required||q{}) =~ /\S/;
        $pod .= "=head1 \L\u$opt_name:\E\E\n\n$options\n\n"
            if ($options||q{}) =~ /\S/;
        _print_and_exit($pod);
    }
    elsif (first { $_ eq '--version' } @ARGV) {
        print "This is $prog_name version $version\n";
        if ($licence) {
            print "\n$licence\n";
        }
        exit;
    }

    # Convert arg specifications to regexes...

    _convert_to_regex(\%requireds);
    _convert_to_regex(\%options);

    # Build matcher...

    my @arg_list = (values(%requireds), values(%options));
    my $matcher = join '|', map { $_->{matcher} }
                    sort({$b->{name} cmp $a->{name}} grep {$_->{name} =~ /^[^<]/} @arg_list),
                    sort({$a->{seq} <=> $b->{seq}} grep {$_->{name} =~ /^[<]/} @arg_list);

    $matcher .= '|(?> (.+)) (?{ push @errors, $^N }) (?!)';

    $matcher = '(?:'.$matcher.')';

    # Report problems in parsing...
    *_bad_arglist = sub {
        my (@msg) = @_;
        my $msg = join q{}, @msg;
        $msg =~ tr/\0\1/ \t/;
        $msg =~ s/\n?\z/\n/xms;
        warn "$msg(Try: $prog_name --help)\n\n";
        exit 2;   # Traditional "bad arg list" value
    };

    # Run matcher...
    my $all_args_ref = { %options, %requireds };

    my $argv = join(q{ }, map {my $arg=$_; $arg=~tr/ \t/\0\1/; $arg} @ARGV);
    if (my $error = _doesnt_match($matcher, $argv, $all_args_ref)) {
        _bad_arglist($error);
    }

    # Check all requireds have been found...

    my @missing;
    for my $req ( keys %requireds ) {
        push @missing, "\t$req\n"
            if ! exists $ARGV{$req};
    }
    _bad_arglist('Missing required argument', (@missing==1?q{}:q{s}),
                 ":\n", @missing)
        if @missing;

    # Back-translate \0-quoted spaces and \1-quoted tabs...

    _rectify_args();

    # Check constraints and fill in defaults...

    _verify_args($all_args_ref);

    # Clean up @ARGV and %ARGV...

    @ARGV = ();   # Everything must have been parsed, so nothign left

    for my $arg_name (keys %ARGV) {
        # Flatten non-repeatables...

        my $vals = delete $ARGV{$arg_name};

        my $repeatable = $all_args_ref->{$arg_name}{is_repeatable};

        if ($repeatable) {
            pop @{$vals};
        }

        for my $val ( @{$vals} ) {
            my $var_count = keys %{$val};
            $val = $var_count == 0 ? 1                    # Boolean -> true
                 : $var_count == 1 ? (values %{$val})[0]  # Single var -> var's val
                 :                   $val                 # Otherwise keep hash
                 ;
            my $false_vals = $all_args_ref->{$arg_name}{false_vals};
            my @variants = _get_variants($arg_name);
            my %vars_opt_vals;
            for my $arg_flag ( @variants ) {
                my $variant_val = $val;
                if ($false_vals && $arg_flag =~ m{\A $false_vals \z}xms) {
                    $variant_val = $variant_val ? 0 : 1;
                }

                if ($repeatable) {
                    push @{$ARGV{$arg_flag}}, $variant_val;
                }
                else {
                    $ARGV{$arg_flag} = $variant_val;
                }
                $vars_opt_vals{$arg_flag} = $ARGV{$arg_flag} if $vars_prefix
            }

            if ($vars_prefix) {
                _minimize_entries_of( \%vars_opt_vals );
                my $maximal = _longestname(keys %vars_opt_vals);
                _export_var($vars_prefix, $maximal, $vars_opt_vals{$maximal});
                delete $long_names{$maximal};
            }
        }
    }

    if ($vars_prefix) {
        # export any unspecified options to keep use strict happy
        for my $opt_name (keys %long_names) {
            my $arg_name = $long_names{$opt_name};
            my $arg_info = $all_args_ref->{$arg_name};
            my $val;
            $val = [ ] if $arg_info->{is_repeatable}
                       or $arg_name =~ />\.\.\./;
            $val = { } if keys %{ $arg_info->{var} } > 1;
            _export_var($vars_prefix, $opt_name, $val);
        }
    }

    if ($minimal_keys) {
        _minimize_entries_of(\%ARGV);
    }
}

# ###### Utility subs #############

# Recursively remove decorations on %ARGV keys

sub AUTOLOAD {
    our $AUTOLOAD;
    $AUTOLOAD =~ s{.*::}{main::}xms;
    no strict 'refs';
    goto &$AUTOLOAD;
}

sub _minimize_name {
    my ($name) = @_;
    $name =~ s{[][]}{}gxms;   # remove all square brackets
    $name =~ s{\A \W+ ([\w-]*) .* \z}{$1}gxms;
    $name =~ s{-}{_}gxms;
    return $name;
}

sub _minimize_entries_of {
    my ($arg_ref) = @_;
    return if ref $arg_ref ne 'HASH';

    for my $old_key (keys %{$arg_ref}) {
        my $new_key = _minimize_name($old_key);
        $arg_ref->{$new_key} = delete $arg_ref->{$old_key};
    }

    return;
}


# Do match, recursively trying to expand cuddles...

sub _doesnt_match {
    use re 'eval';
    my ($matcher, $argv, $arg_specs_ref) = @_;

    our @errors;
    local @errors = ();
    %ARGV = ();

    $argv =~ m{\A (?: \s* $matcher )* \s* \z}xms;

    for my $error (@errors) {
        if ($error =~ m/\A ((\W) (\w) (\w+))/xms) {
            my ($bundle, $marker, $firstchar, $chars) = ($1, $2, $3, $4);
            $argv =~ s{\Q$bundle\E}{$marker$firstchar $marker$chars}xms;
            return if ! _doesnt_match($matcher, $argv, $arg_specs_ref);
        }
        ARG:
        for my $arg_spec_ref (values %{$arg_specs_ref}) {
            our $bad_type;
            local $bad_type;
            next ARG
                if $error !~ m/\A [\s\0\1]* ($arg_spec_ref->{generic_matcher})/xms
                || !$bad_type;

            my $msg;
            if ($msg = $bad_type->{type_error}) {
                my $var = $bad_type->{var};
                $var =~ s{\W+}{}gxms;
                $msg =~ s{(?<!<)\b$var\b|\b$var\b(?!>)}{$bad_type->{val}}gxms;
            }
            else {
                $msg = qq{$bad_type->{var} must be $bad_type->{type}}
                     . qq{ but the supplied value ("$bad_type->{val}") isn't.};
            }
            return qq{Invalid "$bad_type->{arg}" argument\n$msg};
        }
        return "Unknown argument: $error";
    }

    return;  # No error
}


sub _rectify_args {
    for my $arg_list (values %ARGV) {
        for my $arg (@{$arg_list}) {
            if (ref $arg eq 'HASH') {
                for my $var (values %{$arg}) {
                    if (ref $var eq 'ARRAY') {
                        tr/\0\1/ \t/ for @{$var};
                    }
                    else {
                        tr/\0\1/ \t/ for $var;
                    }
                }
            }
            else {
                if (ref $arg eq 'ARRAY') {
                    tr/\0\1/ \t/ for @{$arg};
                }
                else {
                    tr/\0\1/ \t/ for $arg;
                }
            }
        }
    }
}

sub _verify_args {
    my ($arg_specs_ref) = @_;

    ARG:
    for my $arg_name (keys %{$arg_specs_ref}) {
        # Skip non-existent/non-defaulting arguments
        next ARG if !exists $ARGV{$arg_name}
                 && !$arg_specs_ref->{$arg_name}{has_defaults};

        # Ensure all vars exist within arg...
        my @vars = @{$arg_specs_ref->{$arg_name}{placeholders}||[]};

        for my $index (0..$#{$ARGV{$arg_name}}) {
            my $entry = $ARGV{$arg_name}[$index];
            @{$entry}{@vars} = @{$entry}{@vars};

            # Get arg specs...
            my $arg_vars = $arg_specs_ref->{$arg_name}{var};

            VAR:
            for my $var (@vars) {

                # Check constraints on vars...
                if (exists $ARGV{$arg_name}) {

                    # Named vars...
                    if (ref $entry eq 'HASH' && defined $entry->{$var}) {
                        for my $val (ref $entry->{$var} eq 'ARRAY'
                                        ? @{$entry->{$var}}
                                        :   $entry->{$var}
                                    ) {
                            _bad_arglist( qq{Invalid "$arg_name" argument.\n},
                                        qq{<$var> must be },
                                        $arg_vars->{$var}{constraint_desc},
                                        qq{ but the supplied value ("$val") isn't.}
                                        )
                                if $arg_vars->{$var}{constraint}
                                && ! $arg_vars->{$var}{constraint}->($val);
                        }
                        next VAR;
                    }
                    # Unnamed vars...
                    elsif (ref $entry ne 'HASH' && defined $entry) {
                        for my $val (ref $entry eq 'ARRAY'
                                        ? @{$entry}
                                        :   $entry
                                    ) {
                            _bad_arglist( qq{Invalid "$arg_name" argument.\n},
                                        qq{<$var> must be },
                                        $arg_vars->{$var}{constraint_desc},
                                        qq{ but the supplied value ("$val") isn't.}
                                        )
                                if $arg_vars->{$var}{constraint}
                                && ! $arg_vars->{$var}{constraint}->($val);
                        }
                        next VAR;
                    }
                }

                # Assign placeholder defaults (if necessary)...
                next ARG if !exists $arg_specs_ref->{$arg_name}{var}{$var}{default};

                $entry->{$var}
                    = $arg_specs_ref->{$arg_name}{var}{$var}{default};
            }
        }

        # Handle defaults for missing args...
        if (!@{$ARGV{$arg_name}}) {
            for my $var (@vars) {
                # Assign defaults (if necessary)...
                next ARG if !exists $arg_specs_ref->{$arg_name}{var}{$var}{default};

                $ARGV{$arg_name}[0]{$var}
                    = $arg_specs_ref->{$arg_name}{var}{$var}{default};
            }
        }
    }
}

# Convert arg specification syntax to Perl regex syntax

my %STD_MATCHER_FOR;
BEGIN {
    %STD_MATCHER_FOR = (
        integer => '[+-]?\\d+',
        number  => '[+-]?(?:\\d+\\.?\\d*|\\.\\d+)(?:[eE][+-]?\d+)?',
        input   => '\S+',
        output  => '\S+',
        file    => '\S+',
        string  => '\S+',
        q{}     => '\S+',
    );

    _make_equivalent(\%STD_MATCHER_FOR,
        integer => [qw( int i +int +i 0+int 0+i +integer 0+integer )],
        number  => [qw( num n +num +n 0+num 0+n +number 0+number   )],
        input   => [qw( readable in )],
        output  => [qw( writable writeable out )],
        string  => [qw( str s )],
    );
}

sub _convert_to_regex {
    my ($args_ref) = @_;

    for my $arg_name ( keys %{$args_ref} ) {
        my $arg = $args_ref->{$arg_name};
        my $regex = $arg_name;

        # Quotemeta specials...
        $regex =~ s{([@#$^*()+{}?])}{\\$1}gxms;

        $regex = "(?:$regex)";

        # Convert optionals...
        1 while $regex =~ s/ \[ ([^]]*) \] /(?:$1)?/gxms;

        $regex =~ s/ (\s+) /$1.'[\\s\\0\\1]*'/egxms;
        my $generic = $regex;
        $regex =~ s{ < (.*?) >(\.\.\.|) }
                   { my ($var_name, $var_rep) = ($1, $2);
                     $var_name =~ s/(\s+)\[\\s\\0\\1]\*/$1/gxms;
                     my $type = $arg->{var}{$var_name}{type} || q{};
                     push @{$arg->{placeholders}}, $var_name;
                     my $matcher = $type =~ m{\A\s*/.*/\s*\z}xms
                                        ? eval "qr$type"
                                        : $STD_MATCHER_FOR{ $type }
                         or _fail("Unknown type ($type) in specification: $arg_name");
                     $var_rep              ? "(?:[\\s\\0\\1]*($matcher)(?{push \@{(\$ARGV{q{$arg_name}}||=[{}])->[-1]{q{$var_name}}}, \$^N}))+"
                     :
                     "(?:($matcher)(?{(\$ARGV{q{$arg_name}}||=[{}])->[-1]{q{$var_name}} = \$^N}))"
                   }gexms
            or do {
                $regex .= "(?{(\$ARGV{q{$arg_name}}||=[{}])->[-1]{q{}} = 1})";
            };

        if ($arg->{is_repeatable}) {
            $arg->{matcher}
                = "$regex (?:(?<!\\w)|(?!\\w)) (?{push \@{\$ARGV{q{$arg_name}}}, {} })";
        }
        else {
            $arg->{matcher}
                = "(??{exists\$ARGV{q{$arg_name}}?'(?!)':''}) "
                . ( $arg->{false_vals}
                    ? "(?:$arg->{false_vals} (?:(?<!\\w)|(?!\\w)) (?{\$ARGV{q{$arg_name}} ||= [{ q{} => 0 }] }) | $regex (?:(?<!\\w)|(?!\\w)) (?{\$ARGV{q{$arg_name}} ||= [{ q{} => 1}] }))"
                    : "$regex (?:(?<!\\w)|(?!\\w)) (?{\$ARGV{q{$arg_name}} ||= [{}] })"
                );
        }

        $generic =~ s{ < (.*?) > }
                     { my $var_name = $1;
                       $var_name =~ s/(\s+)\[\\s\\0\\1]\*/$1/gxms;
                       my $type = $arg->{var}{$var_name}{type} || q{};
                       my $type_error = $arg->{var}{$var_name}{type_error} || q{};
                       my $matcher = $type =~ m{\A\s*/.*/\s*\z}xms
                                        ? eval "qr$type"
                                        : $STD_MATCHER_FOR{ $type };
                       "(?:($matcher|([^\\s\\0\\1]+)"
                       . "(?{\$bad_type ||= "
                       . "{arg=>q{$arg_name},type=>q{$type},type_error=>q{$type_error}, var=>q{<$var_name>},val=>\$^N};})))"
                     }gexms;
        $arg->{generic_matcher} = $generic;
    }
    return;
}

sub _print_and_exit {
    my ($pod, $paged) = @_;

    if (-t *STDOUT and eval { require Pod::Text }) {
        if ($paged) {
            eval { require IO::Page } or eval { require IO::Pager::Page };
        }
        open my $pod_handle, '<', \$pod;
        my $parser = Pod::Text->new (sentence => 0, width => 78);
        $parser->parse_from_filehandle($pod_handle);
    }
    else {
        print $pod;
    }

    exit;
}

my $OPTIONAL;

BEGIN {
   $OPTIONAL = qr{ \[ [^[]* (?: (??{$OPTIONAL}) [^[]* )* \] }xms;
}

sub _get_variants {
    my @arg_desc = shift =~ m{ [^[|]+ (?: $OPTIONAL [^[|]* )* }gmxs;

    for (@arg_desc) {
        s{^ \s+ | \s+ $}{}gxms;
    }

    # Only consider first "word"...
    return $1 if $arg_desc[0] =~ m/\A (< [^>]+ >)/xms;

    $arg_desc[0] =~ s/\A ([^\s<]+) \s* (?: < .*)? \z/$1/xms;

    # Variants are all those with and without each optional component...
    my %variants;
    while (@arg_desc) {
        my $arg_desc_with    = shift @arg_desc;
        my $arg_desc_without = $arg_desc_with;

        if ($arg_desc_without =~ s/ \[ [^][]* \] //xms) {
            push @arg_desc, $arg_desc_without;
        }
        if ($arg_desc_with =~ m/ [[(] ([^][()]*) [])] /xms) {
            my $option = $1;
            for my $alternative ( split /\|/, $option ) {
                my $arg_desc = $arg_desc_with;
                $arg_desc =~ s{[[(] [^][()]* [])]}{$alternative}xms;
                push @arg_desc, $arg_desc;
            }
        }

        $arg_desc_with =~ s/[][]//gxms;
        $arg_desc_with =~ s/\b[^-\w] .* \z//xms;
        $variants{$arg_desc_with} = 1;
    }

    return keys %variants;
}


sub _longestname {
    return (sort { length $a <=> length $b || $a cmp $b } @_)[-1];
}


sub _export_var {
    my ($prefix, $key, $value) = @_;
    my $export_as = $prefix . $key;
    $export_as =~ s{\W}{_}gxms; # mainly for '-'
    my $callpkg = caller( 1 + ($Exporter::ExportLevel || 0) );
    no strict 'refs';
    *{"$callpkg\::$export_as"} = (ref $value) ? $value : \$value;
}


1; # Magic true value required at end of module
__END__

=head1 NAME

Getopt::Euclid - Executable Uniform Command-Line Interface Descriptions


=head1 VERSION

This document describes Getopt::Euclid version 0.2.0


=head1 SYNOPSIS

    use Getopt::Euclid;

    if ($ARGV{-i}) {
        print "Interactive mode...\n";
    }

    for my $x (0..$ARGV{-size}{h}-1) {
        for my $y (0..$ARGV{-size}{w}-1) {
            do_something_with($x, $y);
        }
    }

    __END__

    =head1 NAME

    yourprog - Your program here

    =head1 VERSION

    This documentation refers to yourprog version 1.9.4

    =head1 USAGE

        yourprog [options]  -s[ize]=<h>x<w>  -o[ut][file] <file>

    =head1 REQUIRED ARGUMENTS

    =over

    =item  -s[ize]=<h>x<w>

    Specify size of simulation

    =for Euclid:
        h.type:    int > 0
        h.default: 24
        w.type:    int >= 10
        w.default: 80

    =item  -o[ut][file] <file>

    Specify output file

    =for Euclid:
        file.type:    writable
        file.default: '-'

    =back

    =head1 OPTIONS

    =over

    =item  -i

    Specify interactive simulation

    =item  -l[[en][gth]] <l>

    Length of simulation [default: 99]

    =for Euclid:
        l.type:    int > 0
        l.default: 99

    =item --version

    =item --usage

    =item --help

    =item --man

    Print the usual program information

    =back

    Remainder of documentation starts here...

    =head1 AUTHOR

    Damian Conway (DCONWAY@CPAN.org)

    =head1 BUGS

    There are undoubtedly serious bugs lurking somewhere in this code.
    Bug reports and other feedback are most welcome.

    =head1 COPYRIGHT

    Copyright (c) 2005, Damian Conway. All Rights Reserved.
    This module is free software. It may be used, redistributed
    and/or modified under the terms of the Perl Artistic License
    (see http://www.perl.com/perl/misc/Artistic.html)


=head1 DESCRIPTION

Getopt::Euclid uses your program's own documentation to create a command-line
argument parser. This ensures that your program's documented interface and
its actual interface always agree.

To use the module, you simply write:

    use Getopt::Euclid;

at the top of your program.

When the module is loaded within a regular Perl program, it will:

=over

=item 1.

locate any POD in the same file,

=item 2.

extract information from that POD, most especially from
the C<=head1 REQUIRED ARGUMENTS> and C<=head1 OPTIONS> sections,

=item 3.

build a parser that parses the arguments and options the POD specifies,

=item 4.

remove the command-line arguments from C<@ARGV> and parse them, and

=item 5.

put the results in the global C<%ARGV> variable (or into specifically named
optional variables, if you request that -- see L<Exporting Option Variables>).

=back

As a special case, if the module is loaded within some other module
(i.e. from within a C<.pm> file), it still locates and extracts POD
information, but instead of parsing C<@ARGV> immediately, it caches that
information and installs an C<import()> subroutine in the caller module.
That new C<import()> acts just like Getopt::Euclid's own import, except
that it adds the POD from the caller module to the POD of the callee.

All of which just means you can put some or all of your CLI specification
in a module, rather than in the application's source file.
See L<Module Interface> for more details.

=head1 INTERFACE

=head2 Program Interface

You write:

    use Getopt::Euclid;

and your command-line is parsed automagically.

There are no options to pass. Getopt::Euclid doesn't export anything. It just
works.

=head2 Module Interface

You write:

    use Getopt::Euclid;

and your module will then act just like Getopt::Euclid (i.e. you can use
your module I<instead> of Getopt::Euclid>, except that your module's POD
will also be prepended to the POD of any module that loads yours. In
other words, you can use Getopt::Euclid in a module to create a standard
set of CLI arguments, which can then be added to any application simply
by loading your module.

To accomplish this trick Getopt::Euclid installs an C<import()>
subroutine in your module. If your module already has an C<import()>
subroutine defined, terrible things happen. So don't do that.


=head2 POD Interface

This is where all the action is.

When Getopt::Euclid is loaded in a non-C<.pm> file, it searches that file for
the following POD documentation:

=over

=item =head1 NAME

Getopt::Euclid ignores the name specified here. In fact, if you use the
standard C<--help>, C<--usage>, C<--man>, or C<--version> arguments (see
L<Standard arguments>), the module replaces the name specified in this
POD section with the actual name by which the program was invoked (i.e.
with C<$0>).

=item =head1 USAGE

Getopt::Euclid ignores the usage line specified here. If you use the
standard C<--help>, C<--usage>, or C<--man> arguments, the module
replaces the usage line specified in this POD section with a usage line
that reflects the actual interface that the module has constructed.

=item =head1 VERSION

Getopt::Euclid extracts the current version number from this POD section.
To do that it simply takes the first substring that matches
I<< <digit> >>.I<< <digit> >> or I<< <digit> >>_I<< <digit> >>. It also
accepts one or more additional trailing .I<< <digit> >> or _I<< <digit> >>,
allowing for multi-level and "alpha" version numbers such as:

    =head1 VERSION

    This is version 1.2.3

or:

    =head1 VERSION

    This is alpha release 1.2_34


=item =head1 REQUIRED ARGUMENTS

Getopt::Euclid uses the specifications in this POD section to build a
parser for command-line arguments. That parser requires that every one
of the specified arguments is present in any command-line invocation.
See L<Specifying arguments> for details of the specification syntax.

The actual headings that Getopt::Euclid can recognize here are:

    =head1 [STD|STANDARD] REQUIRED [ARG|ARGUMENT][S]


=item =head1 OPTIONS

Getopt::Euclid uses the specifications in this POD section to build a
parser for command-line arguments. That parser does not require that any
of the specified arguments is actually present in a command-line invocation.
Again, see L<Specifying arguments> for details of the specification syntax.

Typically a program will specify both C<REQUIRED ARGUMENTS> and C<OPTIONS>,
but there is no requirement that it supply both, or either.

The actual headings that Getopt::Euclid recognizes here are:

    =head1 [STD|STANDARD] OPTION[AL|S] [ARG|ARGUMENT][S]

=item =head1 COPYRIGHT

Getopt::Euclid prints this section whenever the standard C<--version> option
is specified on the command-line.

The actual heading that Getopt::Euclid recognizes here is any heading
containing any of the words "COPYRIGHT", "LICENCE", or "LICENSE".

=back

=head2 Specifying arguments

Each required or optional argument is specified in the POD in the following
format:

    =item ARGUMENT_STRUCTURE

    ARGUMENT_DESCRIPTION

    =for Euclid:
        ARGUMENT_OPTIONS
        PLACEHOLDER_CONSTRAINTS

=head3 Argument structure

=over

=item *

Each argument is specified as an C<=item>.

=item *

Any part(s) of the
specification that appear in square brackets are treated as optional.

=item *

Any parts that appear in angle brackets are placeholders for actual
values that must be specified on the command-line.

=item *

Any placeholder that is immediately followed by C<...> may be repeated as many
times as desired.

=item *

Any whitespace in the structure specifies that any amount of whitespace
(including none) is allowed at the same position on the command-line.

=item *

A vertical bar indicates the start of an alternative variant of the argument.

=back

For example, the argument specification:

    =item -i[n] [=] <file> | --from <file>

indicates that any of the following may appear on the command-line:

    -idata.txt    -i data.txt    -i=data.txt    -i = data.txt

    -indata.txt   -in data.txt   -in=data.txt   -in = data.txt

    --from data.text

as well as any other combination of whitespacing.

Any of the above variations would cause all three of:

    $ARGV{'-i'}
    $ARGV{'-in'}
    $ARGV{'--from'}

to be set to the string C<'data.txt'>.

You could allow the optional C<=> to also be an optional colon by specifying:

    =item -i[n] [=|:] <file>

Optional components may also be nested, so you could write:

    =item -i[n[put]] [=] <file>

which would allow C<-i>, C<-in>, and C<-input> as synonyms for this
argument and would set all three of C<$ARGV{'-i'}>, C<$ARGV{'-in'}>, and
C<$ARGV{'-input'}> to the supplied file name.

The point of setting every possible variant within C<%ARGV> is that this
allows you to use a single key (say C<$ARGV{'-input'}>, regardless of
how the argument is actually specified on the command-line.

=head2 Repeatable arguments

Normally Getopt::Euclid only accepts each specified argument once, the first
time it appears in @ARGV. However, you can specify that an argument may appear
more than once, using the C<repeatable> option:

    =item file=<filename>

    =for Euclid:
        repeatable

When an argument is marked repeatable the corresponding entry of
C<%ARGV> will not contain a hash reference, but rather an array of hash
references, each of which records each repetition.


=head2 Boolean arguments

If an argument has no placeholders it is treated as a boolean switch and it's
entry in C<%ARGV> will be true if the argument appeared in C<@ARGV>.

For a boolean argument, you can also specify variations that are I<false>, if
they appear. For example, a common idiom is:

    =item --print

    Print results

    =item --noprint

    Don't print results

These two arguments are effectively the same argument, just with opposite
boolean values. However, as specified above, only one of C<$ARGV{'--print'}>
and C<$ARGV{'--noprint'}> will be set.

As an alternative you can specify a single argument that accepts either value
and sets both appropriately:

    =item --[no]print

    [Don't] print results

    =for Euclid:
        false: --noprint

With this specification, if C<--print> appears in C<@ARGV>, then
C<$ARGV{'--print'}> will be true and C<$ARGV{'--noprint'}> will be false.
On the other hand, if C<--noprint> appears in C<@ARGV>, then
C<$ARGV{'--print'}> will be false and C<$ARGV{'--noprint'}> will be true.

The specified false values can follow any convention you wish:

    =item [+|-]print

    =for Euclid:
        false: -print

or:

    =item -report[_no[t]]

    =for Euclid:
        false: -report_no[t]

et cetera.

=head2 Multiple placeholders

An argument can have two or more placeholders:

    =item -size <h> <w>

The corresponding command line argument would then have to provide two values:

    -size 24 80

Multiple placeholders can optionally be separated by literal characters
(which must then appear on the command-line). For example:

    =item -size <h>x<w>

would then require a command-line of the form:

    -size 24x80

If an argument has two or more placeholders, the corresponding entry in
C<%ARGV> becomes a hash reference, with each of the placeholder names as one
key. That is, the above command-line would set both C<$ARGV{'-size'}{'h'}> and
C<$ARGV{'-size'}{'w'}>.

=head2 Optional placeholders

Placeholders can be specified as optional as well:

    =item -size <h> [<w>]

This specification then allows either:

    -size 24

or:

    -size 24 80

on the command-line. If the second placeholder value is not provided, the
corresponding C<$ARGV{'-size'}{'w'}> entry is set to C<undef>. See also
L<Placeholder defaults>.

=head2 Unflagged placeholders

If an argument consists of a single placeholder with no "flag" marking it:

    =item <filename>

then the corresponding entry in C<%ARG> will have a key the same as the
placeholder (including the surrounding angle brackets):

    if ($ARGV{'<filename>'} eq '-') {
        $fh = \*STDIN;
    }

The same is true for any more-complicated arguments that begin with a
placeholder:

    =item <h> [x <w>]

The only difference in the more-complex cases is that, if the argument
has any additional placeholders, the entire entry in C<%ARGV> becomes a hash:

    my $total_size
        = $ARGV{'<h>'}{'h'} * $ARGV{'<h>'}{'w'}

Note that, as in earlier multi-placeholder examples, the individual second-
level placeholder keys I<don't> retain their angle-brackets.

=head2 Repeated placeholders

Any placeholder that is immediately followed by C<...>, like so:

    =item -lib <files>...

    =item <offsets>...

    =for Euclid:
        offsets.type: integer > 0

will match as many times as possible, but at least once. Note that
this implies that an unconstrained repeated unflagged placeholder
(see L<Placeholder constraints> and L<Unflagged placeholders>) will
consume the rest of the command-line, and so should be specified last
in the POD.

If a placeholder is repeated, the corresponding entry in C<%ARGV>
will then be an array reference, with each individual placeholder match
in a separate element. For example:

    for my $lib (@{ $ARGV{'-lib'} }) {
        add_lib($lib);
    }

    warn "First offset is: $ARGV{'<offsets>'}[0]";
    my $first_offset = shift @{ $ARGV{'<offsets>'} };


=head2 Placeholder constraints

You can specify that the value provided for a particular placeholder
must satisfy a particular set of restrictions by using a C<=for Euclid>
block. For example:

    =item -size <h>x<w>

    =for Euclid:
        h.type: integer
        w.type: integer

specifies that both the C<< <h> >> and C<< <w> >> must be given integers.
You can also specify an operator expression after the type name:

    =for Euclid:
        h.type: integer > 0
        w.type: number <= 100

specifies that C<< <h> >> has to be given an integer that's greater than zero,
and that C<< <w> >> has to be given a number (not necessarily an integer)
that's no more than 100.

These type constraints have two alternative syntaxes:

    PLACEHOLDER.type: TYPE BINARY_OPERATOR EXPRESSION

as shown above, and the more general:

    PLACEHOLDER.type: TYPE [, EXPRESSION_INVOLVING(PLACEHOLDER)]

Using the second syntax, you could write the previous constraints as:

    =for Euclid:
        h.type: integer, h > 0
        w.type: number,  w <= 100

In other words, the first syntax is just sugar for the most common case of the
second syntax. The expression can be as complex as you wish and can refer to
the placeholder as many times as necessary:

    =for Euclid:
        h.type: integer, h > 0 && h < 100
        w.type: number,  Math::is_prime(w) || w % 2 == 0

Note that the expressions are evaluated in the C<package main> namespace,
so it's important to qualify any subroutines that are not in that namespace.
Furthermore, any subroutines used must be defined (or loaded from a module)
I<before> the C<use Getopt::Euclid> statement.

=head2 Standard placeholder types

Getopt::Euclid recognizes the following standard placeholder types:

    Name            Placeholder value...        Synonyms
    ============    ====================        ================

    integer         ...must be an integer       int    i

    +integer        ...must be a positive       +int   +i
                    integer
                    (same as: integer > 0)

    0+integer       ...must be a positive       0+int  0+i
                    integer or zero
                    (same as: integer >= 0)

    number          ...must be an number        num    n

    +number         ...must be a positive       +num   +n
                    number
                    (same as: number > 0)

    0+number        ...must be a positive       0+num  0+n
                    number or zero
                    (same as: number >= 0)

    string          ...may be any string        str    s
                    (default type)

    readable        ...must be the name         input  in
                    of a readable file

    writeable       ...must be the name         writable output out
                    of a writeable file
                    (or of a non-existent
                    file in a writeable
                    directory)

    /<regex>/       ...must be a string
                    matching the specified
                    pattern

=head2 Placeholder type errors

If a command-line argument's placeholder value doesn't satisify the specified
type, an error message is automatically generated. However, you can provide
your own message instead, using the C<.type.error> specifier:

    =for Euclid:
        h.type:        integer, h > 0 && h < 100
        h.type.error:  <h> must be between 0 and 100 (not h)

        w.type:        number,  Math::is_prime(w) || w % 2 == 0
        w.type.error:  Can't use w for <w> (must be an even prime number)

Whenever an explicit error message is provided, any occurrence within
the message of the placeholder's unbracketed name is replaced by the
placeholder's value (just as in the type test itself).


=head2 Placeholder defaults

You can also specify a default value for any placeholders that aren't
given values on the command-line (either because their argument isn't
provided at all, or because the placeholder is optional within the argument).

For example:

    =item -size <h>[x<w>]

    Set the size of the simulation

    =for Euclid:
        h.default: 24
        w.default: 80

This ensures that if no C<< <w> >> value is supplied:

    -size 20

then C<$ARGV{'-size'}{'w'}> is set to 80.

Likewise, of the C<-size> argument is omitted entirely, both
C<$ARGV{'-size'}{'h'}> and C<$ARGV{'-size'}{'w'}> are set to their
respective default values.

The default value can be any valid Perl compile-time expression:

    =item -pi=<pi value>

    =for Euclid:
        pi value.default: atan2(0,-1)

=head2 Argument cuddling

Getopt::Euclid allows any "flag" argument to be "cuddled". A flag
argument consists of a single non- alphanumeric character, followed by a
single alpha-numeric character:

    =item -v

    =item -x

    =item +1

    =item =z

Cuddling means that two or more such arguments can be concatenated after a
single common non-alphanumeric. For example:

    -vx

Note, however, that only flags with the same leading non-alphanumeric can be
cuddled together. Getopt::Euclid would not allow:

    -vxz

That's because cuddling is recognized by progressively removing the second
character of the cuddle. In other words:

    -vxz

becomes:

    -v -xz

which becomes:

    -v -x z

which will fail, unless a C<z> argument has also been specified.

On the other hand, if the argument:

    =item -e <cmd>

had been specified, the module I<would> accept:

    -vxe'print time'

as a cuddled version of:

    -v -x -e'print time'


=head2 Exporting Option Variables

By default, the module only stores arguments into the global %ARGV hash.
You can request that options are exported as variables into the calling package
the special C<':vars'> specifier:

    use Getopt::Euclid qw( :vars );

That is, if your program accepts the following arguments:

    -v
    --mode <modename>
    <infile>
    <outfile>
    --auto-fudge <factor>      (repeatable)
    --also <a>...
    --size <w>x<h>

Then these variables will be exported

    $ARGV_v
    $ARGV_mode
    $ARGV_infile
    $ARGV_outfile
    @ARGV_auto_fudge
    @ARGV_also
    %ARGV_size          # With entries $ARGV_size{w} and $ARGV_size{h}

For options that have multiple variants, only the longest variant is exported.

The type of variable exported (scalar, hash, or array) is determined by the
type of the corresponding value in C<%ARGV>. Command-line flags and arguments
that take single values will produce scalars, arguments that take multiple
values will produce hashes, and repeatable arguments will produce arrays.

If you don't like the default prefix of "ARGV_", you can specify your own,
such as "opt_", like this:

    use Getopt::Euclid qw( :vars<opt_> );

The major advantage of using exported variables is that any misspelling of
argument variables in your code will be caught at compile-time by
C<use strict>.


=head2 Standard arguments

Getopt::Euclid automatically provides four standard arguments to any
program that uses the module. The behaviours of these arguments are "hard-
wired" and cannot be changed, not even by defining your own arguments of
the same name.

The standard arguments are:

=over

=item --usage

This argument cause the program to print a short usage summary and exit.

=item --help

This argument cause the program to print a longer usage summary (including a
full list of required and optional arguments) and exit.

=item --man

This argument cause the program to print the complete POD documentation
for the program and exit. If the standard output stream is connected to
a terminal and the POD::Text module is available, the POD is formatted
before printing. If the IO::Page or IO::Pager::Page module is available,
the formatted documentation is then paged.

If standard output is not connected to a terminal or POD::Text is not
available, the POD is not formatted.

=item --version

This argument causes the program to print the version number of the
program (as specified in the C<=head1 VERSION> section of the POD) and
any copyright information (as specified in the C<=head1 COPYRIGHT>
POD section) and then exit.

=back

=head2 Minimalist keys

By default, the keys of C<%ARGV> will match the program's interface
exactly. That is, if your program accepts the following arguments:

    -v
    --mode <modename>
    <infile>
    <outfile>
    --auto-fudge

Then the keys that appear in C<%ARGV> will be:

    '-v'
    '--mode'
    '<infile>'
    '<outfile>'
    '--auto-fudge'

In some cases, however, it may be preferable to have Getopt::Euclid set
up those hash keys without "decorations". That is, to have the keys of
C<%ARGV> be simply:

    'v'
    'mode'
    'infile'
    'outfile'
    'auto_fudge'

You can arrange this by loading the module with the special C<':minimal_keys'>
specifier:

    use Getopt::Euclid qw( :minimal_keys );

Note that, in rare cases, using this mode may cause you to lose
data (for example, if the interface specifies both a C<--step> and
a C<< <step> >> option). The module throws an exception if this happens.


=head1 DIAGNOSTICS

=head2 Compile-time diagnostics

The following diagnostics are mainly caused by problems in the POD
specification of the command-line interface:

=over

=item Getopt::Euclid was unable to access POD

Something is horribly wrong. Getopt::Euclid was unable to read your
program to extract the POD from it. Check your program's permissions,
though it's a mystery how I<perl> was able to run the program in the
first place, if it's not readable.

=item .pm file cannot define an explicit import() when using Getopt::Euclid

You tried to define an C<import()> subroutine in a module that was also
using Getopt::Euclid. Since the whole point of using Getopt::Euclid in a
module is to have it build an C<import()> for you, supplying your own
C<import()> as well defeats the purpose.


=item Unknown specification: %s

You specified something in a C<=for Euclid> section that
Getopt::Euclid didn't understand. This is often caused by typos, or by
reversing a I<placeholder>.I<type> or I<placeholder>.I<default>
specification (that is, writing I<type>.I<placeholder> or
I<default>.I<placeholder> instead).

=item Unknown type (%s) in specification: %s

=item Unknown .type constraint: %s

Both these errors mean that you specified a type constraint that
Getopt::Euclid didn't recognize. This may have been a typo:

    =for Euclid
        count.type: inetger

or else the module simply doesn't know about the type you specified:

    =for Euclid
        count.type: complex

See L<Standard placeholder types> for a list of types that Getopt::Euclid
I<does> recognize.

=item Invalid .type constraint: %s

You specified a type constraint that isn't valid Perl. For example:

    =for Euclid
        max.type: integer not equals 0

instead of:

    =for Euclid
        max.type: integer != 0

=item Invalid .default value: %s

You specified a default value that isn't valid Perl. For example:

    =for Euclid
        curse.default: *$@!&

instead of:

    =for Euclid
        curse.default: '*$@!&'

=item Invalid constraint: %s (No <%s> placeholder in argument: %s)

You attempted to define a C<.type> constraint for a placeholder that
didn't exist. Typically this is the result of the misspelling of a
placeholder name:

    =item -foo <bar>

    =for Euclid:
        baz.type: integer

or a C<=for Euclid:> that has drifted away from its argument:

    =item -foo <bar>

    =item -verbose

    =for Euclid:
        bar.type: integer


=item Getopt::Euclid loaded a second time

You tried to load the module twice in the same program.
Getopt::Euclid doesn't work that way. Load it only once.

=item Unknown mode ('%s')

The only argument that a C<use Getopt::Euclid> command accepts is
C<':minimal_keys'> (see L<Minimalist keys>). You specified something
else instead (or possibly forgot to put a semicolon after C<use
Getopt::Euclid>).

=item Internal error: minimalist mode caused arguments '%s' and '%s' to clash

Minimalist mode removes certain characters from the keys hat are
returned in C<%ARGV>. This can mean that two command-line options (such
as C<--step> and C<< <step> >>) map to the same key (i.e. C<'step'>).
This in turn means that one of the two options has overwritten the other
within the C<%ARGV> hash. The program developer should either turn off
C<':minimal_keys'> mode within the program, or else change the name of
one of the options so that the two no longer clash.

=back

=head2 Run-time diagnostics

The following diagnostics are caused by problems in parsing the command-line

=over

=item Missing required argument(s): %s

At least one argument specified in the C<REQUIRED ARGUMENTS> POD section
wasn't present on the command-line.


=item Invalid %s argument. %s must be %s but the supplied value (%s) isn't.

Getopt::Euclid recognized the argument you were trying to specify on the
command-line, but the value you gave to one of that argument's placeholders
was of the wrong type.


=item Unknown argument: %s

Getopt::Euclid didn't recognize an argument you were trying to specify on the
command-line. This is often caused by command-line typos or an incomplete
interface specification.

=back


=head1 CONFIGURATION AND ENVIRONMENT

Getopt::Euclid requires no configuration files or environment variables.


=head1 DEPENDENCIES

=over

=item *

File::Spec::Functions

=item *

List::Util

=back

=head1 INCOMPATIBILITIES

None reported.


=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-getopt-euclid@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.


=head1 AUTHOR

Damian Conway  C<< <DCONWAY@cpan.org> >>


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2005, Damian Conway C<< <DCONWAY@cpan.org> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.


=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
