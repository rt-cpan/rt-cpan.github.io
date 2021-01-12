use strict;
use warnings;

use Config;

showd('use64bitall');
showd('use64bitint');
showd('usecrosscompile');
showd('uselongdouble');
showd('usemorebits');
print "\n";

sub showd {
    my ($key) = @_;
    printf "Config%-20s = %s\n", "{'$key'}",
      (defined($Config{$key}) ? "'$Config{$key}'" : 'undef');
}

my $h = hd();
print "h = '$h'\n";

sub hd { highval( sub{
  my $d2 = sprintf('%.f', $_[0]);
  my $d3 = sprintf('%.f', $_[0] - 1);

  $d2 ne $d3;
}); }

sub highval {
    my ($ok) = @_;

    my $x = 1;
    my $f = 1;

    for (1..100) {
        my $y = $x * 10;

        print "Part 1: C=$_, X='$x', Y='$y'\n";

        unless ($ok->($y)) {
            $f = 0;
            print "Part 1: last\n\n";
            last;
        }

        $x = $y;
    }

    return -1 if $f;

    my $r = $x;

    for (1..1000) {
        my $y = $x + $r;

        print "Part 2: C=$_, R='$r', X='$x', Y='$y'\n";

        unless ($ok->($y)) {
            if ($r <= 1) {
                $r = 0;
                print "Part 2: last\n\n";
                last;
            }

            $r /= 10;
            print "Part 2: C=$_, R='$r' (decreased R)\n";
            next;
        }

        $x += $r;
    }

    return -2 if $r;

    return $x;
}

1;
