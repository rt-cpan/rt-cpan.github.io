use List::Util 'max';

$PACKAGE='main';

sub who
{
    my ($pack, $re_str) = @_;
    $re_str ||= '.?';
    my $re = qr/$re_str/;
    no strict;
    if ($re_str =~ /^[\$\@\%\&]/) {
        ## sigil given -- match it
        sort grep /$re/, map {
            my $name = $pack.'::'.$_;
            (defined *{$name}{HASH} ? '%'.$_ : (),
             defined *{$name}{ARRAY} ? '@'.$_ : (),
             defined *{$name}{CODE} ? $_ : (),
             defined ${$name} ? '$'.$_ : (), # ?
         )
        } grep !/::$/ && !/^(?:_<|[^\w])/ && /$re/, keys %{$pack.'::'};
    } else {
        ## no sigil -- don't match it
        sort map {
            my $name = $pack.'::'.$_;
            (defined *{$name}{HASH} ? '%'.$_ : (),
             defined *{$name}{ARRAY} ? '@'.$_ : (),
             defined *{$name}{CODE} ? $_ : (),
             defined ${$name} ? '$'.$_ : (), # ?
         )
        } grep !/::$/ && !/^(?:_<|[^\w])/ && /$re/, keys %{$pack.'::'};
    }
}

sub repl_size
{
    eval { require Devel::Size };
    if ($@) {
        print "Size requires Devel::Size.\n";
    } else {
        *repl_size = sub {
            no strict 'refs';
            ## XXX: C&P from repl_who:
            my ($pkg, $re) = split ' ', shift || '';
            if ($pkg =~ /^\/(.*)\/?$/) {
                $pkg = $PACKAGE;
                $re = $1;
            } elsif (!$re && !%{$pkg.'::'}) {
                $re = $pkg;
                $pkg = $PACKAGE;
            } else {
                $re = '';
                $pkg = $PACKAGE;
            }
            print STDERR "pkg=$pkg, re=$re\n";
            my @who = who($pkg, $re);
            my $len = max(3, map { length } @who) + 4;
            my $fmt = '%-'.$len."s%10d\n";
            print 'Var', ' ' x ($len + 2), "Bytes\n";
            print '-' x ($len-4), ' ' x 9, '-' x 5, "\n";
            local $SIG{__WARN__} = sub {};
            for (@who) {
                next unless /^[\$\@\%\&]/; # skip subs.
                my $res = eval "no strict; package $pkg; Devel::Size::total_size \\$_;";
                print "aiee: $@\n" if $@;
                printf $fmt, $_, $res;
            }
        };
        goto &repl_size;
    }
}

repl_size;
repl_size;
