use Devel::Size;

$PACKAGE='main';

sub who
{
    my ($pack) = @_;
    sort map {
        my $name = $pack.'::'.$_;
        (defined *{$name}{HASH} ? '%'.$_ : (),
         defined *{$name}{ARRAY} ? '@'.$_ : (),
         defined *{$name}{CODE} ? $_ : (),
         defined ${$name} ? '$'.$_ : (),          # ?
    ) } grep !/::$/ && !/^(?:_<|[^\w])/ && /$re/, keys %{$pack.'::'};
}

sub repl_size
{
    no strict 'refs';
    ## XXX: C&P from repl_who:
    my ($pkg, $re) = split ' ', shift || '';
    $re = '';
    $pkg = $PACKAGE;
    my @who = who($pkg, $re);
    local $SIG{__WARN__} = sub {};
    for (@who) {
        next unless /^[\$\@\%\&]/; # skip subs.
        my $res = eval "no strict; package $pkg; Devel::Size::total_size \\$_;";
    }
}

repl_size;
repl_size;
